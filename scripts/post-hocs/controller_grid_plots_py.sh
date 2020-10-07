#!/bin/bash


#JSON_FILE = "FUBAR/SARS/N.fasta_CODON_AWARE_ALN.fasta.FUBAR.json"
#plot_title = "SARS N"



for virus in SARS2 SARS MERS OC43 NL63 HKU1 229E; do 
    echo "# Processing: "$virus


    echo python grid_plots.py FUBAR/$virus/ORF1a.fasta_CODON_AWARE_ALN.fasta.FUBAR.json $virus"_ORF1a"
    echo python grid_plots.py FUBAR/$virus/ORF1b.fasta_CODON_AWARE_ALN.fasta.FUBAR.json $virus"_ORF1b"
    echo python grid_plots.py FUBAR/$virus/S.fasta_CODON_AWARE_ALN.fasta.FUBAR.json $virus"_Spike"
    echo python grid_plots.py FUBAR/$virus/M.fasta_CODON_AWARE_ALN.fasta.FUBAR.json $virus"_Matrix"
    echo python grid_plots.py FUBAR/$virus/N.fasta_CODON_AWARE_ALN.fasta.FUBAR.json $virus"_Nucleocapsid"
    echo python grid_plots.py FUBAR/$virus/E.fasta_CODON_AWARE_ALN.fasta.FUBAR.json $virus"_Envelope"


    python grid_plots.py FUBAR/$virus/ORF1a.fasta_CODON_AWARE_ALN.fasta.FUBAR.json $virus"_ORF1a"
    python grid_plots.py FUBAR/$virus/ORF1b.fasta_CODON_AWARE_ALN.fasta.FUBAR.json $virus"_ORF1b"
    python grid_plots.py FUBAR/$virus/S.fasta_CODON_AWARE_ALN.fasta.FUBAR.json $virus"_Spike"
    python grid_plots.py FUBAR/$virus/M.fasta_CODON_AWARE_ALN.fasta.FUBAR.json $virus"_Matrix"
    python grid_plots.py FUBAR/$virus/N.fasta_CODON_AWARE_ALN.fasta.FUBAR.json $virus"_Nucleocapsid"
    python grid_plots.py FUBAR/$virus/E.fasta_CODON_AWARE_ALN.fasta.FUBAR.json $virus"_Envelope"
    
    echo ""
done