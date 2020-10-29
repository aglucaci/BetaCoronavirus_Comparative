#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun May  3 15:25:53 2020

@author: alexander g lucaci
"""

import json, csv, os
import sys

#input_json = "../analysis/Alignments/MERS/compressed/analyses/MERS_ORF1a.fasta_CODON_AWARE_ALN_compressed.fas.MEME.json"
input_directory =  "../analysis/Alignments/MERS/compressed/analyses"


def return_sites(input_json):
    print("# Processing:", input_json)
    with open(input_json, "r") as fh:
            json_data = json.load(fh)
            
            
            MLE = json_data["MLE"]
            site = 1
            site_location = []
            for item in  MLE["content"]["0"]:
                # a, B-, p-, B+, p+, p-value, #branches under selection, total branch length
                #[0, 0, 0.9646836505072091, 1673.182452468894, 0.03531634949279094, 4.895874093463512, 0.03978260556026814, 3, 1.116174711899232]
                
                alpha = item[0]
                beta_minus = item[1]
                p_minus = item[2]
                p_value = item[6]
                
                if float(p_value) < 0.1 and float(p_value) != 0:
                    #print(site, item, alpha)
                    #print("\t", site)
                    site_location += [str(site)]
                site += 1
                # sys.exit(1)
            #end for
    #end with
    print(len(site_location), "Site(s):", ", ".join(site_location))
#end method



for root, dirs, files in os.walk(input_directory):
    for each_file in files:
        if "MEME.json" not in each_file: continue
        name, ext = os.path.splitext(each_file)
        #print(each_file)
        file = os.path.join (root, name + ext)
        return_sites(file)
        print()