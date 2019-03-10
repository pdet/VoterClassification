sed -e "s|{DIR}|$(pwd)|" load.sql > load.sql.local
sed -e "s|{DIR}|$(pwd)|" precinct_schema.sql > precinct_schema.sql.local
mclient schema.sql 
mclient load.sql.local
mclient convert.sql
mclient precinct_schema.sql.local

