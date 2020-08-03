# Initial Pipeline (8.3.2020)


<b>1.</b> Get Genomic data from ViPR (described in writeup) <br>
2. Get reference sequence for each gene (Orf1a, Orf1b, S, M, N, E, and nsps) in each viral species from NCBI.<br>
3. Makeblastdb and Blastn (to split gene by gene, and to get nsps from polyprotein) using references.<br>
4. QA on blast results (local) <br>
5a. Codon aware MSA (with mafft)<br>
5b. QA on Codon aware MSA's<br>
5c. TN93 Calculations<br>
6a. RaxML (on individual genes in each viral species)<br>
6b. QA on RAXML trees <br>
7. Selection Analyses: MEME, BUSTEDS, aBSREL<br>
8. Mafft merge (alignments)<br>
9a. RaxML on combined gene alignments<br>
9b. QA on Trees<br>
10. Partition lineages with phylotree<br>
11. Selection Analyses: RELAX and Contrast-FEL<br>
