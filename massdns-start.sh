#!/bin/bash
# usage: ./massdns-start.sh domains_lists.txt domain-inscope
# Example: ./massdns-start.sh example-subdomains-list.txt example

file=$1
name=$2

# Enumerate all existen Subdomains to get more results with massdns
awk 'BEGIN{FS=OFS="."}           # Set the input and output field separator to a dot
     {
        for(i=1;i<NF;i++) {      # Number of domains to print
          for(j=i;j<NF;j++)      # For each domain element
            d=d $j OFS;          # d is the domain
          a[d $NF]               # store it in the array a
          d=""                   # Reset the domain
        }
     }
     END{
       for(i in a)               # Loop through each element of the array a
         print i                 # and print it
     }' $file > subfinder-clean-"$name".txt;

# Bruteforce all subdomains under subdomains
bash brute-massdns.sh subfinder-clean-"$name".txt \
	| cut -f1 -d' ' \
	| grep -oP  "(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]" \
        >> massdns-full-"$name".out; ./bin/massdns -r lists/resolver-local.txt -t A -o S massdns-full-"$name".out \
	| grep -oP  "(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]" \
	| egrep "^([^ ]*\.)?"$name"\."  \
	| awk '!(count[$0]++)' \
	>> result-NW-"$name".out; \
 bash dupl.sh result-NW-"$name".out | tee final-result-NW-"$name".out
