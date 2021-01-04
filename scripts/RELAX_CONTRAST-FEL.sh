#!/bin/bash
#PBS -N HCoV_RELAX_Contrast-FEL
#PBS -l nodes=1:ppn=64
#PBS -l walltime=999:00:00

#@Author: Alexander G Lucaci
#@Usage: qsub -V -q epyc RELAX_CONTRAST-FEL.sh

#clear

#BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"
BASEDIR=$1

GENES=$BASEDIR"/analysis/Combined/combined_codon_alignment/*.fasta"
TREEDIR=$BASEDIR"/analysis/Combined/combined_codon_alignment_trees/partitioned_lineages"

HYPHYMPI=$BASEDIR"/scripts/hyphy-develop/HYPHYMPI"
HYPHY=$BASEDIR"/scripts/hyphy-develop/HYPHYMP"
RES=$BASEDIR"/scripts/hyphy-develop/res"

# output directory
OUTPUTDirRELAX=$BASEDIR"/analysis/Combined/RELAX"
OUTPUTDirCFEL=$BASEDIR"/analysis/Combined/Contrast-FEL"

RELAX=$BASEDIR"/scripts/hyphy-develop/res/TemplateBatchFiles/SelectionAnalyses/RELAX.bf"
CFEL=$BASEDIR"/scripts/hyphy-develop/res/TemplateBatchFiles/SelectionAnalyses/contrast-fel.bf"

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
        echo mpirun -np 64 $HYPHYMPI LIBPATH=$RES $RELAX --alignment $CodonAln --tree $Tree --reference SARS --models All --mode "Group mode" --output $OUTPUTJSONRELAX
        mpirun -np 64 $HYPHYMPI LIBPATH=$RES $RELAX --alignment $CodonAln --tree $Tree --reference-group SARS --models All --mode "Group mode" --output $OUTPUTJSONRELAX
    fi

    OUTPUTJSONCFEL=$OUTPUTDirCFEL"/"$f".CFEL.json"
    if [ -s $OUTPUTJSONCFEL ];
    then
        echo 2
    else
        echo "# Saving Contrast-FEL Output JSON to: "$OUTPUTJSONCFEL
        echo mpirun -np 64 $HYPHYMPI LIBPATH=$RES CONTRAST-FEL --alignment $CodonAln --tree $Tree --branch-set SARS2 --output $OUTPUTJSONCFEL
        mpirun -np 64 $HYPHYMPI LIBPATH=$RES CONTRAST-FEL --alignment $CodonAln --tree $Tree --branch-set SARS2 --output $OUTPUTJSONCFEL

    fi

    echo ""
done
