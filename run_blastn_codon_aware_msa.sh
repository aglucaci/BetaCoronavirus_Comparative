#!/bin/bash

clear

MERS="../analysis/blastn_results/MERS"
SARS="../analysis/blastn_results/SARS"
SARSSECOND="../analysis/blastn_results/SARS2"

REFERENCEMERS="../data/ReferenceCDS/MERS"
REFERENCESARS="../data/ReferenceCDS/SARS"
REFERENCESARSSECOND="../data/ReferenceCDS/SARS2"

HYPHY=$PWD"/hyphy-develop/HYPHYMP"
RES=$PWD"/hyphy-develop/res"

# Helper function
function run_gene {
    PREMSA=$PWD"/hyphy-analyses/codon-msa/pre-msa.bf"
    POSTMSA=$PWD"/hyphy-analyses/codon-msa/post-msa.bf"
    GENE=$1
    REFERENCE=$2
    OUTPUTDIR=$3
    f="$(basename -- $GENE)"
    #echo $GENE
    
    #echo "OUTPUT: "../analysis/Alignments/$OUTPUTDIR/compressed/$f"_CODON_AWARE_ALN_compressed.fas"
    
    if [ -s ../analysis/Alignments/$OUTPUTDIR/compressed/$f"_CODON_AWARE_ALN_compressed.fas_test.fasta" ];
    then
       echo "Exists: "$f"_CODON_AWARE_ALN_compressed.fas"
       return 1
    fi
    
    echo "OUTPUT: "../analysis/Alignments/$OUTPUTDIR/compressed/$f"_CODON_AWARE_ALN_compressed.fas"
    
    #echo $GENE
    
    #return 0
    #1
    $HYPHY LIBPATH=$RES $PREMSA --input $GENE --reference $REFERENCE --keep-reference Yes
    #--E 0.01
    
    #return 2
    
    #2
    mafft --auto $GENE"_protein.fas" > $GENE"_protein.msa"
    
    #3a
    $HYPHY LIBPATH=$RES $POSTMSA --protein-msa $GENE"_protein.msa" --nucleotide-sequences $GENE"_nuc.fas" --output $GENE"_CODON_AWARE_ALN_compressed.fas_test.fasta"
    
    #3b
    #$HYPHY LIBPATH=$RES $POSTMSA --protein-msa $GENE"_protein.msa" --nucleotide-sequences $GENE"_nuc.fas" --output  $GENE"_CODON_AWARE_ALN_all.fas" --compressed No
    
    
    mkdir "../analysis/Alignments"
    mkdir "../analysis/Alignments"/$OUTPUTDIR
    mkdir "../analysis/Alignments"/$OUTPUTDIR/nucleotide
    mkdir "../analysis/Alignments"/$OUTPUTDIR/protein
    mkdir "../analysis/Alignments"/$OUTPUTDIR/compressed
    mkdir "../analysis/Alignments"/$OUTPUTDIR/all
    
    
    DIR=$(dirname "${GENE}")
    mv $DIR/*_nuc.fas "../analysis/Alignments"/$OUTPUTDIR/nucleotide
    mv $DIR/*_protein.fas "../analysis/Alignments"/$OUTPUTDIR/protein
    mv $DIR/*_protein.msa "../analysis/Alignments"/$OUTPUTDIR/protein
    mv $DIR/*_compressed.fasta "../analysis/Alignments"/$OUTPUTDIR/compressed
    mv $DIR/*_all.fasta "../analysis/Alignments"/$OUTPUTDIR/all
    
}
#End function

# ################################################################################################
# Main subroutine
# ################################################################################################

echo Starting...
echo ""

for fasta in $MERS/*.fasta; do
    echo "Aligning: "$fasta
    
    f="$(basename -- $fasta)"
    run_gene $fasta $REFERENCEMERS/$f "MERS"
    continue
done

# SARS
for fasta in $SARS/*.fasta; do
    echo "Aligning: "$fasta
    f="$(basename -- $fasta)"
    run_gene $fasta $REFERENCESARS/$f "SARS"
done

#SARS 2
for fasta in $SARSSECOND/*.fasta; do
    echo "Aligning: "$fasta
    f="$(basename -- $fasta)"
    run_gene $fasta $REFERENCESARSSECOND/$f "SARS2"
done

# ################################################################################################
# End of file
# ################################################################################################
