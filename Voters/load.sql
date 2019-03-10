COPY 7503575 RECORDS INTO ncvoters FROM '{DIR}/ncvoter_allc_utf.txt.bz2' USING DELIMITERS '\t','\n','"' NULL AS '' LOCKED BEST EFFORT;
