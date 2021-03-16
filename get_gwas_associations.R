#need to install gwasrappid and biomaRt R packages
install.packages("remotes")
remotes::install_github("ramiromagno/gwasrapidd")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("biomaRt")

library(gwasrapidd)
library(biomaRt)
library(dplyr)

#extracting the 
twas_genes <- read.csv('ENSG-ID_phenotype.txt', sep = '\t' )

#using Ensembl BiomaRt R package to fetch HCNC symbol names for all Ensembl ids
ensembl_ids <- twas_genes$GENE
ensembl = useEnsembl(biomart = "ensembl", dataset="hsapiens_gene_ensembl")
hgnc_symbols <- getBM(attributes=c('ensembl_gene_id', 'hgnc_symbol'),filters = 'ensembl_gene_id', values = ensembl_ids , mart = ensembl)

#using gwasrapidd to extract out GWAS catalog info
variants <- get_variants(gene_name = "CD84")
variants@genomic_contexts[c('variant_id', 'gene_name')] %>% filter(gene_name == "CD84")

