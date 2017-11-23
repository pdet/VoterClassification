CREATE TABLE Classifiers AS 
SELECT * 
FROM voter_train( 
    (SELECT republican_percentage, county, precinct, sex, race, ethnicity, age 
     FROM ncvoters_preprocessed INNER JOIN train_set ON train_set.id=ncvoters_preprocessed.id 
     WHERE train_set.train=true) ) 
WITH DATA;