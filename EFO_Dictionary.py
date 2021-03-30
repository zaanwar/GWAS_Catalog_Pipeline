# Dictionary that stores phenotype and EFO ID

EFO_Dictionary = {'BMI' :' EFO_0008037', 'Chronic_kidney' : ' EFO_0003884','C-reactive': 'EFO_000445','End_renal' : 'EFO_000990'
             ,'Diastolic_blood':' EFO_0006336','Systolic_blood' : 'EFO_0006335','Smoking' : 'EFO_0004318','Coffee ': 'EFO_0004330','Triglyceride ': 'EFO_0004530', 'Total_cholesterol' : 'EFO_0004574', 'HDL_cholesterol': 'EFO_0004612','LDL_cholesterol':' EFO_0004195','WBC' : ' EFO_0004308','Waist-hip':' EFO_0004343','Diabetes' : ' EFO_0000400','Fasting_glucose ' : 'EFO_0004468',
              'Fasting_insulin' : ' EFO_0004468','Glomerular ': 'EFO_1002049','Hemoglobin' : 'EFO_0009208','Mean_corpuscular_hemoglobin' : ' EFO_0007629',
            'Hypertension ' : 'EFO_0000537','QRS_duration': 'EFO_0005055','QT_interval ':' EFO_0004682','PR_interval ':' EFO_0004462','Platelet ': 'EFO_0008446', 'Height':' EFO_0004339' }


#open test file
file = ('test_file.txt')
open_file = open(file).read().strip().split('\n')

list_of_EFO_IDS = [] #list of EFO_IDS

#iterate through given phenotypes and return EFO value for the given phenotype
for line in open_file:
    split_line = line.split(' ')
    phenotype  = str(split_line[1])
    print(str(split_line[1]))
    EFO_ID = EFO_Dictionary.get(phenotype)
    print(str(EFO_ID))
    list_of_EFO_IDS.append(EFO_ID)
