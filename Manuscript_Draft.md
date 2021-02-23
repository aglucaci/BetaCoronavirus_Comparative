# Human Coronavirus comparative selective pressures


## Abstract

Coronaviruses are a group of enveloped positive-sense single-stranded RNA (+ssRNA) viruses that belong to the Coronaviridae family. Seven Human coronaviruses are currently known to exist, these include: SARS-CoV-2, SARS-CoV-1, MERS-CoV, HKU1-CoV, OC43-CoV, NL63-CoV, 229E-CoV. SARS-CoV-2, the putative viral agent of COVID-19, has been observed to transmit predominantly person-to-person. Within an exponentially growing population variability and within-host adaptation is expected to yield a high number of mutations. However, the relatively reduced mutation number observed can be attributed to not only a built-in error correction mechanism (exonuclease), but also a competitive fitness landscape. Here, we report on the similarity of genetic evolution in this family through the use of comparative molecular analysis in a set of conserved viral genes.  The viral genomes contrain distinctive features, including unique signatures of adaptation and purifying selection. This widely spread viral family, in the human population represent an ongoing challenge, the use of characterization and molecular profiling may shed light on evolutionary trajectories.

Plots based on preliminary analysis via selection analyses conducted in the HyPhy [ref] suite of bioinformatic analyses in order to identify sites or lineages subject to selective pressure.

We make several categorical comparisions to contrast the evolutionary pathway and selection pressure among the Human Coronaviruses. The categories we define are the following

1. **Pandemic Coronaviruses** (SARS-CoV-2, SARS-CoV-1, MERS-CoV) and **Endemic Coronaviruses** (HKU1-CoV, OC43-CoV, NL63-CoV, 229E-CoV).
2. **Alpha-Coronaviruses** (NL63-CoV, 229E-CoV) and **Beta-Coronaviruses** (SARS-CoV-2, SARS-CoV-1, MERS-CoV, HKU1-CoV, OC43-CoV).
3. **Structural genes** (Spike, Matrix, Nucleocapsid, Envelope) and **Non-Structural genes** (ORF1a, ORF1b).

## We will explore several questions 
1. Question: Are there unique patterns of selection between viruses that infect humans within the Coronaviridae virus family.
3. We make categories to compare and contrast our results (**Alpha-CoV** vs **Beta-CoV**, **Structural** vs **Non-structural** genes, **Endemic** vs **Pandemic** viruses)
4. We find that comparing **Pandemic** vs **Endemic** shows the most difference between analyses using any of the categories, how do their selective pressures differ? 
5. The results from (4) could suggest that **pandemic** selection regimes are different than **endemic** selection regimes, meaning that there could be a certain set of selection constraints for a **pandemic** virus and a certain set of selection constraints for an **endemic** virus, if a virus follows a certain set they could become **pandemic** or **endemic**.
6. What can we learn evolutionary constraints from previous pathogen outbreaks such as SARS and MERS?

Keywords: Coronaviridae, coronavirus, SARS-CoV-2, COVID-19.

## Introduction

*What are coronaviruses?*
Coronaviruses are a group of utilitarian viruses that prolifically host switch [ref]. 'Coronaviruses, a genus of the Coronaviridae family, are enveloped viruses with a large plus-strand RNA genome. The genomic RNA is 27–32 kb in size, capped and polyadenylated.'[4]. Human coronaviruses have not been extensively studied together within the context of human host samples. In order to gain knowledge into the effects of natural selection on the SARS-CoV-2 genome in Humans following zoonotic transfer we infer novel mutations to explore evolutionary changes. We incorporate biological context from other Human Coronaviruses and compare between structural and non-structural genes. We present a comparative genomic analysis. To begin our analysis, selection constraints between MERS, SARS1, and SARS2, we identified genes that are shared between the three viral genomes. We examined published, annotated genomes and based on taxonomic similarity, we selected the following shared genes: S, M, E, N, ORF1A, and ORF1B were identified. Within ORF1A, two nonstructural proteins were selected for analysis, helicase and RNA-dependent RNA-polymerase. **{Add in the time component of introduction/spillover into the human host. And even how that impacts data available. }**

*Historical aspect of coronaviruses (ancient origins paper)*
'Coronaviruses have been identified in mice, rats, chickens, turkeys, swine, dogs, cats, rabbits, horses, cattle and humans, and can cause a variety of severe diseases including gastroenteritis and respiratory tract diseases' [4] 'HCoV-229E and HCoV-OC43 were identified in the mid-1960s, and are known to cause the common cold'[4]. Highly pathogenic human coronaviruses (HCoV) can evolve, as is evident with MERS, SARS-1, and the ongoing SARS2 pandemic. Understanding the 'relatedness' of major/highly conserved functional genetic compartments will shed light on which parts of the genome are mutable in this family. And, which parts are not mutable, a highly important constraint/property for the effective design of vaccines and therapeutics.

'The NL63 spike (S) protein mediated infection of different target cells compared with the closely related 229E-S protein but facilitated entry into cells known to be permissive to SARS-CoV-S-driven infection' [5]. NL63-S binds ACE2, as does SARS-1 [6]
The interaction also involves clatherin for NL63

*Genome organization (structural versus non-structural, accessory orfs, HE in beta-covs*

Because endemic versus pandemic viruses differ dramatically in their ability to induce disease and disease severity, 'analysis of HCoV-NL63 might unravel pathogenicity factors in SARS-CoV' [5] The recently identified SARS-CoV-2 virus causes a life-threatenening pneumonia and is now the most pathogenic human coronavirus identified. {Additional ref on SARS2 etiology, disease progress and/or symptoms.}. 'The NL63 spike (S) protein mediated infection of different target cells compared with the closely related 229E-S
protein but facilitated entry into cells known to be permissive to SARS-CoV-S-driven infection' [5]. 'The factors that determine the pathogenicity of CoVs are incompletely understood' [5] 

We examine, through comparative analysis of these viruses, how evolutionary pressures play an important role in coronavirus pathogenesis, with an emphasis on SARS-CoV-2.

*Viral and cellular tropism*

'HCoV-229E employs CD13 (aminopeptidase N) as a receptor for infection of target cells'[5]

Discuss the involvement of accessory proteins in each virus. 

Viral tropism, involvement of neurological effects in some covs and in some species (229E shows brain involvement as does SARS2) [ref]. 

Discuss genome organization, order and appearance of HE in some viral genomes.

Genomes of alpha-covs similar to pandemic viruses.

CoVs (endemic) have complex patterns of global distribution (seasonal patterns) and concentration which vary by region and/or by year . [7]

OC43 seems to peak annually in the US. the other endemic viruses show more variabiltiy throughout over a 2-3 year period.

[10] Each of the viruses we consider has their own emmergence although they are expected to have the same common ancestor. 

HE and lectin. HKU1 OC43

Roles for recombination to shape genetic variability. [10]

Mutations consisted of intial events that modulated host tropism through changes n the heptad repeats followed by emergenc of variants that escame immune response. [10]

TODO for mapped results, add the genome annotation, what part in spike for example are these results? For ORF1ab, which nsps are affected?

When pathogens jump hosts from their natural reservoir, pathogens must adapt to a new environment. Interestingly, several viruses within the Coronaviridae virus family have the ability to jump to a human host (SARS, MERS, Sars-Cov-2, HKU1, 229E, OC43, NL63). SARS, MERS, and Sars-Cov2 are the most deadly of the 7, however all 7 viruses experience adaptation in the human host. Inevitably the segments of these viral genomes will experience different levels of selective pressures as they replicate in the new host system. For example, structural proteins and non-structural proteins might experience different selective pressures. Furthermore, unique sites within these proteins might withhold key mutational information, illuminating the fitness landscape of these viruses. Identifying segments that are under high, negative selection pressure are crucial, as these segments suggest stability throughout the longevity of adaptation. 

**Humans have been infected with many different viruses from the coronaviridae virus family**. There are coronaviruses from every coronaviridae virus clade (alpha, beta, and gamma) that can infect humans. In the context of a human host, there have been two observed outcomes after coronavirus infection: the virus has either become endemic or pandemic. All instances of human pandemics have been from viruses in the Beta coronavirus clade, whereas all the current endemic viruses have been from the Alpha coronavirus clade. 


We rely on comparative analysis of known structural, physiological, immunological, and physicochemical properties to further interpret the functional consequences of these novel mutations.

*How mutation (measured through dN/dS) impacts viral stability, immune evasion, tropism is has not been examined*

*Functional considerations beyond Spike (a current focus in the field) impacts viral evolution*


In the present work we use an ensebmle of cutting edge computational approaches to detect adaptive evolutionary events across several conserved genes in the entire group of human coronaviruses. Our methods are highly sensitive, and designed to detect changes in selective pressure across lineages and genetic sequence. We focus on comparisions between pandemic and seasonal (endemic) coronaviruses found circulating in the Human population. However, we there is limited data to analyze, especially so for older pandemics and suprisingly for common-cold (endemic) viruses. We encourage active partictitpation and focus on sampling of sequences from these highly recelent viral population in the future.



## Results

We examine our results through the lense of several categorizations we have described above (The current definitions are located in the abstract.)
1. **Pandemic Coronaviruses** (SARS-CoV-2, SARS-CoV-1, MERS-CoV) and **Endemic Coronaviruses** (HKU1-CoV, OC43-CoV, NL63-CoV, 229E-CoV).
2. **Alpha-Coronaviruses** (NL63-CoV, 229E-CoV) and **Beta-Coronaviruses** (SARS-CoV-2, SARS-CoV-1, MERS-CoV, HKU1-CoV, OC43-CoV).
3. **Structural genes** (Spike, Matrix, Nucleocapsid, Envelope) and **Non-Structural genes** (ORF1a, ORF1b).


### Figure 1. (BUSTEDS [ref])


Spike
![](https://i.imgur.com/yletZ6b.png)

Nucleocapsid
![](https://i.imgur.com/8qHgwwa.png)

Envelope
![](https://i.imgur.com/qv9eG75.png)

Matrix
![](https://i.imgur.com/yMrCxyk.png)

ORF1a
![](https://i.imgur.com/gddGnow.png)

ORF1b
![](https://i.imgur.com/vUOm03t.png)

# Figure 1 text :

We used BUSTEDS to test if at least one site on at least one branch has experienced positive selection by detecting signatures of episodic diversifying selection in conserved genes across viruses. There are 3 rate classes that fit the codon model: *w<sub>1</sub>* &le; *w<sub>2</sub>* &le; 1 &le; *w<sub>3</sub>*, yellow, blue, and orange respectively. The null model is rejected if there is evidence of positive selection, eg *w<sub>3</sub>* &ge; 1.


### Pandemic versus endemic
######### SPIKE #########
For Spike, there is little evidence of positive selection in the pandemic viruses, except for about 6% of sites in in SARS-CoV-2. There is no evidence of positive selection in either SARS or MERS. There is a considerable amount of sites under negative selection in SARS-CoV-2, along with about 20% of sites in SARS. All three of the pandemic viruses show evidence for more than 1/3<sup>rd</sup> of sites evolving under neutral selection, where 85% of all sites in SARS are evolving neutrally and (check this) almost all sites in MERS are neutral in Spike. Within the endemic viruses, there is evience of positive selection at sites in 229E, albiet very little. NL63 has the highest amount of evidence for positive selection out of viruses in either category at a little over 12% of sites. Comparatively, the four viruses in the endemic category have considerably more sites evolving under negative selection than sites in the pandemic viruses. Alternatively, more sites in the pandemic viruses are evolving neutrally than sites in the endemic viruses. SARS2, 229E, and NL63 show similar patterns of evolution. 

######### Nucleocapsid #########
Two of the three pandemic viruses show significant evidence of postive selection at sites within Nucleocapsid. More than 70% of sites in SARS-CoV-2 showed evidence for positive selecetion, the highest percent of sites for any of the seven viruses. MERS has more than 30% of sites under positive selection, which is the third highest amount in this gene. Also, MERS has the second highest level of sites evolving under neutral selection. SARS has the highest level of sites evolving under negative selection compared to any other virus in either category; pandemic or endemic. Three of the four endemic viruses show evidence for positive selection at sites across nucleocapsid. HKU1 has the highest level out of the other four, at about 36%. OC43 and 229E both have similar amounts of sites under positive selection at about 3%. NL63 shows no evidence for sites under positive selection in nucleocapsid. Both OC43 and NL63 show very high levels of sites evolving under negative selection, both around 90%. Both HKU1 and 229E have large amounts of sites evolving under neutral selection. SARS2, MERS, and HKU1 show similar patterns of evolution. 

######### Envelope #########
All three of the pandemic viruses show evidence for positive selection at sites in envelope. *check on SARS2*, SARS has more sites under positive selection as compared to MERS. SARS and MERS both have considerably more sites evolving under negative selection as compared SARS-CoV-2. Regarding the endemic viruses, 229E is the only virus with a majority of sites under positive selection with the second highest amount of sites under positive selection out of any of the viruses in either category. The sites in 229E are mostly split evenly between positive and neutral selection with very few sites evolving under negative selection. The other three endemic viruses show far more evidence for sites evolving under negative selection. MERS, OC43, and NL63 show similar patterns of selection pressures.

######### Matrix #########
There is very little evidence for positive selection in sites across the gene. (check on MERS data). Both SARS-CoV-2 and SARS have less than 1% of sites evolving under positve selection. Further, sites in SARS-CoV-2 are fairly evenly split between neutral and negative selection. In the four endemic viruses at least 30% of all sites in the virus are evolving under negative selection. HKU1 has a majority of sites evolving neutrally. (check 229E) 

######### ORF1a #########
All three of the pandemic viruses show considerable amounts of sites evolving under positive selection. SARS-CoV-2 and MERS look very similar in their selective patterns, whereas SARS show more sites evolving neutrally as compared to the other two viruses. Three of the four endemic viruses show a considerable amount of sites evolving neutrally, with little evidence of sites evolving under positive selection. OC43 and NL63 are the only endemic viruses that show evidence for sites evolving under positive selection. (check 229E).


######### ORF1b #########
There is very little evidence for sites evolving under positive selection in any of the three pandemic viruses. Only about 5% of sites in ORF1b in SARS-CoV-2 show evidence for positive selection. Likewise, there is only one endemic virus that hows evidence for sites under positive selection; 229E. OC43, 229E, and NL63 show large amounts of sites evolving under negative selection, where HKU1 shows most sites evolving neutrally with about 15% of the sites evolving negatively. MERS, HKU1, and NL63 share similar patterns of evolution across this non-structural protein.


Gene: Structrual, non-structural
For .. each ${gene} we observe, ~70% of sites in N for SARS2 having this behavior....

Gene: alpha-cov, beta-cov
For .. each ${gene} we observe, ~70% of sites in N for SARS2 having this behavior....



### Structural Proteins
Nucleocapsid is the structural gene with the highest amount of positive selection across all seven of the viruses (combining pandemic and endemic). Spike and Matrix appear to have the lowest amount of sites evolving under positive selection. Envelope and Spike have the highest number of sites evolving under negative selection out of the four conserved structural proteins. Almost every one of the seven viruses across all four conserved structural genes show fairly high numbers of sites evolving neutrally. 


#### Non-Structural Proteins
ORF1a, collectively, has far more sites under positve selection as compared to ORF1b. Five of the seven viruses show evidence for positive selection in ORF1a, whereas only two viruses in ORF1b show evidence for positive selection at sites. The two viruses that show evidence for positive selection in ORF1b are considerably lower, at les than 5% of sites in both SARS-CoV-2 and 229E. ORF1a also shows the highest number of sites evolving under negative seletion compared to ORF1b.

#### alpha-cov versus beta-cov


### Figure 2. (Non-Synonymous rate across the conserved genes from the seven Human Coronaviruses, MEME [ref])
dN codon changes **does** alter the amino acid being coded for at that position. Non-synonymous changes, positive selection, has been linked to adapatations[ref]. 

Spike
![](https://i.imgur.com/S0C84Zp.png)

Nucleocapsid
![](https://i.imgur.com/MJPqhls.png)

Envelope
![](https://i.imgur.com/54Nnies.png)

Matrix
![](https://i.imgur.com/U6tDsEI.png)

ORF1a
![](https://i.imgur.com/YW5aBk2.png)

ORF1b
![](https://i.imgur.com/UqcZbVe.png)

# Figure 2 text:

We used MEME to test the hypothesis that individual sites have been subject to episodic positive or diversifying selection. With the results from MEME, we plot the dN rate values for each virus vs the coordinates of the gene. This provides us with an insight into dN rate at each site. 

### Pandemic versus endemic
######### SPIKE #########
There appears to be a pation in the spike data, where sites before around 800 in all viruses have higher rates of non-synonymous substitution. After site 800, there are very few sites showing evidence of positive selection, except for the very end of the spike gene. 

######### Nucleocapsid #########


######### Envelope #########


######### Matrix #########


######### ORF1a #########



######### ORF1b #########


#### Structural Proteins


#### Non-Structural Proteins


### Figure 3 (Synonymous rate across the conserved genes from the seven Human Coronaviruses, MEME [ref])
dS codon changes **does not** alter the amino acid being coded for at that position. This selection is refered to as negative, or purifying, selection. This is associated with some conservation of function[ref].

Spike
![](https://i.imgur.com/22sUTqe.png)

Nucleocapsid
![](https://i.imgur.com/IXCQ04x.png)

Envelope
![](https://i.imgur.com/WLIOFwV.png)

Matrix
![](https://i.imgur.com/i3QrSYC.png)

ORF1a
![](https://i.imgur.com/yYghSCt.png)

ORF1b
![](https://i.imgur.com/2iLmxCI.png)


Similar to the previous results structure
Make a note for matrix, low level of dN, however, we observe high levels of dS acorss the gene, owing to functionality that may need to be preserved.

Similarly with dS in Spike, regions in spike need to be prevserverd. While things like N can be highly adaptive... 

ORF1a and ORF1b can be highly mutatable... 

#### Structural Proteins 
There are several sites within the SARS spike protein that show increased rates of dS, as compared to the rates in the other viruses. There is (one?) site within SARS2 nucleocapsid that has a very high dS rate. Envelope shows sever sites under very high dS substitution rate from HKU1. Matrix has ... throughout the entire gene with several spikes in dS rate at the beginning of the gene within HKU1.

#### Non-Structural Proteins 
ORF1a has one large spike in dS rates coming from SARS2. ORF1b has several spikes in dS rates, from 229E and SARS2.

### Figure 4 (Statistical analysis, Compare and Contrast)

&rarr; **Spike By Coronavirus Clade**
Histogram of alpha (dS) values for each Virus Clade (Alpha-CoV or Beta-CoV)
![](https://i.imgur.com/miQjFTM.png)


Histogram of beta (dN) values for each Virus Clade (Alpha-CoV or Beta-CoV)
![](https://i.imgur.com/7CiEYpu.png)


&rarr; **Spike By Pandemic or Endemic**
Histogram of alpha (dS) values for each Virus Type (Pandemic or Endemic)
![](https://i.imgur.com/OjQf5xs.png)

Histogram of beta (dN) values for each Virus Type (Pandemic or Endemic)
![](https://i.imgur.com/HG2ibQV.png)

When examining dS and dN values across Spike between both alphacoronavirus and betacoronavirus clades, the distributions of both dS and dN appear to be similar. However, when the data are separated based on endemic vs pandemic designation the distribution of both rates appear to deviate. In both the dS and dN graphs, the pandemic viruses have far fewer sites that evolving either synonymously or non-synonymously, respectively, as compared to the endemic viruses. 

&rarr;  **ORF1a By Coronavirus Clade**
Histogram of alpha (dS) values for each Virus Clade (Alpha-CoV or Beta-CoV)
![](https://i.imgur.com/vyZQmyM.png)

Histogram of beta (dN) values for each Virus Clade (Alpha-CoV or Beta-CoV)
![](https://i.imgur.com/tNJvZN8.png)

&rarr;  **ORF1a By Pandemic or Endemic**
Histogram of alpha (dS) values for each Virus Type (Pandemic or Endemic)
![](https://i.imgur.com/jJctG7N.png)

Histogram of beta (dN) values for each Virus Type (Pandemic or Endemic)
![](https://i.imgur.com/GiqkQ1x.png)

The non-structural proteins being analyzed follow a similar pattern. When comparing alphacoronavirus vs betacoronavirus, there are fewer differences between dS and dN counts. However, when you group the viruses based on the pandemic vs endemic designation, the data separate more clearly. Again, the pandemic viruses have fewer sites evolving under either synonymously or non-synonymously.

&rarr;  **All gene analysis, Colored by Gene**
Histogram of alpha (dS) values for each Gene
![](https://i.imgur.com/AExCcsm.png)

Histogram of beta (dN) values for each Gene
![](https://i.imgur.com/01gFgNZ.png)

&rarr; **All genes by Gene Category**
Histogram of alpha (dS) values for each Gene Category (Structural or Non-Structural)
![](https://i.imgur.com/c5Qf1Gw.png)


Histogram of beta (dN) values for each Gene Category (Structural or Non-Structural)
![](https://i.imgur.com/G2PNxU5.png)
 
&rarr; **STRUCTURAL Genes Only**
All genes by Gene Category, and By Pandemic or Endemic
Histogram of alpha (dS) values for each Gene Category (Structural or Non-Structural for each Virus Type (Pandemic or Endemic)
![](https://i.imgur.com/PF3ww3v.png)

All genes by Gene Category, and By Pandemic or Endemic
Histogram of beta (dN) values for each Gene Category (Structural or Non-Structural) for each Virus Type (Pandemic or Endemic)
![](https://i.imgur.com/0xueLGB.png)

&rarr; **NON-STRUCTURAL Genes Only**
All genes by Gene Category, and By Pandemic or Endemic
Histogram of alpha (dS) values for each Gene Category (Structural or Non-Structural for each Virus Type (Pandemic or Endemic)
![](https://i.imgur.com/tOnRvDM.png)

All genes by Gene Category, and By Pandemic or Endemic
Histogram of beta (dN) values for each Gene Category (Structural or Non-Structural) for each Virus Type (Pandemic or Endemic)
![](https://i.imgur.com/Lr1iihr.png)



## Discussion



## References

1. [BUSTEDS](https://academic.oup.com/mbe/article/37/8/2430/5739973?login=true)
2. [Molecular Evolution of HumanCoronavirus Genomes ~ review](https://reader.elsevier.com/reader/sd/pii/S0966842X16301330?token=5BF3A49A015D65F3D25D4C284CCEE5B34AE8EA33F46DFDC88B9C3783D1B987A33360CD408BFB35CBA87FEC51017E8B04)
3. [On the origin and continuing evolution of SARS-CoV-2](https://watermark.silverchair.com/nwaa036.pdf?token=AQECAHi208BE49Ooan9kkhW_Ercy7Dm3ZL_9Cf3qfKAc485ysgAAAp0wggKZBgkqhkiG9w0BBwagggKKMIIChgIBADCCAn8GCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQM2gnIfKuiGVATka6OAgEQgIICULKYZDwr72XufHsNmxW0NIh2nrv-RjRfiJHjPwdRkZFsNXl-KjXM89MKo8HpkGCXLZQciqzWX4Zt6XEkfK4kTs_bsXSwVzyCGdhYMRLMWejrdoZ6oCZ2GJu_zBPG5da6cnnh7lTuPJ8sc9ACdp64r7TkwBUggqEBzXgkJ8ivWgykgKBRoBwfsDTGIJlSSKhDJQxeuf7ya1Ls93VRf1NuLdyDPOBjP_mpSEK4nsv8RKyxh-CbPy640QtzVs0GdiOzsamLl2VE0f4aEdXqljcU-COs7bsDDSKWxU_GcTPRPWtzpG7K-MJC3LxhgilA4z4LxSi9ayYEIVkIBVvk0Uf6JQKjRL7fzOk2fJI4eoP5fvTph2n3Cyx22FkdtvdnApj-brzErSuuWbrwtlvBiSrBAXVO8r7tfMX_s3aXGnXNiz7G28U9e7Wj0v6mkm3B3u0gkoaA9TThz27BvFL4dvMXIzNKJX-fGhIpr68L8hOkbuuHrsSyanxZi4gIbwUpj2cr8SKdqmzTC1p3wCCk8u23sUWBSZjmqY5f8r7hCqyWBdwHryCAJ301eY2pbeiImHjKX7sLlLbuLIiHokjc-04sc1aWmv-AhwXmBmJaou7s8o-OKRSxU6p1wfPlWnwPudmkYIpyr-QPeXes5jq7GrH1v-k9_ob7DUwxxSPHQZ36Yfb_d8tw4cJSxmrvqWS1a73-8Y3jbuC8deBQfJ1tJsH0VOJthpUI4vUagu7v1gqcTSkaXEbRzq0kBfHJsieyCwwFL_4mIxqEoKRUqjl8MAEvgRE)
4. Identification of a new human coronavirus https://www.nature.com/articles/nm1024 (This paper describes the first observation of NL63)
5. Human coronavirus NL63 employs the severe acute respiratory syndrome coronavirus receptor for cellular entry https://www.pnas.org/content/102/22/7988.short
6. Entry of Human Coronavirus NL63 into the Cell https://jvi.asm.org/content/92/3/e01933-17.short (supports a case for NL63 activity through ACE2 and clatherin, not CD13 as with 229E)
7. Human coronavirus circulation in the United States 2014–2017 [Link](https://www.sciencedirect.com/science/article/pii/S1386653218300325?casa_token=lw6_NWG_0DkAAAAA:2BjncTXqSQ2wl8sLX6mH6SanWloOKfSxqb-umWf1lUefwDDo8okE5Kh7TL_BhR1uEk8QdpIhffI)
8. Reference: Human Coronavirus-229E, -OC43, -NL63, and -HKU1 https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7204879/
9. Review: Human Coronavirus: Host-Pathogen Interaction https://www.annualreviews.org/doi/pdf/10.1146/annurev-micro-020518-115759
10. Review: Molecular Evolution of Human Coronavirus Genomes [Link](https://www.sciencedirect.com/science/article/pii/S0966842X16301330?casa_token=ELfDKrvzvDAAAAAA:xH1QiaHwbuAyjAL9Qjmv2S_M33rpWIsEcMIqbX3Z_P_EAdeFBvKLNEeHjV-5xoBHDuedl2413fk)
11. Molecular Evolution of MERS Coronavirus: Dromedaries as a Recent Intermediate Host or Long-Time Animal Reservoir? https://www.mdpi.com/1422-0067/18/10/2138/htm
12. Synonymous mutations and the molecular evolution of SARS-CoV-2 origins https://academic.oup.com/ve/article/7/1/veaa098/6047024?login=true
13. Novel human coronavirus (SARS-CoV-2): A lesson from animal coronaviruses https://www.sciencedirect.com/science/article/pii/S0378113520302935
14. The human coronavirus HCoV-229E S-protein structure and receptor binding https://elifesciences.org/articles/51230
15. Computational Inference of Selection Underlying the Evolution of the Novel Coronavirus, Severe Acute Respiratory Syndrome Coronavirus 2 https://jvi.asm.org/content/94/12/e00411-20.abstract


## Supplement


### Supp. Figure 1. 
Estimate of omega values (a measure of selective pressure) at sites along the *Spike* gene alignment from the seven Human Coronaviruses.
![](https://i.imgur.com/VKmMWQM.png)


![](https://i.imgur.com/bEVFsq6.png)


![](https://i.imgur.com/nssVW09.png)


![](https://i.imgur.com/Mx3ZVU8.png)


![](https://i.imgur.com/f3KAgxU.png)


![](https://i.imgur.com/30vo1wn.png)


![](https://i.imgur.com/kWfLMY1.png)


### Supp. Figure 2a (Mapped to SARS-CoV-2)
Spike
![](https://i.imgur.com/fpzbHVw.png)

Nucleocapsid
![](https://i.imgur.com/bjQJh1w.png)

Envelope
![](https://i.imgur.com/foPDYRB.png)

Matrix
![](https://i.imgur.com/TEd5srr.png)

ORF1a
![](https://i.imgur.com/4Vh5Qdx.png)

ORF1b
![](https://i.imgur.com/r332p8D.png)

### Supp. Figure 2b (Mapped to SARS-CoV-2, Table)

|      | Gene   |   SARS-CoV-2 Position | Evolutionary Support   |
|-----:|:-------|----------------------:|:-----------------------|
|    4 | S      |                     5 | SAR2                   |
|   12 | S      |                    13 | OC43                   |
|   48 | S      |                    49 | SAR2                   |
|   51 | S      |                    52 | OC43                   |
|   52 | S      |                    53 | OC43                   |
|   53 | S      |                    54 | SAR2                   |
|   55 | S      |                    56 | OC43                   |
|  112 | S      |                   113 | OC43                   |
|  158 | S      |                   159 | OC43                   |
|  161 | S      |                   162 | OC43                   |
|  164 | S      |                   165 | OC43                   |
|  193 | S      |                   194 | OC43                   |
|  222 | S      |                   223 | NL63                   |
|  264 | S      |                   265 | OC43                   |
|  266 | S      |                   267 | OC43                   |
|  267 | S      |                   268 | OC43                   |
|  268 | S      |                   269 | OC43                   |
|  272 | S      |                   273 | OC43                   |
|  295 | S      |                   296 | NL63                   |
|  396 | S      |                   397 | OC43                   |
|  471 | S      |                   472 | OC43                   |
|  482 | S      |                   483 | OC43                   |
|  496 | S      |                   497 | OC43                   |
|  505 | S      |                   506 | OC43                   |
|  557 | S      |                   558 | OC43                   |
|  574 | S      |                   575 | SAR2                   |
|  677 | S      |                   678 | SAR2                   |
|  679 | S      |                   680 | SAR2                   |
|  754 | S      |                   755 | SAR2                   |
|  780 | S      |                   781 | SAR2                   |
|  834 | S      |                   835 | HKU1                   |
| 1022 | S      |                  1023 | HKU1                   |
| 1026 | S      |                  1027 | HKU1                   |
| 1126 | S      |                  1127 | SAR2                   |
| 1190 | S      |                  1191 | OC43                   |
| 1244 | S      |                  1245 | OC43                   |
|   20 | M      |                    21 | MERS                   |
|   84 | M      |                    85 | MERS                   |
|  198 | M      |                   199 | OC43                   |
|    4 | E      |                     5 | SAR2                   |
|    8 | E      |                     9 | SAR2                   |
|   18 | E      |                    19 | SAR2                   |
|   29 | E      |                    30 | SAR2                   |
|   35 | E      |                    36 | SAR2                   |
|   36 | E      |                    37 | SAR2                   |
|   42 | E      |                    43 | SAR2                   |
|   61 | E      |                    62 | SAR2                   |
|   67 | E      |                    68 | SAR2                   |
|   70 | E      |                    71 | SAR2                   |
|   72 | E      |                    73 | SAR2                   |
|   74 | E      |                    75 | SAR2                   |
|   12 | N      |                    13 | SAR2                   |
|   81 | N      |                    82 | OC43                   |
|  120 | N      |                   121 | HKU1                   |
|  210 | N      |                   211 | SAR2                   |
|  307 | N      |                   308 | MERS                   |
|  328 | N      |                   329 | SAR2                   |
|  381 | N      |                   382 | NL63                   |
|  264 | ORF1a  |                   265 | SAR2                   |
|  326 | ORF1a  |                   327 | OC43                   |
|  518 | ORF1a  |                   519 | SAR2                   |
|  544 | ORF1a  |                   545 | OC43                   |
|  552 | ORF1a  |                   553 | MERS                   |
|  675 | ORF1a  |                   676 | SAR2                   |
|  693 | ORF1a  |                   694 | NL63                   |
|  950 | ORF1a  |                   951 | MERS                   |
|  963 | ORF1a  |                   964 | OC43                   |
| 1100 | ORF1a  |                  1101 | SAR2                   |
| 1375 | ORF1a  |                  1376 | SAR2                   |
| 1637 | ORF1a  |                  1638 | MERS                   |
| 1654 | ORF1a  |                  1655 | MERS                   |
| 1839 | ORF1a  |                  1840 | MERS                   |
| 1840 | ORF1a  |                  1841 | SAR2                   |
| 1942 | ORF1a  |                  1943 | OC43                   |
| 1945 | ORF1a  |                  1946 | OC43                   |
| 2033 | ORF1a  |                  2034 | SAR2                   |
| 2124 | ORF1a  |                  2125 | SAR2                   |
| 2244 | ORF1a  |                  2245 | SAR2                   |
| 2541 | ORF1a  |                  2542 | OC43                   |
| 2603 | ORF1a  |                  2604 | SAR2                   |
| 2624 | ORF1a  |                  2625 | OC43                   |
| 2641 | ORF1a  |                  2642 | OC43                   |
| 2702 | ORF1a  |                  2703 | SAR2                   |
| 2842 | ORF1a  |                  2843 | SAR2                   |
| 3076 | ORF1a  |                  3077 | SAR2                   |
| 3090 | ORF1a  |                  3091 | SAR2                   |
| 3353 | ORF1a  |                  3354 | SAR2                   |
| 3405 | ORF1a  |                  3406 | SAR2                   |
| 3543 | ORF1a  |                  3544 | OC43                   |
| 3607 | ORF1a  |                  3608 | SAR2                   |
| 3645 | ORF1a  |                  3646 | SAR2                   |
| 3758 | ORF1a  |                  3759 | SAR2                   |
| 3760 | ORF1a  |                  3761 | NL63                   |
| 3778 | ORF1a  |                  3779 | SAR2                   |
| 3798 | ORF1a  |                  3799 | MERS                   |
| 3842 | ORF1a  |                  3843 | NL63                   |
| 4086 | ORF1a  |                  4087 | OC43                   |
| 4091 | ORF1a  |                  4092 | SAR2                   |
| 4099 | ORF1a  |                  4100 | SAR2                   |
|   15 | ORF1b  |                    16 | SAR2                   |
|   16 | ORF1b  |                    17 | SAR2                   |
|  313 | ORF1b  |                   314 | SAR2                   |
|  481 | ORF1b  |                   482 | SAR2                   |
|  764 | ORF1b  |                   765 | SAR2                   |
| 1128 | ORF1b  |                  1129 | SAR2                   |
| 1314 | ORF1b  |                  1315 | SAR2                   |
| 1549 | ORF1b  |                  1550 | SAR2                   |
| 1572 | ORF1b  |                  1573 | MERS                   |
| 1700 | ORF1b  |                  1701 | SAR2                   |
| 2308 | ORF1b  |                  2309 | HKU1                   |
| 2556 | ORF1b  |                  2557 | SAR2                   |
| 2612 | ORF1b  |                  2613 | SAR2                   |       |

### Supp. Figure 3 (FUBAR [ref])
![](https://i.imgur.com/E1zMFXl.png)


### Supp. Figure 4 (MEME [ref])
KDE Plot for Omega Values, Alpha-Coronaviruses
![](https://i.imgur.com/XDrytrJ.png)

KDE Plot for Omega Values, Beta-Coronaviruses
![](https://i.imgur.com/Ce1LFNa.png)

### Supp. Figure 5 (TN93 Distance plots [ref])
Spike
![](https://i.imgur.com/9glsrYl.png)

Nucleocapsid
![](https://i.imgur.com/tH45CmB.png)

Envelope
![](https://i.imgur.com/S7H16u7.png)

Matrix
![](https://i.imgur.com/oM9t91h.png)

ORF1a (this plot does not have SARS2 data, ran into a problem generating the figure when added.)
![](https://i.imgur.com/JrsJolA.png) 

ORF1b
![](https://i.imgur.com/crNL4oV.png)

### Supp. Figure 6 (Data Characteristics, ViPR)



| # | Virus    | N (Whole Genomes) |
| -------- | -------- | -------- |
| 1     | SARS-CoV-2     | 10,187     |
| 2     | SARS-CoV-1      | 53     |
| 3     | MERS-CoV     | 139     |
| 4     | HKU1-CoV     | 25     |
| 5     | OC43-CoV     | 139     |
| 6     | NL63-CoV      | 61     |
| 7     | 229E-CoV     | 27     |

### Other things to explore, GC content, codon usage bias.

### A structural figure of lets say spike, with all of the mutations highlighted with evolutionary support (mapped.)



---
## SARS2 genome:
![](https://imgur.com/n2Z4W3v.png)

## Story papers
### Viral stability
1. [The Nucleocapsid Protein of SARS CoV-2: a Target for Vaccine Development](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7307180/pdf/JVI.00647-20.pdf)
This paper claims that N is "stable"

"In contrast, the N gene is more conserved and stable, with 90% amino acid homology and fewer mutations over time"... MEME says otherwise"

### Viral comparisons: 
Show that SARS2 **is** different than the other covs that infect humans

Show that SARS2 is **not** different.

### Immune evasion/ viral evolution
What sticks out the most is immune evasion in the human host (of SARS2) seems to be mostly attributed to NSPs from ORF1, CFEL results show that ORF1a and ORF1b are the **most** differnt out of all the SARS2 vs All comparisons. 

1. [Atypical Divergence of SARS-CoV-2 Orf8 from Orf7a within the
Coronavirus Lineage Suggests Potential Stealthy Viral Strategies
in Immune Evasion](https://mbio.asm.org/content/mbio/12/1/e03014-20.full.pdf)

2. [The ORF8 Protein of SARS-CoV-2 Mediates Immune Evasion through Potently Downregulating MHC-I](https://www.biorxiv.org/content/10.1101/2020.05.24.111823v1.full.pdf)


3. [Structural basis for translational shutdown and immune evasion by the Nsp1 protein of SARS-CoV-2](https://science.sciencemag.org/content/sci/369/6508/1249.full.pdf)
Falls within ORF1a


### Tropism
1. [A new transmission route for the propagation of the SARS-CoV-2 coronavirus](https://www.medrxiv.org/content/10.1101/2020.02.14.20022939v1)
Suggests a "double pandemic" where the mutliple tropisms play a role in the continued spread. Gut vs lung tropic environment

2. [First Case of 2019 Novel Coronavirus in the United States](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7092802/pdf/NEJMoa2001191.pdf)
This indicates the patient had virus in lung and stool, suggesting different tropisms

3. [Roles of host small RNAs in the evolution and host tropism of coronaviruses](https://academic.oup.com/bib/advance-article/doi/10.1093/bib/bbab027/6137178)
Find these RNAi sites and see where they would usually fall

4. [Differential Tropism of SARS-CoV
and SARS-CoV-2 in Bat Cells](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7706959/pdf/20-2308.pdf)
Showing RDB as primary source of tropic change

## Old abstract
SARS-CoV-2, the putative viral agent of COVID-19, has been observed to transmit predominantly person-to-person. Within an exponentially growing population variability and within-host adaptation is expected to yield a high number of mutations. However, the relatively reduced mutation number observed can be attributed to not only a built-in error correction mechanism (exonuclease), but also a competitive fitness landscape. To gain knowledge into the effects of natural selection on the SARS-CoV-2 genome in Humans following zoonotic transfer we infer novel mutations to explore evolutionary changes. We infer novel mutations within the SARS-CoV-2 genome in the context of zoonotic spillovers into Humans in order to explore the effects of natural selection. Structural and non-structural public sequence information was gathered from both the Virus Pathogen Resource (ViPR), and Virus Variation databases representing SARS-CoV-1, MERS-CoV, SARS-CoV-2, HCoV-HKU1, HCoV-229E, HCoV-OC43, HCoV-NL63. In the present study, each paralogous (or homologous?) protein (Spike, Matrix, Envelope, Nucleocapsid, ORF1a, and ORF1b) between the seven human coronaviruses is subjected to a suit of site based and branch based selection analyses using the Hypothesis testing using Phylogenies (HyPhy) software package. 

In the Spike region alone a Mixed Effects Model of Evolution (MEME) model identified 14 novel sites. Analysis across lineages requires codon-aware alignments from each of the seven viruses to be combined together and the inference of a partitioned, maximum likelihood tree. Contrast-FEL (CFEL) was used to test for differences in selective pressures at individual sites among clades, and found 158 sites of interest within Spike. To test for episodic selection intensities across specific lineages, RELAX was used to identify several lineages within the SARS2-CoV-2 clade where evidence for the strength of selection has been intensified. We rely on comparative analysis of known structural, physiological, immunological, and physicochemical properties to further interpret the functional consequences of these novel mutations.

### Figure X. (CFEL [ref])
S length: 2190
M length: 451
E length: 151
N length: 1405
ORF1a length: 4240
ORF1b length: 2252


|              | SARS2 | SARS | MERS | HKU1 | OC43 | NL63 | 229E |
|:------------:|:-----:|:----:|:----:|:----:|:----:|:----:|:----:|
| Spike        | 102   | 67   | 156  | 31   | 89   | 78   |  51  |
| Matrix       | 14    | 10   | 16   | 2    | 4    | 8    |  5   |
| Envelope     | 8     | 2    | 0    | 0    | 4    | 18   |  3   |
| Nucleocapsid | 79    | 12   | 19   | 25   | 13   | 13   |  9   |
| ORF1a        | 478   | 121  | 224  | 72   | 126  | 115  |  113 |
| ORF1b        | 386   | 25   | 121  | 38   | 58   | 64   |  55  |

Viz of this table (normalized)
![](https://imgur.com/n0oIWMw.png)

### Figure X. Use MEME data to examine a (# of selected sites)/(total sites)
this will give a quick indication of how much selection is happening per length of gene, this addresses the question: is SARS2 evolving more rapidly per codon vs other covs

FROM OCTOBER

|              | SARS2      | SARS  | MERS      | HKU1      | OC43      | NL63     | 229E     |
|:------------:|:----------:|:-----:|:---------:|:---------:|:---------:|:--------:|:--------:|
| Spike        | 0.007 (9)  | 0 (0) | 0 (0)     | 0.003 (4) | 0.019 (26)| 0.003 (4)| 0.004 (5)|
| Matrix       | 0  (0)     | 0 (0) | 0.009 (2) | 0 (0)     | 0.004 (1) | 0 (0)    | 0 (0)    |
| Envelope     | 0.158 (12) | 0 (0) | 0 (0)     | 0 (0)     | 0 (0)     | 0 (0)    | 0 (0)    |
| Nucleocapsid | 0.007 (3)  | 0 (0) | 0.002 (1) | 0.002 (1) | 0.002 (1) | 0.002 (1)| 0 (0)    |
| ORF1a        | 0.005 (22) | 0 (0) | 0.001 (6) | 0 (0)     | 0.003 (11)| 0.001 (3)| 0 (0)    |
| ORF1b        | 0.004 (11) | 0 (0) | 0.0003 (1)| 0.0003 (1)| 0 (0)     | 0 (0)    | 0 (0)    |

MEME rates 
![](https://imgur.com/h6ow8bx.png)
<!---!
comment 
[](https://imgur.com/FZy8aZR.png)

![](https://imgur.com/3gkjnrn.png)
--->