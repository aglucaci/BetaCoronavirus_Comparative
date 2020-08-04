#!/bin/bash
#@USAGE: qsub -V -q epyc tn93.sh
clear

BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"

TN=$BASEDIR"/scripts/tn93/tn93"
DIR=$BASEDIR"/analysis/Alignments"
MAFFT="/usr/bin/mafft"

echo "## Starting TN93 calculations"
echo "## Software: "$TN
echo "## Input directory: "$DIR
echo ""

for virus in MERS SARS SARS2; do
    SAVE=$DIR/$virus/nucleotide/tn93
    echo "SAVE Directory: "$SAVE
    mkdir -p $SAVE


    for FILE in $DIR/$virus/nucleotide/*.fas; do
        f="$(basename -- $FILE)"

        echo "    Aligning nucleotide file (to output) : "$FILE"_aligned.fasta"

        if [ -s $FILE"_aligned.fasta" ];
        then
            echo "    Alignment file exists"
        else
            echo $MAFFT --auto $FILE > $FILE"_aligned.fasta"
            $MAFFT --auto $FILE > $FILE"_aligned.fasta"
        fi
 
        echo "    Performing TN93 calculations: "$SAVE"/"$f".dst"

        if [ -s $SAVE"/"$f".dst" ];
        then
            echo "TN93 calculations file exists"
        else
            echo $TN -t 1 -o $SAVE"/"$f".dst" $FILE"_aligned.fasta"
            $TN -t 1 -o $SAVE"/"$f".dst" $FILE"_aligned.fasta"
        fi
        echo ""

    done

    echo ""
done


# end of file


#Helper command to clear out results
# rm -f ../analysis/Alignments/MERS/nucleotide/*.fasta
# rm -f ../analysis/Alignments/SARS/nucleotide/*.fasta
# rm -f ../analysis/Alignments/SARS2/nucleotide/*.fasta

# rm -r ../analysis/Alignments/MERS/nucleotide/tn93
# rm -r ../analysis/Alignments/SARS/nucleotide/tn93
# rm -r ../analysis/Alignments/SARS2/nucleotide/tn93
