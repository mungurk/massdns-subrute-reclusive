# massdns-subrute-subdomain_list
Simple bash tool to Massdns Subrute a list of subdomain.

First you need to install massdns

usage: ./massdns-start.sh subdomains_lists.txt example (here example.* will be in the output)

Don't forget to add a good list of DNS IPs to `/massdns/lists/resolvers.txt` to avoid false positives  :D

PS: This bash is not complete, the Final idea is to look for subdomains reclusively. feel free to contribute.

