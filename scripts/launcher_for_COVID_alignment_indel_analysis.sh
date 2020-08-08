#!/bin/bash

# This looks at the gap analysis per codon alignment.
# Should output an image, and a table to break down which sites fail to pass the threshold (1.5% gap)


mkdir gap_analysis
mkdir gap_analysis/MERS
mkdir gap_analysis/SARS
mkdir gap_analysis/SARS2


for FILE in ../analysis/Alignments/MERS/compressed/*.fas; do
    echo $FILE
    python COVID_alignment_indel_analysis.py $FILE MERS
    exit
done

exit


for FILE in ../analysis/Alignments/SARS/compressed/*.fas; do
    echo $FILE
    python COVID_alignment_indel_analysis.py $FILE SARS
done


for FILE in ../analysis/Alignments/SARS2/compressed/*.fas; do
    echo $FILE
    python COVID_alignment_indel_analysis.py $FILE SARS2
done


