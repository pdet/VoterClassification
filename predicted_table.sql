CREATE TABLE predicted AS 
SELECT * 
FROM voter_predict( 
  (SELECT county, precinct, sex, race, ethnicity, age, ncvoters_preprocessed.id
  FROM ncvoters_preprocessed
  INNER JOIN train_set
  ON train_set.id=ncvoters_preprocessed.id
  WHERE train_set.train=false
)) WITH DATA;