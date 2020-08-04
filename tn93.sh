#!/bin/bash
clear

TN="tn93/tn93"
DIR="../analysis/Alignments"

for virus in MERS SARS SARS2; do
    SAVE=$DIR/$virus/nucleotide/tn93
    mkdir $SAVE
    
    
    #for FILE in $DIR/$virus/nucleotide/*.fas; do
    for FILE in $DIR/$virus/nucleotide/parsed_for_GARD/tn93_version/*.fasta; do
        f="$(basename -- $FILE)"
        #mafft --auto $FILE > $FILE".aln"
        
        #$TN -t 1 -o $SAVE"/"$f".dst" $FILE".aln"
        $TN -t 1 -o $SAVE"/"$f".dst" $FILE
    done


done


# end of file
