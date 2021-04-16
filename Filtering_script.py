#Script that filters related and unrelated results from the GWASRapid output

# Dictionary that stores phenotype and EFO ID
EFO_Dictionary = {'BMI' :'EFO_0008037', 
'Chronic_kidney' : 'EFO_0003884',
'C-reactive': 'EFO_000445',
'End_renal' : 'EFO_000990',
'Diastolic_blood' : 'EFO_0006336',
'Systolic_blood' : 'EFO_0006335',
'Smoking' : 'EFO_0004318',
'Coffee ': 'EFO_0004330',
'Triglyceride' : 'EFO_0004530', 
'Total_cholesterol' : 'EFO_0004574', 
'HDL_cholesterol' : 'EFO_0004612',
'LDL_cholesterol' : 'EFO_0004195',
'WBC' : 'EFO_0004308',
'Waist-hip' : 'EFO_0004343',
'Diabetes' : 'EFO_0000400',
'Fasting_glucose' : 'EFO_0004468',
'Fasting_insulin' : 'EFO_0004468',
'Glomerular' : 'EFO_1002049',
'Hemoglobin' : 'EFO_0009208',
'Mean_corpuscular_hemoglobin' : 'EFO_0007629',
'Hypertension' : 'EFO_0000537',
'QRS_duration' : 'EFO_0005055',
'QT_interval' : 'EFO_0004682',
'PR_interval' : 'EFO_0004462',
'Platelet' : 'EFO_0008446', 
'Height' : 'EFO_0004339' }


#open test file
#file = ('group8/snptrait_table_unique.csv')
file = ('group8/full_snptrait_table.csv')
open_file = open(file).read().strip().split('\n')

#create outfiles, one to hold results that are of related phenotypes and on that holds those that are not related phenotypes
related_output = open('group8/output_related.txt','w')

unrelated_output = open('group8/output_unrelated.txt','w')



#iterate through given phenotypes and return EFO value for the given phenotype
for line in open_file:
    #print(line)
    split_line = line.split(',') #split string
    EFO_ID  = str(split_line[-1])
    #print(EFO_ID)
    if EFO_ID[0] == '\"':#removes quotation from the beginning of the EFO ID
        EFO_ID = EFO_ID[1:]
    if EFO_ID[-1] == '\"':#removes quotation from the end of the EFO ID
        EFO_ID = EFO_ID[:-1]
    contains_EFO_ID = EFO_ID in EFO_Dictionary.values()
    if contains_EFO_ID == True: #checks to see if EFO_ID is in the dictionary
        related_output.write(line +' \n')#if it is in the dictionary it is a related output
    else:
        unrelated_output.write(line + '\n')#if it is not in the dictionary it is an unrelated output
        
related_output.close()
unrelated_output.close()
