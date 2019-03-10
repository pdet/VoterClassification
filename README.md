# Deep Integration of Machine Learning Into Column Stores
In this project we demonstrate how a real classification pipeline, in this case, the Voter Classification benchmark,
can be integrated into MonetDB/Python (i.e.,a column-store database).

## Requirements
This project requires a version of MonetDB installed with the embedded python udfs enabled. The python libraries, numpy and sklearn are also used. More information can be found [here](https://www.monetdb.org/blog/embedded-pythonnumpy-monetdb)

## ML Pipeline
The pipeline we use in our experiments is used to attempt to classify who people from North Carolina will vote for in the
Presidential Elections based on data from the 2012 Presidential Election. 

### Datasets.
For this purpose, we use two separate datasets:
* The [North Carolina Voters Dataset](https://zenodo.org/record/2589451/files/ncvoter_allc_utf.txt.bz2?download=1) contains the information about the individual voters. This is a dataset of
7.5M rows, where each row contains information about the
voter. There are 96 columns in total, describing characteristics such as place of residence, gender, age and ethnicity.
Note that we do not know who each person actually voted
for, as this information is not publicly available.
* The [Precint Votes Dataset](https://zenodo.org/record/2589451/files/precinct_votes.tsv?download=1) contains the aggregated voting statistics for each precinct, (i.e., how many people in
each precinct voted Democrat, and how many voted Republican). This dataset has 2751 rows, one for each precinct
in North Carolina.By combining these two datasets we can attempt to classify individual voters. We know the voting records of a specific precinct,and we know in which precinct each person voted, so we can make an educated guess who each person voted for based on this information.

### Preprocessing.
 As we do not have the true class labels for each voter, we have to generate them from the information we have about the precincts. This requires us to join the voter data with the precinct data, giving us the voting records of the precinct that each voter voted in. We then generate a “true” class label for each voter using a weighted random function based on the precinct voting records. For example, if voters in a specific precinct voted for Democrats 60% of the time, each voter in that precinct has a 60% chance of being classified as Democrat and 40% chance of being classified as Republican.


### Training. 
After we have generated the true class labels, we have to train the model using the data and the labels. However, we don’t simply want to use all the data for training. Instead, we want to divide the data into a training set and a test set to prevent overfitting. We then feed the data in the training set to the modeland store the
resulting it in the database.

### Testing. 
After the model is trained, we want to test how it performs by classifying the data in the test set and looking at the
results. We can classify the voters in the test set. After having obtained the predicted class labels, we can test the accuracy of our model by comparing against the known true class labels of the data. However, since we only have the generated class labels of the individual voters, comparing the predicted labels against those would not give us a lot of information about our classification accuracy. Instead, we aggregate the total amount of predicted votes for each party by precinct. Then we compare the aggregated predictions against the known amount of votes in each precinct.


# Papers
* [Deep Integration of Machine Learning into Column-Stores](https://openproceedings.org/2018/conf/edbt/paper-293.pdf)


