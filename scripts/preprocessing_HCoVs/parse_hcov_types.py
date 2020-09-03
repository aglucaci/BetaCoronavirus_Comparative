#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug 31 08:12:12 2020

@author: Alexander Lucaci
"""

from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
import os
import sys


TSV = "931108446447-Results.tsv"
FASTA = "851178387142-GenomicFastaResults.fasta"

#WHAT_WE_WANT = ["OC43", "HKU1", "229E", "NL63"]

WHAT_WE_WANT = ["Betacoronavirus 1", "Human coronavirus HKU1", "Human coronavirus 229E", "Human coronavirus NL63"]

def lookup_fasta(GB_ID):
    global FASTA
    with open(FASTA, "r") as handle:
        for record in SeqIO.parse(handle, "fasta"): 
            ID = record.id
            SEQ = record.seq
            DESC = record.description
            
            if GB_ID in ID: 
                return ID, SEQ, DESC
            else:
                pass
        #end for
    #end with
    
    #if we get to here, the search was unsuccessful
    return "", "", ""
            
#end method



with open(TSV, "r") as fh:
    for n, row in enumerate(fh):
        data = row.split("\t")
        if "SARS-CoV-2" in data[0]: continue
        if "Severe acute respiratory syndrome-related coronavirus" == data[1]: continue
        if "Middle East respiratory syndrome coronavirus" == data[1]: continue
    
        if data[1] in WHAT_WE_WANT:
            print(n+1, row.split("\t"))
            
            with open (data[1] + ".fasta", "a") as output:
                #output.write(">" )
                pass
            
                GenBank_id = data[2]
                ID, SEQ, DESC  = lookup_fasta(GenBank_id)
                if ID != "" and DESC != "":
                    output.write(">" + DESC + "\n" + str(SEQ) + "\n")
                
            #end inner with
            
        #end if
    #end for
#end with


