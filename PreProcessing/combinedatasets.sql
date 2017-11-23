CREATE TABLE ncvoters_joined AS
SELECT  romney_percentage, county_id, precinct, sex_code, race_code, ethnic_code, birth_age
FROM precinct_votes
INNER JOIN ncvoters
ON ncvoters.precinct_desc=precinct_votes.precinct AND ncvoters.county_desc=precinct_votes.county
WHERE ncvoters.status_cd='A' WITH DATA;