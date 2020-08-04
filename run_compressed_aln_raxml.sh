#!/bin/bash

RAXML="/Users/user/Documents/ComparativeAnalyses_Coronavirus/scripts/standard-RAxML/raxmlHPC"

mkdir ../analysis/raxml
mkdir ../analysis/raxml/MERS
mkdir ../analysis/raxml/SARS
mkdir ../analysis/raxml/SARS2

echo MERS
for gene in ../analysis/Alignments/MERS/compressed/*.fas; do
    continue
    f="$(basename -- $gene)"
    echo "Processing: "$gene
    raxmlHPC -m GTRGAMMA -s $gene -p 12345 -n $f
    # Move trees
    mv RAxML* ../analysis/raxml/MERS
done



echo SARS
for gene in ../analysis/Alignments/SARS/compressed/*.fas; do
    f="$(basename -- $gene)"
    echo "Processing: "$gene
    
    if [ -s ../analysis/raxml/SARS/RAxML_bestTree.$f ]
    then
        echo "Exists tree for: "$gene
        return 1
    fi
    
    #continue
    raxmlHPC -m GTRGAMMA -s $gene -p 12345 -n $f
    mv RAxML* ../analysis/raxml/SARS
done

exit

echo SARS2
for gene in ../analysis/Alignments/SARS2/compressed/*.fas; do
    f="$(basename -- $gene)"
    echo "Processing: "$gene
    raxmlHPC -m GTRGAMMA -s $gene -p 12345 -n $f
    mv RAxML* ../analysis/raxml/SARS2
done
