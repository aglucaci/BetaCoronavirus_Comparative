#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Aug  7 16:39:06 2020

@author: user

Take in the fasta produced as the blastn results
what is the distribution of NT content?
create a threshold
filter the data,
and output a new fasta with the filtered results


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

# =============================================================================
# Declares
# =============================================================================
BASEDIR = "/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020/"
path = BASEDIR + "/analysis/blastn_results"

# =============================================================================
# Helper function
# =============================================================================
def nt_content(filename,path,output_dir):
    count = 0
    nt_distribution = [] # NT content distribution among the sequences
    with open(filename, "r") as handle:
        for record in SeqIO.parse(handle, "fasta"): 
            ID = record.id
            SEQ = record.seq
            count += 1       
            nt_distribution.append(len(str(SEQ)))
        #end for
    #end with
    
    #thresholding
    #print(max(nt_distribution) * 0.99)
    threshold = int(max(nt_distribution) * 0.99)
    print("\t# Threshold:", threshold)
    #how many pass the filter
    passed = [x for x in nt_distribution if x >= threshold]
    print("\t# Number that would pass:", len(passed))
    
    output = os.path.join(output_dir, filename.split("/")[-1])
    print("\t# Saving data to:", output)
    
    # Clear out the ouput file, create a null one
    with open(output, "w") as handle:
        #SeqIO.write(record, handle, "fasta")
        handle.write("")
    #end with
    
    # Write out to file
    with open(filename, "r") as handle:
        for record in SeqIO.parse(handle, "fasta"): 
            ID = record.id
            SEQ = record.seq
            
            if len(str(SEQ)) >= threshold:
                
                #write to file.
                pass
                
                #output = filename.replace(".fasta", "_filtered.fasta")
                with open(output, "a") as handle:
                    SeqIO.write(record, handle, "fasta")
                #end with
                
            #end if
         #end for
    #end with
    return count, nt_distribution
#end total_number_seqs



# =============================================================================
# Main subroutine
# =============================================================================

# Gap analysis


for virus in ["MERS", "SARS", "SARS2"]:
    newpath = os.path.join(path, virus)
    print("## Checking:", newpath)
    output_dir = os.path.join(newpath, "blastn_QA_filtered")
    print("# Creating output directory:", output_dir)
    os.system("mkdir -p " + output_dir)
    for filename in os.listdir(newpath):
        if filename.endswith(".fasta"):
            fullpath = os.path.join(path, virus, filename)
            if "filtered" in filename: continue
            print("\t# Processing:", fullpath)
            count, nt_distribution = nt_content(fullpath, path, output_dir)
            print("\t# Number of sequences (total):", count)
            print("\t#", stats.describe(nt_distribution))
            print()
          #end if
    #end inner for
    print()
#end outer for
        
        
        

# =============================================================================
# End of file
# =============================================================================
