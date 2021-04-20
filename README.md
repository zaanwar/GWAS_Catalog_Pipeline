# GWAS Catalog Pipeline
## COMP383/483 Group 8 - Geraldine San Ramon, Zain Anwar, Jessie Chen 

### Brief Background
We are extending from results provided from the Wheeler lab’s PrediXcan results of genes associated with phenotypes. The lab is interested in finding SNPs mapped to the gene of interest in the GWAS catalog and if any SNPs were already found to be associated with the phenotype. We have designed a pipeline that is able to query for SNP-trait associations from GWAS Catalog and compare the results to the PrediXcan analysis.

## Main Goal
Automate GWAS Catalog queries of PrediXcan genes to answer the question, have SNPs in the PrediXcan gene been found to associate with a related phenotype before?

### Packages you may have to install prior to running
The R Script includes code that will install the packages, but just in case, you may also want to have it installed beforehand.
<br>
R: gwasrapidd (https://github.com/ramiromagno/gwasrapidd), biomaRt, dplyr
<br>
To install it beforehand, run these lines of R code in your environment:
<br>
`install.packages("remotes")`
<br>
`remotes::install_github("ramiromagno/gwasrapidd")`
<br>
 `install.packages("BiocManager")`
 <br>
`BiocManager::install("biomaRt")`

### Files provided in repo
- inputs folder: directory with subset input folders for full_run and test_run
- Filtering_script.py: python script for filtering GWAS Catalog snp-trait associations as related or unrelated matches to the PrediXcan phenotypes
- \***Phenotype names + EFO ID: text file containing dictionary of common phenotype descriptions and their corrresponding EFO id values (may want to use in building the Filtering_script.py EFO list)***
- README.md: description of script and manual on usage
- data.manip.R: R script that filters out ENSG gene names and phenotype descriptions from raw PrediXcan result file
- get_gwas_associations.R: R script that gets GWAS Catalog SNPs and trait associations
- \***gwas_catalog_pipeline.py: main python script to run pipeline***

### How to use
Once you have cloned the repository into your directory using this command,
<br>
`git clone https://github.com/zaanwar/GWAS_Catalog_Pipeline.git`
<br>
<br>
Make sure to move into the GWAS Catalog Pipeline directory with,
<br>
`cd GWAS_Catalog_Pipeline/`
<br>
<br>
To run the script, you will need to run the gwas_catalog_pipeline.py file, 
<br>
`python3 gwas_catalog_pipeline.py`
<br>

You will be prompted with the option of either a full run using all gene/phenotypes results from the PrediXcan analysis or a test run using the test data of only one gene/phenotype pair.

### How to adjust for own input
To adjust the pipeline for your own input, you will want to **modify the input file in the full_run folder named `example_SPrediScan_output.csv`**. You can either upload your own PrediXcan results and rename it as this or change the file pathway in the `data.manip.R` to instead read in your file. 
<br>
<br>
Additionally, you will need to **adjust the `Filtering_script.py` with an EFO_list that matches your `inputs/unique_ID-pheno.csv` output**. The EFO_list needs to contain the ENSG gene name paired with the EFO ID value for the phenotype. We've included a file called `Phenotype names + EFO ID` that contains a dictionary of common phenotype traits and their corresponding EFO ID values as a resource. Elsewise, you can look up the EFO ID on Ontology Search (https://www.ebi.ac.uk/ols/ontologies/efo). 

### Finding the outputs
All desired output files (full_snptrait_table.csv, output_related.txt, output_unrelated.txt) will be available in the `outputs` directory. Results from the filtering of the raw PrediXcan results are available in the `inputs` directory. Use the guide below for help.
<br>
- outputs/full_snptrait_table.csv: output of all appropriate SNP-trait associations extracted from GWAS Catalog using the gwasrapidd R package
- outputs/output_related.txt: output of all GWAS Catalog associations categorized to have related phenotypes to the PrediXcan results
- outputs/output_unrelated.txt: output of all GWAS Catalog associations categorized to have unrelated phenotypes to the PrediXcan results
- inputs/clean_SPrediScan_ID-pheno.csv: output of all ENSG gene names and phenotype pairs from PrediXcan
- inputs/unique_ID-pheno.csv: output of only unique ENSG gene name and phenotype pairs from PrediXcan

### Weekly Milestones
| Week  | Geraldine | Zain | Jessie |
| ------------- | ------------- |------------- | ------------- |
| Mar 15 (Repo Check #1 Mar 18)  | Focus preparing Design Doc, Continue research on background info | Continue research on GWAS Catalog API  | Continue research on gwasrapidd and ensembl  |
| Mar 22 (Initial Group Presentation Mar 23) | Add to presentation, updating documentation, work on parsing of full csv input file  | Add to presentation, look into word matching techniques (Hamming Distance)  | Add to presentation, work on test code of gwasrapidd with test input |
| Mar 29 (Progress Presentations)| Begin testing code of Jessie & Zain, work on progress presentation updates  | Work on test code of word matching with test output from Jessie’s gwasrapidd code  | Work on iteration of test code (more than 1 gene/snp)  |
| Apr 5 (Repo Check #2 Apr 8)| Work on wrapper to quickly implement Jessie & Zain’s codes together  | Implement code with other parts (Jessie’s gwasrapidd)  | Implement code with other parts (Zain’s word match)  |
| Apr 12 (Progress Presentations)| Finish up code | Finish up code  | Finish up code  |
| Apr 19 (Repo Check #3 Apr 22)| Implement code with others and troubleshoot  | Implement code with others and troubleshoot  | Implement code with others and troubleshoot  |
| Apr 26 (Final Presentation)  | Work on final presentation  | Work on final presentation  | Work on final presentation  |
| May 3 (Final Project Code)  | Final Presentations  | Final Presentations  | Final Presentations  |
