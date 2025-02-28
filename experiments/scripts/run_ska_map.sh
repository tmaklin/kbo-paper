#!/usr/bin/zsh

ref_fasta=$1
query_list=$2
threads=$3
tmpdir=$4

while read -r query; do
    chr_name=$(echo $query | sed 's/^.*\///g')
    index=$tmpdir/"$chr_name".skf

    ska build --threads $threads -o "$index" "$query" 2> /dev/null
    ska map --threads $threads "$ref_fasta" "$index" 2> /dev/null

done < $query_list
