#Script that filters related and unrelated results from the GWASRapid output
file = ('inputs/ unique_ID-pheno.csv')
open_file = open(file).read().strip().split('\n')

file2 = ('Phenotype + EFO_ID_table.csv')
open_file2 = open(file2).read().strip().split('\n')
#Dictionary to hold designated phenotype and EFO_ID for reference to create the EFO_list
EFO_PHEN_DICT = {}

#create EFO+ phenotype dictionary
for line in open_file2[1:]:
    #print(line)
    splitline = line.split(',')
    EFO_ID = str(splitline[1])
    #print(EFO_ID)
    EFO_ID = EFO_ID
    Phenotype = str(splitline[0])
    Phenotype = Phenotype
    #print(Phenotype)
    EFO_PHEN_DICT[Phenotype]= EFO_ID


# List that stores ENSG gene name and associated phenotype from PrediXcan
EFO_list = []

#Replace the phenotype names with the EFO_IDs to create a list that has ENSG gene name + associated phenotype EFO_ID from PrediXcan
for line in open_file[1:]:
    split_line = line.split(',')#split line
    GENE_ID = split_line[0]
    GENE_ID = GENE_ID[1:-1]
    phenotype = split_line[1]
    phenotype = str(phenotype[1:-1])
    EFO_ID =EFO_PHEN_DICT[phenotype]
    EFO_list.append([GENE_ID, EFO_ID])

#open test file
#file = ('group8/snptrait_table_unique.csv')
file = ('outputs/full_snptrait_table.csv')
open_file = open(file).read().strip().split('\n')

#create outfiles, one to hold results that are of related phenotypes and on that holds those that are not related phenotypes
related_output = open('outputs/output_related.txt','w')

unrelated_output = open('outputs/output_unrelated.txt','w')

#writes header column names from snptrait table to the output files
firstLine = open_file.pop(0)
related_output.write(firstLine +' \n')
unrelated_output.write(firstLine + '\n')

#iterate through given SNP associations and categorizes as related/unrelated based on given list of gene/phenotype pairs
for line in open_file:
    #print(line)
    split_line = line.split(',') #split string
    ENSG_gene = str(split_line[2])
    ENSG_gene = ENSG_gene[1:-1]
    EFO_ID  = str(split_line[-1])
    if EFO_ID[0] == '\"':#removes quotation from the beginning of the EFO ID
        EFO_ID = EFO_ID[1:]
    if EFO_ID[-1] == '\"':#removes quotation from the end of the EFO ID
        EFO_ID = EFO_ID[:-1]
    gene_trait = [ENSG_gene, EFO_ID]
    contains_pair = gene_trait in EFO_list
    if contains_pair == True: #checks to see if pairing is in the list
        related_output.write(line +' \n')#if it is in the list it is a related output
    else:
        unrelated_output.write(line + '\n')#if it is not in the list it is an unrelated output
        
related_output.close()
unrelated_output.close()
