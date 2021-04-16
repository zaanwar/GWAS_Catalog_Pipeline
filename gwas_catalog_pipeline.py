import os
#creating output file
os.system("mkdir outputs")
#running all scripts
os.system("Rscript data.manip.R")
os.system("Rscript get_gwas_associations.R")
os.system("python3 Filtering_script.py")
