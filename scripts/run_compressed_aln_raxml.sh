#!/bin/bash
#PBS -N Beta_raxmlHPC-MPI
#PBS -l nodes=1:ppn=64
#PBS -l walltime=999:00:00

#@USAGE: qsub -V -q epyc run_compressed_aln_raxml.sh

# RAXML Manual: https://cme.h-its.org/exelixis/resource/download/NewManual.pdf
#clear

#BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"
BASEDIR=$1

RAXMLHPCMPI=$BASEDIR"/scripts/standard-RAxML/raxmlHPC-MPI"
RAXML=/usr/local/bin/raxml-ng-mpi

echo "# Creating output directory"
mkdir -p $BASEDIR"/analysis/raxml"

echo "# Starting to create RAxML trees"
echo ""


for virus in MERS SARS SARS2 NL63 HKU1 229E OC43; do
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

             echo mpirun -np 64 $RAXMLHPCMPI -m GTRGAMMA -s $gene -p 12345 -n $f -N 2 -w $BASEDIR/analysis/raxml/$virus
             mpirun -np 64 $RAXMLHPCMPI -m GTRGAMMA -s $gene -p 12345 -n $f -N 2 -w $BASEDIR/analysis/raxml/$virus
             
             #raxml-ng-mpi --msa {input.in_comp} --model GTR+G

             #$RAXML --msa $gene --model GTR+G+I --threads 16 --prefix $BASEDIR/analysis/raxml/$virus/

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

exit 0

# End of file

