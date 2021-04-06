import Bio
from Bio import Entrez
from Bio import SeqIO
Entrez.email = "gsanramon@luc.edu"
import os


record = SeqIO.read("EF999921.gb", "genbank")

output_handle = open("EF999921.fasta", "w")
cds_count = 0
for feature in record.features:
  if feature.type == "CDS":
    cds_count += 1
    #print(feature.qualifiers["protein_id"], feature.qualifiers["product"])
    protein_id = feature.qualifiers["protein_id"]
    product = feature.qualifiers["product"]
    feature_seq = feature.extract(record.seq)
    #FASTA output without line wrapping:
    output_handle.write(">" + ''.join(protein_id) +' '+ ''.join(product) +' from '+ str(record.id) + "\n" + str(feature_seq) + "\n")
output_handle.close()
print(str(cds_count) + " CDS sequences extracted")

logfile = open('logfile.txt', 'w+')
logfile.write('The HCMV genome (EF999921) has '+ str(cds_count) +' CDS.')
logfile.close()
