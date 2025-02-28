#!/usr/bin/env sh

set -uo pipefail

ref_fasta=$1
query_list=$2
threads=$3

while read -r query; do

    kbo map --threads $threads --reference $ref_fasta "$query"

done < "$query_list"
