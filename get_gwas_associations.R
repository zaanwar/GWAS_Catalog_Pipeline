#prompt user with option to do full or test run
cat("Type in 'full' for full run or 'test' to run with test data: ")
runtype <- readLines(file("stdin"), n = 1L)
runtype <- as.character(runtype)
print(runtype)

#need to install gwasrappid and biomaRt R packages
install.packages("remotes", repos = "http://cran.us.r-project.org")
remotes::install_github("ramiromagno/gwasrapidd", force = TRUE)
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager", repos='http://cran.us.r-project.org')
BiocManager::install("biomaRt")

library(gwasrapidd)
library(biomaRt)
library(dplyr)

if (runtype == "test"){
  #extracting the twas results with only 1 gene name/phenotype pair
  twas_genes <- read.csv('inputs/test_run/test_ENSG-ID_phenotype.txt', sep = "\t")
} else if (runtype == "full"){
  #extracting the full twas results with the gene names and the phenotypes
  twas_genes <- read.csv('inputs/unique_ID-pheno.csv')  
} else{
  print("ERROR")
}

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
   top_association_snp_gene = data.frame("association_id" = NA, "pvalue" = NA, "standard_error" = NA, "beta_number" = NA, "range" = NA, "snp" = snp, "traits" = NA, "efo_id" = NA,  "hgnc_symbol" = gene)
   }
  else {
    traits_snps_gene <- get_traits(association_id = top_association_snp_gene$association_id)
    traits_snps_gene <- traits_snps_gene@traits[c('trait')]
    traits_snps_gene <- paste(unlist(traits_snps_gene), collapse=', ')
    
    top_association_snp_gene$traits = traits_snps_gene
    top_association_snp_gene$hgnc_symbol = gene
    
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
  cat("getting all SNPs for gene: ", end ="")
  print(gene)
  all_snps <- get_snps(gene)
  for (snp in all_snps){
    print(snp)
    all_snps_info <- get_top_traits(snp, gene)
    snp_table <- rbind(snp_table, all_snps_info)
  }
}

snp_table <- merge(snp_table, hgnc_symbols, by = 'hgnc_symbol')
full_snp_table <- snp_table[c(1,10,7,2,3,4,5,6,8,9)]

write.csv(full_snp_table, 'outputs/full_snptrait_table.csv')
