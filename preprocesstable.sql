CREATE TABLE ncvoters_preprocessed AS 
SELECT * 
FROM voter_preprocess( (SELECT * FROM ncvoters_joined) ) 
WITH DATA;