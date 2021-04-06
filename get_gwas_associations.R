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
#twas_genes <- read.csv('group8/ENSG-ID_phenotype.txt', sep = '\t' )
#test_input <- twas_genes %>%
#  distinct(Phenotype, .keep_all = TRUE)
#write.table(test_input, "test_ENSG-ID_phenotype.txt", sep = "\t")
twas_genes <- read.csv('group8/test_ENSG-ID_phenotype.txt', sep = "\t")

#using Ensembl BiomaRt R package to fetch HCNC symbol names for all Ensembl ids
ensembl_ids <- twas_genes$GENE
ensembl = useEnsembl(biomart = "ensembl", dataset="hsapiens_gene_ensembl")
hgnc_symbols <- getBM(attributes=c('ensembl_gene_id', 'hgnc_symbol'),filters = 'ensembl_gene_id', values = ensembl_ids , mart = ensembl)

#using gwasrapidd to extract out GWAS catalog info
hgnc_genenames <- toString(hgnc_symbols$hgnc_symbol)
hgnc_genenames <- unlist(strsplit(hgnc_genenames, ", ")) #saves the gene names as a separate list

#function takes in a gene and finds the name of all variant snp ids under that gene
get_snps <- function(gene){
  variants_gene <- get_variants(gene_name = gene)
  snps_gene <- variants_gene@genomic_contexts[c('gene_name', 'variant_id')] %>% filter(gene_name == gene)
  
  gene_table <- as.data.frame(snps_gene)
  gene_table <- distinct(gene_table)
  all_snps <- gene_table$variant_id
  return(all_snps)
}

#function takes in a list of snps and gene and finds the phenotype traits for the snp associations
get_top_traits <- function(snp, gene){
  associations_snp_gene <- get_associations(variant_id = snp)
  associations_snp_gene <- associations_snp_gene@associations[c('association_id', 'pvalue', 'standard_error','beta_number', 'range')]
  top_association_snp_gene <- associations_snp_gene[which.min(associations_snp_gene$pvalue),]
  top_association_snp_gene$snp = snp
  
  if (nrow(top_association_snp_gene) == 0){
    top_association_snp_gene = data.frame("association_id" = NA, "pvalue" = NA, "standard_error" = NA, "beta_number" = NA, "range" = NA, "snp" = snp, "traits" = NA, "efo_id" = NA,  "gene" = gene)
  }
  else {
    traits_snps_gene <- get_traits(association_id = top_association_snp_gene$association_id)
    traits_snps_gene <- traits_snps_gene@traits[c('trait')]
    traits_snps_gene <- paste(unlist(traits_snps_gene), collapse=', ')
    
    top_association_snp_gene$traits = traits_snps_gene
    top_association_snp_gene$gene = gene
    
    list_of_traits <- unlist(strsplit(traits_snps_gene, ", "))
    list_of_efo_ids <- c()
    for (trait in list_of_traits){
      efo_id <- get_traits(efo_trait = trait)
      efo_id <- efo_id@traits[c('efo_id')]
      efo_id <- efo_id[1]$efo_id
      list_of_efo_ids <- append(list_of_efo_ids, efo_id)
    }
    
    traits_snps_efo_ids <- paste(unlist(list_of_efo_ids), collapse=', ')
    top_association_snp_gene$efo_id = traits_snps_efo_ids
  }
  return(top_association_snp_gene)
}

#looping through to get all of the genes for their snp x phenotype trait information
print("getting GWAS Catalog snp info of input genes")
snp_table = data.frame()
for (gene in hgnc_genenames){
  print(gene)
  all_snps <- get_snps(gene)
  for (snp in all_snps){
    all_snps_info <- get_top_traits(snp, gene)
    snp_table <- rbind(snp_table, all_snps_info)
  }
}

snp_table <- snp_table[c(8,6,1,2,3,4,5,7,9)]
write.csv(snp_table, 'snptrait_table.csv')
