#!/bin/bash
#PBS -N Beta_lineage_annotator
clear

#BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"
BASEDIR=$1

HYPHY=$BASEDIR"/hyphy/hyphy"
RES=$BASEDIR"/hyphy/res"
ANNOTATOR=$BASEDIR"/scripts/annotator.bf"

# Takes in the --tree and the --output

#FILES=$BASEDIR"/analysis/Combined/combined_codon_alignment_trees/*bestTree*"

BASEDIR=$1
FILES="/Users/user/Documents/ComparativeAnalyses_Coronavirus/October2020/COMBINED_TREES/*.tree"

#HYPHYMPI=$BASEDIR"/scripts/hyphy-develop/HYPHYMPI"


# output directory
#OUTPUTDIR=$BASEDIR"/analysis/Combined/combined_codon_alignment_trees/partitioned_lineages"

OUTPUTDIR=$3

echo "# Settings ##"
echo "BASEDIR "$BASEDIR
echo "FILES "$FILES
echo "OUTPUT DIR "$OUTPUTDIR
echo ""

echo "## Creating save directory to: "$OUTPUTDIR
mkdir -p $OUTPUTDIR

for NAIVETree in $FILES; do
    echo "# Input Tree: "$NAIVETree
    f="$(basename -- $NAIVETree)"
    OUTPUT=$OUTPUTDIR"/"$f".partitioned.nwk"
    
    echo "# Saving partitioned tree to: "$OUTPUT

    if [ -s $OUTPUT ]; 
    then
        echo "-- Partitioned lineage tree exists"
    else
        echo "-- Launching annotator"
        echo $HYPHY LIBPATH=$RES $ANNOTATOR --tree $NAIVETree --output $NAIVETree".partitioned.nwk"
        $HYPHY LIBPATH=$RES $ANNOTATOR --tree $NAIVETree --output $NAIVETree".partitioned.nwk"
    fi

    echo ""
done






