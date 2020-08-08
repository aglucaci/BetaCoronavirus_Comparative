#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Aug  7 14:51:22 2020

@author: Alexander G. Lucaci

Needs to take in a codon-aware-msa.
Gets the total number of sequences it represents
create a 1% threshold
filter out sequences that fail to pass this threshold
spits out nucleotide (ungapped) fasta file

In another scripts, ths will be codon aware aligned.
"""
# =============================================================================
# Imports
# =============================================================================
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
import os
import sys

# =============================================================================
# Declares
# =============================================================================

path = "../analysis/SARS2_Compressed_Aln"

# =============================================================================
# Helper function
# =============================================================================

def total_number_seqs(filename):
    #pass
    count = 0
    num_entries = 0
    gap_distribution = []
    with open(filename, "r") as handle:
        for record in SeqIO.parse(handle, "fasta"): 
            ID = record.id
            SEQ = record.seq
            number_represented_by_entry = int(ID.split("_")[-1])
            count += number_represented_by_entry         
            num_entries += 1
            gap_distribution.append(gap_percentage(str(SEQ)))
        #end for
    #end with
    return count, num_entries, gap_distribution
#end total_number_seqs


def filter_seqs(filename, threshold):
    #pass
    passed_filter_count = 0
    total_number_represented_count = 0
    with open(filename, "r") as handle:
        for record in SeqIO.parse(handle, "fasta"): 
            ID = record.id
            SEQ = record.seq
            number_represented_by_entry = int(ID.split("_")[-1])
            #count += number_represented_by_entry   
            if number_represented_by_entry >= threshold:
                #print("\t")
                passed_filter_count += 1
                total_number_represented_count += number_represented_by_entry
        #end for
    #end with
    return passed_filter_count, total_number_represented_count
#end total_number_seqs


def gap_percentage(Sequence):
    step = 3
    num_sites = int(len(Sequence)/step)
    gap_count = 0 
    sequence_length = len(Sequence)
    
    for i in range(num_sites): 
        sub = Sequence[i * step: (i + 1) * step]
        if sub == "---": 
            gap_count += 1
        #end if
    #end fo
    gap_percent = gap_count / sequence_length 
    return gap_percent

# =============================================================================
# Main subroutine
# =============================================================================

# Gap analysis


for filename in os.listdir(path):
    if filename.endswith(".fasta"):
        fullpath = os.path.join(path, filename)
        print("# Processing:", fullpath)
        total_number, num_entries, gap_distribution = total_number_seqs(fullpath)
        print("\t # total number of sequences:", num_entries )
        print("\t # total number of sequences represented (due to compression):", total_number)
        print(gap_distribution)
        
      #end if
#end for
      
        
sys.exit(1)
        
for filename in os.listdir(path):     
    if filename.endswith(".fasta"):
        #1% threshold
        threshold = int(total_number * 0.01)
        print("\t 1% threshold:", threshold)
        passed_filter, total_number_represented_count = filter_seqs(fullpath, threshold)
        print("\t\t sequences passed 1% filter:", passed_filter)
        print("\t\t this represents:", total_number_represented_count, "or", str(round(total_number_represented_count / total_number, 1)) + "%")
        
        #how many sequences occur at least twice
        threshold = 2
        print("\t 2 sequence occurences threshold:", threshold)
        passed_filter, total_number_represented_count = filter_seqs(fullpath, threshold)
        print("\t\t passed 2 sequence occurences filter:", passed_filter)
        print("\t\t this represents:", total_number_represented_count, "or", str(round(total_number_represented_count / total_number, 1)) + "%")
        print()
    #end if
#end for

        

# =============================================================================
# End of file
# =============================================================================
