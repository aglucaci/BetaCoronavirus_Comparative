# Initial Pipeline (8.3.2020)


1. Get Genomic data from ViPR (described in writeup)
2. Get reference sequence for each gene (Orf1a, Orf1b, S, M, N, E, and nsps) in each viral species from NCBI.
3. Makeblastdb and Blastn (to split gene by gene, and to get nsps from polyprotein) using references.
4. QA on blast results (local)
5a. Codon aware MSA (with mafft)
5b. QA on Codon aware MSA's
5c. TN93 Calculations
6a. RaxML (on individual genes in each viral species)
6b. QA on RAXML trees 
7. Selection Analyses: MEME, BUSTEDS, aBSREL
8. Mafft merge (alignments)
9a. RaxML on combined gene alignments
9b. QA on Trees
10. Partition lineages with phylotree
11. Selection Analyses: RELAX and Contrast-FEL
