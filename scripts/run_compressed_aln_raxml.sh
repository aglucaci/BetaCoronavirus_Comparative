#!/bin/bash
#PBS -N raxmlHPC-MPI

#@USAGE: qsub -V -l nodes=1:ppn=16 -q epyc run_compressed_aln_raxml.sh

# RAXML Manual: https://cme.h-its.org/exelixis/resource/download/NewManual.pdf
clear

BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"

RAXMLHPCMPI=$BASEDIR"/scripts/standard-RAxML/raxmlHPC-MPI"
RAXMLAVX=$BASEDIR"/scripts/standard-RAxML/raxmlHPC-AVX"

echo "# Creating output directory"
mkdir -p $BASEDIR"/analysis/raxml"

echo "# Starting to create RAxML trees"
echo ""


for virus in MERS SARS SARS2; do
    FILES=$BASEDIR/analysis/Alignments/$virus/compressed/*.fasta
    mkdir -p $BASEDIR"/analysis/raxml/"$virus

    for gene in $FILES; do

        f="$(basename -- $gene)"
        echo "Processing (gene): "$gene
        #echo "Basename: "$f       
        
        if [ -s $BASEDIR"/analysis/raxml/"$virus"/RAxML_bestTree."$f ];
        then
            echo "Tree exists"
        else
             #echo $RAXMLAVX -m GTRGAMMA -s $gene -p 12345 -n $f
             #$RAXMLAVX -m GTRGAMMA -s $gene -p 12345 -n $f

             echo mpirun -np 16 $RAXMLHPCMPI -m GTRGAMMA -s $gene -p 12345 -n $f 
             mpirun -np 16 $RAXMLHPCMPI -m GTRGAMMA -s $gene -p 12345 -n $f -N 10 -w $BASEDIR/analysis/raxml/$virus
             
             # Move trees
             #mv $BASEDIR/scripts/RAxML* $BASEDIR/analysis/raxml/$virus 
        fi

        #For debugging
        #exit 1

    done
    #end inner for
    
    echo ""
    
    ## Move trees
    #mv $BASEDIR/scripts/RAxML* $BASEDIR/analysis/raxml/$virus 
done

# End of file

