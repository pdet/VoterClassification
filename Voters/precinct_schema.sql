CREATE TABLE precinct_votes(county STRING, precinct STRING, total_votes INT, romney_percentage DOUBLE);
COPY INTO precinct_votes FROM '{DIR}/precinct_votes.tsv' DELIMITERS '\t';
