import os
import urllib
import inspect

SCRIPT_PATH =  os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe()))) # script directory
os.chdir(SCRIPT_PATH)

def cleanDB():
	print("Cleaning Database Tables")
	os.system('mclient -s "drop table ncvoters_joined"')
	os.system('mclient -s "drop table ncvoters_preprocessed"')
	os.system('mclient -s "drop table train_set"')
	os.system('mclient -s "drop table Classifiers"')
	os.system('mclient -s "drop table predicted"')

def loadData():
	os.chdir("./Voters")
	urllib.urlretrieve ("https://zenodo.org/record/2589451/files/ncvoter_allc_utf.txt.bz2?download=1", "ncvoter_allc_utf.txt.bz2")
	urllib.urlretrieve ("https://zenodo.org/record/2589451/files/precinct_votes.tsv?download=1", "rprecinct_votes.tsv")
	os.system("./load.sh")
	os.chdir("../")


def preProcessing():
	print("Pre-Processing")
	os.chdir('./PreProcessing')
	if ((os.system('mclient combinedatasets.sql') != 0) 
	or (os.system('mclient voter_preprocess_function.sql') != 0) 
	or (os.system('mclient preprocesstable.sql') != 0)):
		print("Failed the Pre-Processing Step")
	os.chdir("../")

def trainAndVerification():
	print("Training and Verification")
	os.chdir('./TrainingVerification')
	if ((os.system('mclient add_id_ncvoters.sql') != 0) 
	or (os.system('mclient voter_split_function.sql') != 0) 
	or (os.system('mclient voter_train_function.sql') != 0) 
	or (os.system('mclient train_set_table.sql') != 0)
	or (os.system('mclient classifiers_table.sql') != 0)):
		print("Failed to Train/Verify Data")
	os.chdir("../")

def classification():
	print("Classification")
	os.chdir('./Classification')
	if ((os.system('mclient voter_predict_function.sql') != 0) 
	or (os.system('mclient predicted_table.sql') != 0)):
		print("Failed to Classify Data")
	os.chdir("../")

# cleanDB()
loadData()
preProcessing()
trainAndVerification()
classification()