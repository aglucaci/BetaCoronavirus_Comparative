#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Oct 15 15:02:15 2020

@author: alexander g lucaci


## Run twice

Make sure that nucleotide files are in 'OCT_15_nuc' and proteiin-aligned files are in 'OCT_15_protein_aligned'

# For protein-aligned files
python tagger_for_annotator.py OCT_15_protein_aligned protein.aligned.fas protein.aligned_tagged.fas tagged_protein_aligned_fasta .catted.qa.fasta_protein.aligned.fas


# For nucleotide fasta
python tagger_for_annotator.py OCT_15_nuc _nuc.fas _nuc_tagged.fas tagged_nuc_fasta .catted.qa.fasta_nuc.fas
"""

# =============================================================================
# Imports
# =============================================================================
import os
import sys
from Bio import SeqIO
print("# starting")


# =============================================================================
# Declares
# =============================================================================
#"Middle_East" : "MERS",
#"SARS_coronavirus" : "SARS",
#"Severe_acute_respiratory_syndrome_coronavirus_2" : "SARS2"

DIR = sys.argv[1]
suffix_find = sys.argv[2]
suffix_replace = sys.argv[3]
output_dir = sys.argv[4]
FILE_suffix = sys.argv[5]

viruses = ["OC43", "229E", "HKU1", "NL63", "MERS", "SARS", "SARS2"]

#FILES = ["ORF1a.fasta", "ORF1b.fasta", "S.fasta", "E.fasta", "M.fasta", "N.fasta"]
FILES = ["ORF1a", "ORF1b", "S", "E", "M", "N"]
#FILE_suffix = ".catted.qa.fasta_protein.aligned.compressed.codon.fas"

for n, item in enumerate(FILES):
    FILES[n] += FILE_suffix
    
#print(FILES)
#DIR = "OCT_15_protein_aligned"
#suffix_find = "protein.aligned.fas"
#suffix_replace = "protein.aligned_tagged.fas"
#output_dir = "tagged_protein_aligned_fasta"
# =============================================================================
# Main loop
# =============================================================================

for virus in viruses:
    for file in FILES:
        filename = os.path.join(DIR, virus + "_" + file)
        does_exist = os.path.exists(filename)
        print("\t", "Opening:", filename, does_exist)
        
        if does_exist == False: 
            print()
            sys.exit(2)
        
        #INPUT
        with open(filename) as handle:
            for record in SeqIO.parse(handle, "fasta"): 
                ID = record.id
                SEQ = record.seq
                DESC = record.description
                #print("\t\t",ID, DESC, "\n")
        
                #OUTPUT
                #record.id = ""
                
                if virus == "SARS":
                    record.id = "SARS_coronavirus" + "_" + record.description
                elif virus == "SARS2":
                    record.id = "Severe_acute_respiratory_syndrome_coronavirus_2" + "_" + record.description
                elif virus == "MERS":
                    record.id = "Middle_East" + "_" + record.description
                else:
                    record.id = virus + "_" + record.description
                #end if
                
                record.description = ""
                
                output = virus + "_" + file.replace(suffix_find, suffix_replace)
                #output_dir = "tagged_protein_fasta"
                os.system("mkdir -p " + output_dir)
                
                with open(os.path.join(output_dir, output), "a+") as handle:
                    SeqIO.write(record, handle, "fasta")
                #end with
            
            #end inner inner for
        #end with
        
    #end inner for 
#end outer for
        
        
#sys.exit (1)

# =============================================================================
# End of file
# =============================================================================
