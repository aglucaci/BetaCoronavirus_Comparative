#!/bin/bash
#PBS -N HCoV_tn93_codons
#PBS -l walltime=999:00:00

#@USAGE: qsub -V -q epyc tn93_codons.sh
#clear

#BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"
BASEDIR=$1

TN=$BASEDIR"/scripts/tn93/tn93"
DIR=$BASEDIR"/analysis/Alignments"
MAFFT="/usr/bin/mafft"

echo "## Starting TN93 calculations"
echo "## Software: "$TN
echo "## Input directory: "$DIR
echo ""

for virus in MERS SARS SARS2 229E OC43 NL63 HKU1; do
    SAVE=$DIR/$virus/compressed/tn93
    echo "SAVE Directory: "$SAVE
    mkdir -p $SAVE
    
    
    for FILE in $DIR/$virus/compressed/*.fasta; do
        f="$(basename -- $FILE)"
        
        #echo "    Aligning nucleotide file (to output) : "$FILE"_aligned.fasta"
   
        #if [ -s $FILE"_aligned.fasta" ];
        #then 
        #    echo "    Alignment file exists"
        #else
        #    echo $MAFFT --auto $FILE > $FILE"_aligned.fasta"
        #    $MAFFT --auto $FILE > $FILE"_aligned.fasta"
        #fi
 
        echo "    Performing TN93 calculations: "$SAVE"/"$f".dst"

        if [ -s $SAVE"/"$f".dst" ];
        then
            echo "TN93 calculations file exists"
        else
            echo $TN -t 1 -o $SAVE"/"$f".dst" $FILE
            $TN -t 1 -o $SAVE"/"$f".dst" $FILE
        fi
        echo ""

    done

    echo ""
done


# end of file





