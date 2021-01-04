#! bin/bash
# Alexander G Lucaci

# #################
# Given gene by gene from the reference of each (MERS, SARS, SARS2)
# and
# Given a pulldown from the VIPR database of Human whole genomes from (MERS, SARS, SARS2)
# #################

# #################
# We will make a blastdb of the VIPR pulldown file (multi-fasta)
# For each virus in list (MERS, SARS, SARS2)
# we will run its indvidual reference gene sequence against each blast db
# #################

# #################
# Pre data cleaning
# Split CDS master file into multiple fastas (1 per gene)
#  awk -F '|' '/^>/ {F=sprintf("%s.fasta",$2); print > F;next;} {print >> F;}' < yourfile.fa

#Replace spaces in filenames to underscores
#  find . -type f -name "* *.fasta" -exec bash -c 'mv "$0" "${0// /_}"' {} \;
# #################

# #################
# Requirements:
# blast+
# #################
# These are the files I pulled down from VIPR, whole genomes.
# sed -i '' 's/ /_/g' foo.fa

#clear
echo "# Blastn - gene by gene splitting for Coronaviridae"
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "# Starting: "$dt

BASEDIR=$1

#Set up output directories.
echo "# Creating output directories"
mkdir -p $BASEDIR/analysis
mkdir -p $BASEDIR/analysis/blastn_results

#Declares
MAKEBLASTDB="/usr/bin/makeblastdb"
BLASTN="/usr/bin/blastn"

# Replace spaces in sequences IDs with underscores
echo "# 'sed' Changing spaces in IDs to underscores"
sed -i "s/ /_/g" $BASEDIR/data/VIPR/MERS/GenomicFastaResults.fasta
sed -i "s/ /_/g" $BASEDIR/data/VIPR/SARS/GenomicFastaResults.fasta
sed -i "s/ /_/g" $BASEDIR/data/VIPR/SARS2/GenomicFastaResults.fasta
sed -i "s/ /_/g" $BASEDIR/data/VIPR/NL63/GenomicFastaResults.fasta
sed -i "s/ /_/g" $BASEDIR/data/VIPR/229E/GenomicFastaResults.fasta
sed -i "s/ /_/g" $BASEDIR/data/VIPR/OC43/GenomicFastaResults.fasta
sed -i "s/ /_/g" $BASEDIR/data/VIPR/HKU1/GenomicFastaResults.fasta



# make blast db of the VIPR results
echo "# Creating blastdb's"
#the binary should already exist on silverback
/usr/bin/makeblastdb -in $BASEDIR/data/VIPR/MERS/GenomicFastaResults.fasta -dbtype nucl -out MERS_db
/usr/bin/makeblastdb -in $BASEDIR/data/VIPR/SARS/GenomicFastaResults.fasta -dbtype nucl -out SARS_db
/usr/bin/makeblastdb -in $BASEDIR/data/VIPR/SARS2/GenomicFastaResults.fasta -dbtype nucl -out SARS2_db
/usr/bin/makeblastdb -in $BASEDIR/data/VIPR/NL63/GenomicFastaResults.fasta -dbtype nucl -out NL63_db
/usr/bin/makeblastdb -in $BASEDIR/data/VIPR/HKU1/GenomicFastaResults.fasta -dbtype nucl -out HKU1_db
/usr/bin/makeblastdb -in $BASEDIR/data/VIPR/229E/GenomicFastaResults.fasta -dbtype nucl -out 229E_db
/usr/bin/makeblastdb -in $BASEDIR/data/VIPR/OC43/GenomicFastaResults.fasta -dbtype nucl -out OC43_db


#Calculate max target seqs? SARS2 will have the most sequences
#MaxCount=$(grep -c "^>" ../data/VIPR/SARS2/GenomicFastaResults.fasta)
MaxCount=11000

for virus in MERS SARS SARS2 NL63 HKU1 229E OC43; do
    ANALYSIS=$BASEDIR"/analysis/blastn_results/"$virus
    echo ""
    echo "# Making directory: "$ANALYSIS
    mkdir -p $ANALYSIS
    
    FILES=$BASEDIR"/data/ReferenceCDS/"$virus"/*.fasta"
    for fasta in $FILES; do
        if [ ! -f "$fasta" ]; then
            echo "$fasta does not exist."
            continue
        fi
    
        echo "    # Processing: "$fasta
        f="$(basename -- $fasta)"
        
        # Standard Blast
        /usr/bin/blastn -query $fasta -db $virus"_db" -max_hsps 1 -max_target_seqs $MaxCount -out $ANALYSIS/$f".txt"
        
        # Blast output to fasta
        /usr/bin/blastn -query $fasta -db $virus"_db" -max_hsps 1 -max_target_seqs $MaxCount -outfmt '6 sseqid sseq' | awk 'BEGIN{FS="\t"; OFS="\n"}{gsub(/-/, "", $2); print ">"$1,$2}' > $ANALYSIS/$f
    done
done


# #################
# End of file
# #################
