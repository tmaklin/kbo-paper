#!/usr/bin/env sh

set -uo pipefail

ref_fasta=$1
query_list=$2
threads=$3
tmpdir=$4

while read -r query; do
    chr_name=$(echo $query | sed 's/^.*\///g')

    ## Snippy has problems with spaces
    outdir=$tmpdir/$(echo "$chr_name" | sed 's/[[:space:]]/_/g')
    cat "$query" | sed 's/[[:space:]]/_/g'> tmp_in.fa
    snippy --force --cpus $threads --outdir "$outdir" --ref $ref_fasta --ctgs tmp_in.fa 2> /dev/null

    echo ">""$chr_name"
    sed '1d' "$outdir"/snps.aligned.fa | tr -d '\n' | sed 's/$/\n/g'

    rm tmp_in.fa

done < "$query_list"
