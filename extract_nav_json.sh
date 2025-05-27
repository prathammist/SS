#!/bin/bash

URL="https://www.amfiindia.com/spages/NAVAll.txt"
JSON_FILE="amfi_nav_data.json"

curl -s "$URL" | awk -F ';' '
NF >= 5 && $4 != "" && $5 != "" {
    gsub(/"/, "", $4)
    gsub(/\r/, "", $5)
    print $4 "\t" $5
}' | jq -Rsn '
  {"navData": [
    inputs
    | . / "\n"
    | (.[] | select(length > 0) | . / "\t") as $parts
    | {"schemeName": $parts[0], "assetValue": $parts[1]}
  ]}
' > "$JSON_FILE"

echo "Data saved to $JSON_FILE"
