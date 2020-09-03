#!/bin/bash

mkdir -p SILVERBACK


for dir in SARS2 SARS MERS NL63 HKU1 229E OC43; do
    mkdir -p SILVERBACK/$dir
    

    cp $dir/S.fasta SILVERBACK/$dir/S.fasta
    cp $dir/M.fasta SILVERBACK/$dir/M.fasta
    cp $dir/N.fasta SILVERBACK/$dir/N.fasta
    cp $dir/E.fasta SILVERBACK/$dir/E.fasta

    cp $dir/ORF1a_edited.fasta SILVERBACK/$dir/ORF1a.fasta
    cp $dir/ORF1b_edited.fasta SILVERBACK/$dir/ORF1b.fasta
done
