import os

os.chdir('./ncvoters')
os.chdir('./ncvoters_data')

print("Cleaning Database Tables")

os.system('mclient -s "drop table ncvoters_joined"')
os.system('mclient -s "drop table ncvoters_preprocessed"')
os.system('mclient -s "drop table train_set"')
os.system('mclient -s "drop table Classifiers"')
os.system('mclient -s "drop table predicted"')


print("Pre-Processing")
os.chdir('../../PreProcessing')
if ((os.system('mclient combinedatasets.sql') != 0) 
or (os.system('mclient voter_preprocess_function.sql') != 0) 
or (os.system('mclient preprocesstable.sql') != 0)):
	print("Failed the Pre-Processing Step")
	exit()

print("Training and Verification")
os.chdir('../TrainingVerification')
if ((os.system('mclient add_id_ncvoters.sql') != 0) 
or (os.system('mclient voter_split_function.sql') != 0) 
or (os.system('mclient voter_train_function.sql') != 0) 
or (os.system('mclient train_set_table.sql') != 0)
or (os.system('mclient classifiers_table.sql') != 0)):
	print("Failed to Train/Verify Data")
	exit()

print("Classification")
os.chdir('../Classification')
if ((os.system('mclient voter_predict_function.sql') != 0) 
or (os.system('mclient predicted_table.sql') != 0)):
	print("Failed to Classify Data")
	exit()