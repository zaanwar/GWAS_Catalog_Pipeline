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
hgnc_genenames <- toString(hgnc_symbols$hgnc_symbol)
hgnc_genenames <- unlist(strsplit(hgnc_genenames, ", ")) #saves the gene names as a separate list

#taking only 1st gene name and finding all variants in gene
gene1 <- hgnc_genenames[1]
variants_gene1 <- get_variants(gene_name = gene1)
snps_gene1 <- variants_gene1@genomic_contexts[c('variant_id', 'gene_name')] %>% filter(gene_name == gene1)

#taking only 1st variant from gene 1 and finding all associations
associations_snp1_gene1 <- get_associations(variant_id = snps_gene1$variant_id[1])
associations_snp1_gene_1 <- associations_snp1_gene1@associations[c('association_id', 'pvalue', 'standard_error','beta_number', 'range')]

#taking only 1st association for 1st variant from gene 1 and finding all traits
traits_snps_gene1 <- get_traits(association_id = associations_snp1_gene_1$association_id[1])
traits_snps_gene1 <- traits_snps_gene1@traits[c('trait')]
