#!/bin/bash
#PBS -N Run_ModelTest
#PBS -l nodes=1:ppn=8
#@Usage: qsub -V -q epyc run_modeltest.sh

clear

BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"
MODELTEST="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020/scripts/modeltest/bin/modeltest-ng-mpi"

mkdir -p $BASEDIR"/analysis/ModelTest"

for virus in MERS SARS SARS2; do
    FILES=$BASEDIR/analysis/Alignments/$virus/compressed/*.fasta

    OUTPUTDIR=$BASEDIR"/analysis/ModelTest/"$virus
    mkdir -p $OUTPUTDIR

    for gene in $FILES; do

        f="$(basename -- $gene)"
        echo "Processing (gene): "$gene
        #echo "Basename: "$f  

        if [ -s $OUTPUTDIR"/"$f".ModelTest.out" ];
        then
            echo "ModelTest output exists"
        else
            echo mpirun -np 8 $MODELTEST -i $gene -t ml -o $OUTPUTDIR"/"$f".ModelTest"
            mpirun -np 8 $MODELTEST -i $gene -t ml -o $OUTPUTDIR"/"$f".ModelTest"
        fi

    done
    #end inner for

    echo ""

done

# END OF FILE




