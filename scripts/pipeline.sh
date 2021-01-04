#!/bin/bash

#@Usage: bash pipeline.sh

#@REFERENCE FOR PIPELINE ON SLURM: https://hpc.nih.gov/docs/job_dependencies.html
clear

echo "## Starting pipeline"
echo "---- Details ---"
echo "Comparative genomic analysis of Human Coronaviruses"
echo ""

echo "## Installing some dependencies..."
# Dependencies (Installers)
# MAFFT (already installed)
#bash install_hyphy.sh
#bash install_tn93.sh
#bash install_raxml.sh
#bash install_modeltestng.sh
echo "###################################"

BASEDIR="/home/aglucaci/BetaCoronavirus_Comparative"

echo "Base directory set as: "$BASEDIR

mkdir -p $BASEDIR"/scripts/STDIN"
mkdir -p $BASEDIR"/scripts/STDIN_Error"

echo ""
echo "# ##################################"
echo "# Starting to submit jobs"
echo "# ##################################"

# Step 1a - Split out ViPR results, gene by gene for each viral species
if [ -s $BASEDIR"/scripts/SARS2_db.nto" ];
then
    echo "# blastn results complete"
else
    echo bash blastn_genebygene.sh $BASEDIR
    bash blastn_genebygene.sh $BASEDIR
fi

echo ""

# Step 1b - QA on blastn, this filters the results of blastn search that have less than 99% NT content for that gene
# meaning, it filters out sequences that are less than 99% of the sequence length
if [ -s $BASEDIR"/analysis/blastn_results/SARS2/blastn_QA_filtered/S.fasta" ];
then
    #echo 1 
    echo "# QA on blastn results is complete" 
else
    echo python36 QA_blastn.py $BASEDIR > $BASEDIR"/scripts/QA_blastn_log.txt"
    python36 QA_blastn.py $BASEDIR > $BASEDIR"/scripts/QA_blastn_log.txt"
fi
echo ""

# Step 2a - Perform a codon-aware msa and create a phylogenetic tree
echo qsub -V -q epyc -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" run_blastn_codon_aware_msa.sh -F $BASEDIR
cmd="qsub -V -q epyc -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" run_blastn_codon_aware_msa.sh -F $BASEDIR"
jobid_2a=$($cmd | cut -d' ' -f3)
echo "Step 2a: "$jobid_2a
echo ""

#exit 1

# Some kind of check needs to be implemented here, to make sure that all of the alignments were generated

# Step 2b - ModelTest
#echo qsub -V -q epyc -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" -W depend=afterok:$jobid_2a run_modeltest.sh
#cmd="qsub -V -q epyc -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" -W depend=afterok:$jobid_2a run_modeltest.sh"
#jobid_2b=$($cmd | cut -d' ' -f3)
#echo "Step 2b: "$jobid_2b
#echo ""

# Step 2c - Create ML Trees
#This one can depend on Step 2a for now, need to implement taking ModelTest results and using them to make trees
echo qsub -V -W depend=afterok:$jobid_2a -q epyc -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" run_compressed_aln_raxml.sh -F $BASEDIR
cmd="qsub -V -W depend=afterok:$jobid_2a -q epyc -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" run_compressed_aln_raxml.sh -F $BASEDIR"
jobid_2c=$($cmd | cut -d' ' -f3)
echo "Step 2c: "$jobid_2c
echo ""

#exit 2
# Some kind of check needs to be implemented here, to make sure that all of the trees were generated.

# Step 3a - Perform a TN93 distance calculation (on codon aware msa)
echo qsub -V -W depend=afterok:$jobid_2a -q epyc -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" tn93_codons.sh -F $BASEDIR
cmd="qsub -V -W depend=afterok:$jobid_2a -q epyc -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" tn93_codons.sh -F $BASEDIR"
jobid_3a=$($cmd | cut -d' ' -f3)
echo "Step 3a: "$jobid_3a
echo ""

# Step 3b - TN93 Cluster analysis
echo qsub -V -W depend=afterok:$jobid_2a -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" -q epyc tn93_cluster.sh -F $BASEDIR
cmd="qsub -V -W depend=afterok:$jobid_2a -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" -q epyc tn93_cluster.sh -F $BASEDIR"
jobid_3b=$($cmd | cut -d' ' -f3)
echo "Step 3b: "$jobid_3b
echo ""

# Step 4 - Selection Analyses
echo qsub -V -W depend=afterok:$jobid_2c -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" -q epyc MEME_BUSTEDS_aBSREL.sh -F $BASEDIR
cmd="qsub -V -W depend=afterok:$jobid_2c -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" -q epyc MEME_BUSTEDS_aBSREL.sh -F $BASEDIR"
jobid_4=$($cmd | cut -d' ' -f3)
echo "Step 4: "$jobid_4
echo ""

# Step 5 - use MAFFT Merge to merge the alignments across genes, and then construct ML Trees.
echo qsub -V -W depend=afterok:$jobid_2a -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" -q epyc MergeAlignments.sh -F $BASEDIR
cmd="qsub -V -W depend=afterok:$jobid_2a -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" -q epyc MergeAlignments.sh -F $BASEDIR"
jobid_5=$($cmd | cut -d' ' -f3)
echo "Step 5: "$jobid_5
echo ""

#exit 1

# Step 6 - Partition lineages
#echo bash launcher_for_annotator.sh -F $BASEDIR 
#bash launcher_for_annotator.sh -F $BASEDIR 
echo qsub -V -W depend=afterok:$jobid_5 -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" -q epyc launcher_for_annotator.sh -F $BASEDIR 
cmd="qsub -V -W depend=afterok:$jobid_5 -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" -q epyc launcher_for_annotator.sh -F $BASEDIR"
jobid_6=$($cmd | cut -d' ' -f3)
echo "Step 6: "$jobid_6
echo ""

# Step 7 - Run RELAX and Constrast-FEL
echo qsub -V -W depend=afterok:$jobid_6 -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" -q epyc RELAX_CONTRAST-FEL.sh -F $BASEDIR
cmd="qsub -V -W depend=afterok:$jobid_6 -o $BASEDIR"/scripts/STDIN" -e $BASEDIR"/scripts/STDIN_Error" -q epyc RELAX_CONTRAST-FEL.sh -F $BASEDIR"
jobid_7=$($cmd | cut -d' ' -f3)
echo "Step 7: "$jobid_7


echo ""

# Step 8 - (local analysis)
#Branch length distributions on RAxML trees
#'Gap analysis' on codon aware alignments
#TN93 figures on codon aware alignment
#TN93 Clustering - network inference. 



## End of file ##

