#!/bin/bash
#@Usage: parallel ::: "bash GARD_aBSREL_MEME_BUSTEDS.sh"

# Declares
GARD=$PWD"/hyphy-develop/res/TemplateBatchFiles/GARD.bf"
MEME=$PWD"/hyphy-develop/res/TemplateBatchFiles/SelectionAnalyses/MEME.bf"
ABSREL=$PWD"/hyphy-develop/res/TemplateBatchFiles/SelectionAnalyses/aBSREL.bf"
BUSTEDS=$PWD"/hyphy-develop/res/TemplateBatchFiles/SelectionAnalyses/BUSTED.bf"
HYPHY=$PWD"/hyphy-develop/HYPHYMP"
RES=$PWD"/hyphy-develop/res"


BASEDIR="$(dirname "$PWD")"
echo $BASEDIR
echo .............................
#Gard doesnt need a tree.
#Run on codon alignment, could run on nt alignment..

#MEME
#aBSREL
#BUSTEDS

MERSTREEDIR="../analysis/raxml/MERS"

echo MERS
for gene in ../analysis/Alignments/MERS/compressed/*.fas; do
    f="$(basename -- $gene)"
    echo $gene $MERSTREEDIR/"RAxML_bestTree."$f
    continue
    $HYPHY LIBPATH=$RES $GARD --type codon --alignment $gene
    
    $HYPHY LIBPATH=$RES $MEME --alignment $gene --tree $MERSTREEDIR/"RAxML_bestTree."$f
    
    $HYPHY LIBPATH=$RES $ABSREL --alignment $gene --tree $MERSTREEDIR/"RAxML_bestTree."$f
    
    $HYPHY LIBPATH=$RES $BUSTEDS --alignment $gene --tree $MERSTREEDIR/"RAxML_bestTree."$f --srv Yes
done

exit
SARSTREEDIR="../analysis/raxml/SARS"

echo SARS
for gene in ../analysis/Alignments/SARS/compressed/*.fas; do
    f="$(basename -- $gene)"
    echo "Processing: "$gene
    $HYPHY LIBPATH=$RES $GARD --type codon --alignment $gene
    
    $HYPHY LIBPATH=$RES $MEME --alignment $gene --tree $SARSTREEDIR/"RAxML_bestTree."$f
    
    $HYPHY LIBPATH=$RES $ABSREL --alignment $gene --tree $SARSTREEDIR/"RAxML_bestTree."$f
    
    $HYPHY LIBPATH=$RES $BUSTEDS --alignment $gene --tree $SARSTREEDIR/"RAxML_bestTree."$f --srv Yes
done

SARSTWOTREEDIR="../analysis/raxml/SARS2"
echo SARS2
for gene in ../analysis/Alignments/SARS2/compressed/*.fas; do
    f="$(basename -- $gene)"
    echo "Processing: "$gene
    $HYPHY LIBPATH=$RES $GARD --type codon --alignment $gene
    
    $HYPHY LIBPATH=$RES $MEME --alignment $gene --tree $SARSTWOTREEDIR/"RAxML_bestTree."$f
    
    $HYPHY LIBPATH=$RES $ABSREL --alignment $gene --tree $SARSTWOTREEDIR/"RAxML_bestTree."$f
    
    $HYPHY LIBPATH=$RES $BUSTEDS --alignment $gene --tree $SARSTWOTREEDIR/"RAxML_bestTree."$f --srv Yes
done


# End of file
