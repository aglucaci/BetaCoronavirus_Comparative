#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep  2 18:57:13 2020

@author: user
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
#"Middle_East" : "MERS",
#"SARS_coronavirus" : "SARS",
#"Severe_acute_respiratory_syndrome_coronavirus_2" : "SARS2"




FOLDERS = ["OC43", "229E", "HKU1", "NL63", "MERS", "SARS", "SARS2"]
#FOLDERS = ["OC43", "229E", "HKU1", "NL63"]

FILES = ["ORF1a.fasta", "ORF1b.fasta", "S.fasta", "E.fasta", "M.fasta", "N.fasta"]

DIR = "SILVERBACK"

for folder in FOLDERS:
    
    print("Searching:", folder)
    for file in FILES:
        print("\t", "Opening:", file)
        filename = os.path.join(DIR, folder, file)
        
        #INPUT
        with open(filename) as handle:
            for record in SeqIO.parse(handle, "fasta"): 
                ID = record.id
                SEQ = record.seq
                DESC = record.description
                print("\t\t",ID, DESC, "\n")
                
            #end inner for
        #end with
        
        #OUTPUT
        record.id = ""
        if folder == "SARS":
            record.description = "SARS_coronavirus" + "_" + record.description
        elif folder == "SARS2":
            record.description = "Severe_acute_respiratory_syndrome_coronavirus_2" + "_" + record.description
        elif folder == "MERS":
            record.description = "Middle_East" + "_" + record.description
        else:
            record.description = folder + "_" + record.description
        #end if
        
        output = filename
        with open(output, "w") as handle:
            SeqIO.write(record, handle, "fasta")
        #end with
            
         
    #end inner for
    
    
#end for

