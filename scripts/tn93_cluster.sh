#!/bin/bash
#PBS -N TN93_Cluster
#@USAGE: qsub -V -q epyc tn93_cluster.sh
clear

BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"

TNCluster=$BASEDIR"/scripts/tn93/tn93-cluster"
DIR=$BASEDIR"/analysis/Alignments"
MAFFT="/usr/bin/mafft"

echo "## Starting TN93 Cluster calculations"
echo "## Software: "$TNCluster
echo "## Input directory: "$DIR
echo ""

for virus in MERS SARS SARS2; do
    SAVE=$DIR/$virus/compressed/tn93-cluster
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
 
        echo "    Performing TN93 Cluster calculations: "$SAVE"/"$f".dst"

        if [ -s $SAVE"/"$f".dst" ];
        then
            echo "TN93 Cluster calculations file exists"
        else
            echo $TNCluster -t 0.0004 -c all -m json -o $SAVE"/"$f".dst" $FILE
            $TNCluster -t 0.004 -c all -m json -o $SAVE"/"$f".dst" $FILE
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



