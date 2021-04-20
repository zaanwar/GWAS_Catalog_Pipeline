#get current directory
#wk.dir <- getwd()

#rawSPrediScan.filename <- ("example_SPrediScan_output.csv")
#raw.file.path <- paste(wk.dir, "/", "GWAS_Catalog_Pipeline/group8", "/", sep = "")  
  
#raw.file <- read.csv(paste(p.data.raw, rawSPrediScan.filename, sep = ""), stringsAsFactors = FALSE)
raw.file <- read.csv("inputs/full_run/example_SPrediScan_output.csv", stringsAsFactors = FALSE)

library(purrr) #to use map
GENE <- as.character(map(strsplit(raw.file$GENE, split="_"),2))
Phenotype <- raw.file$Phenotype

ensg.pheno <- cbind(GENE,Phenotype)
#write.csv(ensg.pheno, paste(raw.file.path, "clean_SPrediScan_ID-pheno.csv", sep = ""), row.names = FALSE)
write.csv(ensg.pheno, "inputs/clean_SPrediScan_ID-pheno.csv", row.names = FALSE)

#get unique GENE & phenotype separately
unique(GENE) #17 unique genes
unique(Phenotype) #6 unique phenotypes

#get unique gene & phenotype pair only (to eliminate duplicate combo)
uniq.combo <- unique(ensg.pheno)
#write in separate file
#write.csv(uniq.combo, paste(raw.file.path, "unique_ID-pheno.csv", sep = ""), row.names = FALSE)
write.csv(uniq.combo, "inputs/unique_ID-pheno.csv", row.names = FALSE)
