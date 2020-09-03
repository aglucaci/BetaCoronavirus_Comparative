#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep  1 11:39:09 2020

@author: Alexander G Lucaci

Reference Sequences for various coronaviruses

Human coronavirus OC43 (HCoV-OC43), β-CoV		https://www.ncbi.nlm.nih.gov/nuccore/1578871709
Human coronavirus HKU1 (HCoV-HKU1), β-CoV		https://www.ncbi.nlm.nih.gov/nuccore/85667876
Human coronavirus 229E (HCoV-229E), α-CoV		https://www.ncbi.nlm.nih.gov/nuccore/12175745
Human coronavirus NL63 (HCoV-NL63), α-CoV		https://www.ncbi.nlm.nih.gov/nuccore/49169782

Human coronavirus MERS                          https://www.ncbi.nlm.nih.gov/nuccore/667489388
Human coronavirus SARS-CoV                      https://www.ncbi.nlm.nih.gov/nuccore/30271926
Human coronavirus SARS-CoV-2                    https://www.ncbi.nlm.nih.gov/nuccore/1798174254


1. Download the (Send to:) CDS -> Nucleotide Fasta
2. Split multi-fasta into multiple files
3. Create a copy of ORF1ab
4. Rename files: S.fasta, N.fasta, M.fasta, E.fasta, ORF1a.fasta, ORF1b.fasta in each directory
5. Run this script


"""
# =============================================================================
# Imports
# =============================================================================
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
import os
import sys
from scipy import stats
print("# starting")

# =============================================================================
# Declares
# =============================================================================

FOLDERS = ["OC43", "229E", "HKU1", "NL63", "MERS", "SARS", "SARS2"]

# Dictionary with indicies, Folder, Gene, Start, Stop
position_dict = {}
position_dict["OC43"] = {"ORF1a": {"Start" : 210, "End": 13340}, "ORF1b": {"Start" : 13340, "End": 21496}}
position_dict["HKU1"] = {"ORF1a": {"Start" : 206, "End": 13600}, "ORF1b": {"Start" : 13600, "End": 21753}}
position_dict["229E"] = {"ORF1a": {"Start" : 293, "End": 12520}, "ORF1b": {"Start" : 12520, "End": 20568}}
position_dict["NL63"] = {"ORF1a": {"Start" : 287, "End": 12439}, "ORF1b": {"Start" : 12439, "End": 20475}}

position_dict["MERS"] = {"ORF1a": {"Start" : 279, "End": 13433}, "ORF1b": {"Start" : 13433, "End": 21514}}
position_dict["SARS"] = {"ORF1a": {"Start" : 265, "End": 13392}, "ORF1b": {"Start" : 13392, "End": 21486}}
position_dict["SARS2"] = {"ORF1a": {"Start" : 266, "End": 13468}, "ORF1b": {"Start" : 13468, "End": 21555}}



# =============================================================================
# Main sub
# =============================================================================
#Adjust dictionary
print("# adjusting dictionary positions\n")
for item in position_dict.keys():
    #print(item)
    position_dict[item]["ORF1b"]["End"] = position_dict[item]["ORF1b"]["End"] - position_dict[item]["ORF1a"]["Start"]
    position_dict[item]["ORF1b"]["Start"] = position_dict[item]["ORF1b"]["Start"] - position_dict[item]["ORF1a"]["Start"]
    
    position_dict[item]["ORF1a"]["End"] = position_dict[item]["ORF1a"]["End"] - position_dict[item]["ORF1a"]["Start"]
    position_dict[item]["ORF1a"]["Start"] = 1
    print("\t", item, position_dict[item])

#print(position_dict, "\n")
print()

# =============================================================================
# Processing folders
# =============================================================================

def write_to_file(output, sequence):
    with open(output, "a") as handle:
        SeqIO.write(record, handle, "fasta")
    #end with
#end method


print("# loop over folders")
for folder in FOLDERS:
    
    
    
    print("\n# processing:", folder)
    print("# opening:", folder, "ORF1a")
    
    # Find ORF1a (unedited)
    filename = os.path.join(folder, "ORF1a.fasta")
    with open(filename) as handle:
        for record in SeqIO.parse(handle, "fasta"): 
            ID = record.id
            SEQ = record.seq
            
            print("\t sequence length (unedited)", len(str(SEQ)))
            
            # Cut ORF1a and ORF1b at their respective sites
            print("\t Cutting:", position_dict[folder]["ORF1a"]["Start"] - 1 , position_dict[folder]["ORF1a"]["End"] + 1)
            
            new_SEQ_ORF1a = SEQ[position_dict[folder]["ORF1a"]["Start"] - 1: position_dict[folder]["ORF1a"]["End"] + 1]
            print("\t sequence length (edited)", len(str(new_SEQ_ORF1a)))
            print("\t Number of sites:", len(str(new_SEQ_ORF1a)) / 3)
            
            # Save to file (fasta)
            #record.id = folder + "_" + record.id
            record.seq = new_SEQ_ORF1a
            output = os.path.join(folder, "ORF1a_edited.fasta")
            with open(output, "w") as handle:
                    SeqIO.write(record, handle, "fasta")
            #end with
            
        #end for
    #end with
    
    
    # Find ORF1b (unedited)
    print("\n# opening:", folder, "ORF1b")
    filename = os.path.join(folder, "ORF1b.fasta")
    with open(filename) as handle:
        for record in SeqIO.parse(handle, "fasta"): 
            ID = record.id
            SEQ = record.seq
            
            print("\t sequence length (unedited)", len(str(SEQ)))
            
            # Cut ORF1a and ORF1b at their respective sites
            print("\t Cutting:",position_dict[folder]["ORF1b"]["Start"] - 1 , position_dict[folder]["ORF1b"]["End"] + 2)
            
            new_SEQ_ORF1b = SEQ[position_dict[folder]["ORF1b"]["Start"] + 1: position_dict[folder]["ORF1b"]["End"] + 2]
            print("\t sequence length (edited)", len(str(new_SEQ_ORF1b)))
            print("\t Number of sites:", len(str(new_SEQ_ORF1b)) / 3)
            
            # Save to file (fasta)
            #record.id = folder + "_" + record.id
            record.seq = new_SEQ_ORF1b
            output = os.path.join(folder, "ORF1b_edited.fasta")
            with open(output, "w") as handle:
                    SeqIO.write(record, handle, "fasta")
            #end with
            
        #end for
    #end with
    
    #any loss of nucleotides??
    total_nts = len(str(new_SEQ_ORF1a)) + len(str(new_SEQ_ORF1b))
    
    print("\n# comparing total 'captured':", total_nts, len(str(SEQ)))
    
    print(new_SEQ_ORF1a[-10:]) # last 5 of orf1a
    print(" "*8, new_SEQ_ORF1b[0:10
                        ]) # first 5 of orf1b
    
    
    #print(new_SEQ_ORF1b[-10:])

# end outer for



# =============================================================================
# End of file
# =============================================================================


