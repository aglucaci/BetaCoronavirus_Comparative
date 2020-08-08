#!/bin/bash
#PBS -N RELAX_Contrast-FEL
#PBS -l nodes=1:ppn=28
#PBS -l walltime=99:0:0:0

#@Author: Alexander G Lucaci
#@Usage: qsub -V -q epyc RELAX_CONTRAST-FEL.sh

clear

BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"

GENES=$BASEDIR"/analysis/Combined/combined_codon_alignment/*.fasta"
TREEDIR=$BASEDIR"/analysis/Combined/combined_codon_alignment_trees/partitioned_lineages"

HYPHYMPI=$BASEDIR"/scripts/hyphy-develop/HYPHYMPI"
HYPHY=$BASEDIR"/scripts/hyphy-develop/HYPHYMP"
RES=$BASEDIR"/scripts/hyphy-develop/res"

# output directory
OUTPUTDirRELAX=$BASEDIR"/analysis/Combined/RELAX"
OUTPUTDirCFEL=$BASEDIR"/analysis/Combined/Contrast-FEL"

echo "## Creating RELAX save directory to: "$OUTPUTDirRELAX
echo "## Creating Contrast-FEL save directory to: "$OUTPUTDirCFEL

mkdir -p $OUTPUTDirRELAX
mkdir -p $OUTPUTDirCFEL


for CodonAln in $GENES; do
    echo "# Input Alignment: "$CodonAln
    f="$(basename -- $CodonAln)"
    #echo $f

    Tree=$TREEDIR"/RAxML_bestTree."$f".partitioned.nwk"
    echo "# Partitioned Newick Tree: "$Tree

    
    OUTPUTJSONRELAX=$OUTPUTDirRELAX"/"$f".RELAX.json"
    if [ -s $OUTPUTJSONRELAX ];
    then
        echo 1
    else
        echo "# Saving RELAX Output JSON to: "$OUTPUTJSONRELAX
        echo mpirun -np 28 $HYPHYMPI LIBPATH=$RES RELAX --alignment $CodonAln --tree $Tree --reference SARS --models All --mode "Group mode"
        mpirun -np 28 $HYPHYMPI LIBPATH=$RES RELAX --alignment $CodonAln --tree $Tree --reference SARS --models All --mode "Group mode"
    fi

    OUTPUTJSONCFEL=$OUTPUTDirRELAX"/"$f".CFEL.json"
    if [ -s $OUTPUTJSONCFEL ];
    then
        echo 2
    else
        echo "# Saving Contrast-FEL Output JSON to: "$OUTPUTJSONCFEL
        echo mpirun -np 28 $HYPHYMPI LIBPATH=$RES CONTRAST-FEL --alignment $CodonAln --tree $Tree --branch-set SARS2
        mpirun -np 28 $HYPHYMPI LIBPATH=$RES CONTRAST-FEL --alignment $CodonAln --tree $Tree --branch-set SARS2

    fi

    echo ""
done
