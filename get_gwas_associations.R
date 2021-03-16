install.packages("remotes")
remotes::install_github("ramiromagno/gwasrapidd")
library(gwasrapidd)

variants <- get_variants(study_id = "GCST002305")
variants@genomic_contexts[c('variant_id', 'gene_name')]
variants@ensembl_ids[c('ensembl_id')]

