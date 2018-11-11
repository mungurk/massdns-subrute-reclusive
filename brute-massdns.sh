#!/bin/bash
file=$1

for domains in $(cat $file)
do
python /root/massdns/scripts/subbrute.py /root/massdns/lists/names_small.txt "$domains" \
	| massdns -r /root/massdns/lists/resolvers.txt --verify-ip -o S -s 200 -c 1; done
