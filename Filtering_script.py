#Script that filters related and unrelated results from the GWASRapid output

# List that stores ENSG gene name and associated phenotype from PrediXcan
EFO_list = [
['ENSG00000132693','EFO_000445'],
['ENSG00000132693','EFO_0004308'],
['ENSG00000160712', 'EFO_000445'],
['ENSG00000130203','EFO_0004612'],
['ENSG00000130203','EFO_0004574'],
['ENSG00000130203','EFO_0004195'],
['ENSG00000130203','EFO_000445'],
['ENSG00000135218','EFO_0004612'],
['ENSG00000079739', 'EFO_0004574'],
['ENSG00000079739', 'EFO_0004530'],
['ENSG00000158710', 'EFO_0004308'],
['ENSG00000073754', 'EFO_0004308'],
['ENSG00000132703', 'EFO_000445'],
['ENSG00000136689', 'EFO_000445'],
['ENSG00000257017', 'EFO_0004195'],
['ENSG00000257017', 'EFO_0004574'],
['ENSG00000066294', 'EFO_0004308'],
['ENSG00000143590', 'EFO_000445'],
['ENSG00000143556', 'EFO_000445'],
['ENSG00000118137', 'EFO_0004530'],
['ENSG00000243364', 'EFO_0004308'],
['ENSG00000122224', 'EFO_0004308'],
['ENSG00000160856','EFO_0004308']]



#open test file
#file = ('group8/snptrait_table_unique.csv')
file = ('inputs/full_snptrait_table.csv')
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
