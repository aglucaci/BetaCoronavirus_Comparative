#!/bin/bash
#PBS -N Beta_lineage_annotator
clear

#BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"
BASEDIR=$1



ANNOTATOR=$BASEDIR"/scripts/annotator.bf"
# Takes in the --tree and the --output

FILES=$BASEDIR"/analysis/Combined/combined_codon_alignment_trees/*bestTree*"


HYPHYMPI=$BASEDIR"/scripts/hyphy-develop/HYPHYMPI"
HYPHY=$BASEDIR"/scripts/hyphy-develop/HYPHYMP"

RES=$BASEDIR"/scripts/hyphy-develop/res"

# output directory
OUTPUTDIR=$BASEDIR"/analysis/Combined/combined_codon_alignment_trees/partitioned_lineages"
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
        echo $HYPHY LIBPATH=$RES $ANNOTATOR --tree $NAIVETree --output $OUTPUT
        $HYPHY LIBPATH=$RES $ANNOTATOR --tree $NAIVETree --output $OUTPUT  
    fi

    echo ""
done






