CREATE TABLE ncvoters_joined AS
SELECT republican_percentage, county, precinct, sex, race, ethnicity, age
FROM precinct_votes
INNER JOIN ncvoters
ON ncvoters.precinct=precinct_votes.precinct AND ncvoters.county=precinct_votes.county
WHERE ncvoters.status='A' WITH DATA;