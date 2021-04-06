wk.dir <- getwd()

rawSPrediScan.filename <- ("example_SPrediScan_output.csv")
raw.file.path <- paste(wk.dir, "/", "GWAS_Catalog_Pipeline/group8", "/", sep = "")  
  
raw.file <- read.csv(paste(p.data.raw, rawSPrediScan.filename, sep = ""), stringsAsFactors = FALSE)

library(purrr) #to use map
GENE <- as.character(map(strsplit(raw.file$GENE, split="_"),2))
Phenotype <- raw.file$Phenotype

ensg.pheno <- cbind(GENE,Phenotype)

write.csv(ensg.pheno, paste(raw.file.path, "clean_SPrediScan_ID-pheno.csv", sep = ""), row.names = FALSE)
