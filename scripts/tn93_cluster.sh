#!/bin/bash
#PBS -N HCoV_TN93_Cluster
#PBS -l walltime=999:00:00
#@USAGE: qsub -V -q epyc tn93_cluster.sh
clear

#BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"

BASEDIR=$1

TNCluster=$BASEDIR"/scripts/tn93/tn93-cluster"
DIR=$BASEDIR"/analysis/Alignments"
MAFFT="/usr/bin/mafft"

echo "## Starting TN93 Cluster calculations"
echo "## Software: "$TNCluster
echo "## Input directory: "$DIR
echo ""

for virus in MERS SARS SARS2 229E OC43 NL63 HKU1; do
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
            $TNCluster -t 0.004 -c all -m json -o $SAVE"/"$f"_0004.dst" $FILE
            $TNCluster -t 0.008 -c all -m json -o $SAVE"/"$f"_0008.dst" $FILE
            $TNCluster -t 0.0012 -c all -m json -o $SAVE"/"$f"_0012.dst" $FILE
            $TNCluster -t 0.0016 -c all -m json -o $SAVE"/"$f"_0016.dst" $FILE
            $TNCluster -t 0.002 -c all -m json -o $SAVE"/"$f"_002.dst" $FILE
        fi
        echo ""

    done

    echo ""
done


# end of file





