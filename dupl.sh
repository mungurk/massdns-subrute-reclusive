#!/bin/bash
file=$1
awk '!x[$0]++' $file
