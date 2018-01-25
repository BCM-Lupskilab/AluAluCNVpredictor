# AAMR-Predictor
Alu elements, the short interspersed element numbering >1 million copies per human genome, are often found at the breakpoint junctions of genomic rearrangements that can cause disease. To identify the impact of Alu/Alu-mediated rearrangement (AAMR) on genomic variation and human health, we developed a bioinformatic approach to characterize CNV-Alus that are involved in mediating CNVs and predicted genome-wide AAMR hotspot loci. 

To query a gene or pairwise interval of interest for the predicted AAMR hotspots, we developed a tool, AAMR-Predictor, which is publicly available (http://omimexplorer.research.bcm.edu:3838/xiaofei/Alu_app/).

##Query prediction results at a gene-level

We assigned an AAMR risk score for each of 12,074 OMIM genes and 23,637 RefSeq genes seperately. The user could input a gene name (e.g., SPAST) and receive the count of tesing Alu pairs/predicted CNV-Alu pairs, the risk score, rank and the position (a red line) on the distribution of AAMR risk scores. We suggest a score of 0.6 as a loose ‘cut off’ for at-risk genes. Genes with a score greater than 0.6 might be more susceptible for AAMR. 

##Query prediction results at a genomic interval-level 

For pairs of genomic intervals, we could indicate whether any predicted Alu pair is intersecting the range pair of interest. We show the query results in a table. This process may take minutes as ~13 millions of predicted Alu pairs are quired. We provided data in both hg19 and hg38. Of note, we performed the analyses in hg19 and remapped the results to hg38. Abouth 99.6% of the testes Alu pairs remained after liftover.
