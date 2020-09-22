#!/bin/bash
#PBS -N Beta_FastTree
#PBS -l walltime=999:00:00

#@USAGE: qsub -V -q epyc run_compressed_aln_FastTree.sh

#BASEDIR=$1
BASEDIR=/home/aglucaci/BetaCoronavirus_Comparative

#RAXMLHPCMPI=$BASEDIR"/scripts/standard-RAxML/raxmlHPC-MPI"
#RAXML=/usr/local/bin/raxml-ng-mpi

FASTTREE="/usr/local/bin/FastTree"

echo "# Creating output directory"
mkdir -p $BASEDIR"/analysis/FastTree"

echo "# Starting to create FastTree trees"
echo ""

for virus in MERS SARS SARS2 NL63 HKU1 229E OC43; do
    FILES=$BASEDIR/analysis/Alignments/$virus/compressed/*.fasta
    mkdir -p $BASEDIR"/analysis/FastTree/"$virus

    for gene in $FILES; do

        f="$(basename -- $gene)"
        echo "Processing (gene): "$gene
        #echo "Basename: "$f       
        
        OUTPUTTREE=$BASEDIR"/analysis/FastTree/"$virus"/FastTree_bestTree."$f       
 
        if [ -s $OUTPUTTREE ];
        then
            echo "Tree exists"
        else
             #$RAXMLAVX -m GTRGAMMA -s $gene -p 12345 -n $f

             #echo mpirun -np 16 $RAXMLHPCMPI -m GTRGAMMA -s $gene -p 12345 -n $f -N 2 -w $BASEDIR/analysis/raxml/$virus
             #mpirun -np 16 $RAXMLHPCMPI -m GTRGAMMA -s $gene -p 12345 -n $f -N 2 -w $BASEDIR/analysis/raxml/$virus
             
             #raxml-ng-mpi --msa {input.in_comp} --model GTR+G

             #$RAXML --msa $gene --model GTR+G+I --threads 16 --prefix $BASEDIR/analysis/raxml/$virus/

             # Move trees
             #mv $BASEDIR/scripts/RAxML* $BASEDIR/analysis/raxml/$virus 
        
             $FASTTREE -gtr -gamma -nt < $gene > $OUTPUTTREE 

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

