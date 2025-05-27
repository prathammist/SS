#!/bin/bash

# Shell script to extract Scheme Name and NAV from AMFI data
URL="https://www.amfiindia.com/spages/NAVAll.txt"
TSV_FILE="amfi_nav_data.tsv"

# Fetch data and process with AWK
curl -s "$URL" | awk -F ';' '
BEGIN {
    OFS = "\t"
    print "Scheme Name", "Asset Value"
}
NF >= 5 && $4 != "" && $5 != "" {
    gsub(/"/, "", $4)  # Remove quotes if present
    gsub(/\r/, "", $5)  # Remove carriage returns
    print $4, $5
}' > "$TSV_FILE"

echo "Data saved to $TSV_FILE"
