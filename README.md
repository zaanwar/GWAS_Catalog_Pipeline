# GWAS Catalog Pipeline
## COMP383/483 Group 8 - Geraldine San Ramon, Zain Anwar, Jessie Chen 

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
To run the script, you will need to run the get_gwas_associations.R file, 
<br>
`python3 gwas_catalog_pipeline.py`
<br>

You will be prompted with the option of either a full run using all gene/phenotypes results from the PrediXcan analysis or a test run using the test data of only one gene/phenotype pair.


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
