CREATE TABLE train_set AS 
SELECT * 
FROM voter_split( (SELECT precinct, id FROM ncvoters_preprocessed) ) WITH DATA;