#!/bin/bash
#PBS -N Beta_CODON_AWARE_MSA
#PBS -l walltime=999:00:00
#PBS -l nodes=1:ppn=64
#@USAGE: qsub -V -q epyc run_blastn_codon_aware_msa.sh

#clear

echo "###"
echo "Running: run_blastn_codon_aware_msa.sh"

BASEDIR=$1

# First version, without the QA on blastn
#MERS=$BASEDIR"/analysis/blastn_results/MERS"
#SARS=$BASEDIR"/analysis/blastn_results/SARS"
#SARSSECOND=$BASEDIR"/analysis/blastn_results/SARS2"

MERS=$BASEDIR"/analysis/blastn_results/MERS/blastn_QA_filtered"
SARS=$BASEDIR"/analysis/blastn_results/SARS/blastn_QA_filtered"
SARSSECOND=$BASEDIR"/analysis/blastn_results/SARS2/blastn_QA_filtered"
E229=$BASEDIR"/analysis/blastn_results/229E/blastn_QA_filtered"
HKU1=$BASEDIR"/analysis/blastn_results/HKU1/blastn_QA_filtered"
NL63=$BASEDIR"/analysis/blastn_results/NL63/blastn_QA_filtered"
OC43=$BASEDIR"/analysis/blastn_results/OC43/blastn_QA_filtered"

REFERENCEMERS=$BASEDIR"/data/ReferenceCDS/MERS"
REFERENCESARS=$BASEDIR"/data/ReferenceCDS/SARS"
REFERENCESARSSECOND=$BASEDIR"/data/ReferenceCDS/SARS2"
REFERENCE229E=$BASEDIR"/data/ReferenceCDS/229E"
REFERENCEHKU1=$BASEDIR"/data/ReferenceCDS/HKU1"
REFERENCENL63=$BASEDIR"/data/ReferenceCDS/NL63"
REFERENCEOC43=$BASEDIR"/data/ReferenceCDS/OC43"

HYPHY=$BASEDIR"/scripts/hyphy-develop/HYPHYMP"
RES=$BASEDIR"/scripts/hyphy-develop/res"
HYPHYMPI=$BASEDIR"/scripts/hyphy-develop/HYPHYMPI"
MAFFT="/usr/bin/mafft"

# Helper function
function run_gene {
    PREMSA=$BASEDIR"/scripts/hyphy-analyses/codon-msa/pre-msa.bf"
    POSTMSA=$BASEDIR"/scripts/hyphy-analyses/codon-msa/post-msa.bf"
    GENE=$1
    REFERENCE=$2
    OUTPUTDIR=$3
    f="$(basename -- $GENE)"
   
    tag="_CODON_AWARE_ALN.fasta"
 
    if [ -s $BASEDIR"/analysis/Alignments/"$OUTPUTDIR"/compressed/"$f$tag ];
    then
       echo "    Alignment Exist at: "$BASEDIR"/analysis/Alignments/"$OUTPUTDIR"/compressed/"$f$tag
       return 1
    fi
    
    #echo "OUTPUT: "../analysis/Alignments/$OUTPUTDIR/compressed/$f"_CODON_AWARE_ALN_compressed.fas"
    
    # Step 1    
    echo mpirun -np 64 $HYPHYMPI LIBPATH=$RES $PREMSA --input $GENE --reference $REFERENCE --keep-reference Yes
    mpirun -np 64 $HYPHYMPI LIBPATH=$RES $PREMSA --input $GENE --reference $REFERENCE --keep-reference Yes
    #$HYPHY LIBPATH=$RES $PREMSA --input $GENE --reference $REFERENCE --keep-reference Yes
    
    # Step 2
    echo $MAFFT --auto $GENE"_protein.fas" > $GENE"_protein.msa"
    $MAFFT --auto $GENE"_protein.fas" > $GENE"_protein.msa"
    
    # Step 3
    echo mpirun -np 64 $HYPHYMPI LIBPATH=$RES $POSTMSA --protein-msa $GENE"_protein.msa" --nucleotide-sequences $GENE"_nuc.fas" --output $GENE$tag --duplicates $GENE$tag"_duplicates.json"
    mpirun -np 64 $HYPHYMPI LIBPATH=$RES $POSTMSA --protein-msa $GENE"_protein.msa" --nucleotide-sequences $GENE"_nuc.fas" --output $GENE$tag --duplicates $GENE$tag"_duplicates.json"
    
    #3b
    #$HYPHY LIBPATH=$RES $POSTMSA --protein-msa $GENE"_protein.msa" --nucleotide-sequences $GENE"_nuc.fas" --output  $GENE"_CODON_AWARE_ALN_all.fas" --compressed No
    
    mkdir -p $BASEDIR"/analysis/Alignments"
    mkdir -p $BASEDIR"/analysis/Alignments"/$OUTPUTDIR
    mkdir -p $BASEDIR"/analysis/Alignments"/$OUTPUTDIR/nucleotide
    mkdir -p $BASEDIR"/analysis/Alignments"/$OUTPUTDIR/protein
    mkdir -p $BASEDIR"/analysis/Alignments"/$OUTPUTDIR/compressed
    #mkdir -p $BASEDIR"/analysis/Alignments"/$OUTPUTDIR/all
    
    DIR=$(dirname "${GENE}")
    mv $DIR/*_nuc.fas $BASEDIR"/analysis/Alignments"/$OUTPUTDIR/nucleotide
    mv $DIR/*_protein.fas $BASEDIR"/analysis/Alignments"/$OUTPUTDIR/protein
    mv $DIR/*_protein.msa $BASEDIR"/analysis/Alignments"/$OUTPUTDIR/protein
    mv $DIR/*$tag $BASEDIR"/analysis/Alignments"/$OUTPUTDIR/compressed
    #mv $DIR/*_all.fasta $BASEDIR"/analysis/Alignments"/$OUTPUTDIR/all
    
}
#End function

# ################################################################################################
# Main subroutine
# ################################################################################################

echo Starting...
echo ""

#MERS
for fasta in $MERS/*.fasta; do
    echo "Aligning: "$fasta
    
    f="$(basename -- $fasta)"
    run_gene $fasta $REFERENCEMERS/$f "MERS"
    #continue
done

echo ""

# SARS
for fasta in $SARS/*.fasta; do
    echo "Aligning: "$fasta
    f="$(basename -- $fasta)"
    run_gene $fasta $REFERENCESARS/$f "SARS"
done

echo ""

#SARS 2
for fasta in $SARSSECOND/*.fasta; do
    echo "Aligning: "$fasta
    f="$(basename -- $fasta)"
    run_gene $fasta $REFERENCESARSSECOND/$f "SARS2"
done

echo ""

#229E
for fasta in $E229/*.fasta; do
    echo "Aligning: "$fasta
    f="$(basename -- $fasta)"
    run_gene $fasta $REFERENCE229E/$f "229E"
done

echo ""

#HKU1
for fasta in $HKU1/*.fasta; do
    echo "Aligning: "$fasta
    f="$(basename -- $fasta)"
    run_gene $fasta $REFERENCEHKU1/$f "HKU1"
done

echo ""

#NL63
for fasta in $NL63/*.fasta; do
    echo "Aligning: "$fasta
    f="$(basename -- $fasta)"
    run_gene $fasta $REFERENCENL63/$f "NL63"
done

echo ""

#OC43
for fasta in $OC43/*.fasta; do
    echo "Aligning: "$fasta
    f="$(basename -- $fasta)"
    run_gene $fasta $REFERENCEOC43/$f "OC43"
done

exit 0

# ################################################################################################
# End of file
# ################################################################################################
