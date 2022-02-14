#!/usr/bin/env bash

# The objective is to iterate through CSV file picking up parameters for running vuln scan python script and send the results to text output


resFile="results.txt"
date="Date of scan: "$(date)

echo $date 2>&1 | tee -a $resFile
echo

cat file.txt | while IFS="," read -r host type inst; do
  if [[ $type == java ]]; then
    echo "JAVA System"
    python3 ICMAD_scanner.py --secure --no-verify-cert -H $host -P "443"$inst 2>&1 | tee -a $resFile
    echo
  elif [[ $type == abap ]]; then
    echo "ABAP System"
    python3 ICMAD_scanner.py --secure --no-verify-cert -H $host -P "54"$inst"1" 2>&1 | tee -a $resFile
    echo
  else
    echo "Following input not valid: " $host
  fi


done
