#!/usr/bin/zsh

replicates=1
threads=4

wrkdir="run_$(echo $(date '+%Y-%m-%d'):$RANDOM)"
mkdir -p $wrkdir
cd $wrkdir

## SKA and snippy need tmp disk space
mkdir tmp

## Prepare the reference file (need to gunzip for snippy so use same for all)
gunzip -c '../NZ_CP058217.1 Escherichia coli Nissle 1917 chromosome, complete genome.gz' > ref.fasta

## Uncompress all inputs because snippy can't read them otherwise
mkdir inputs
while read -r path; do
    name=$(echo $path | sed 's/^.*\///g' | sed 's/[.].*$//g')
    gunzip -c "../"$path > inputs/$name".fna.gz"
done < ../paths_nissle.txt

ls -d inputs/*.fna.gz > input_paths.txt

i=1
echo "tool\treal_s\tuser_s\tsys_s"

## Run replicates
while [ $i -le $replicates ]
do
    /usr/bin/time -f 'kbo\t%e\t%U\t%S' sh ../scripts/run_kbo_map.sh ref.fasta input_paths.txt $threads > /dev/null
    /usr/bin/time -f 'ska2\t%e\t%U\t%S' sh ../scripts/run_ska_map.sh ref.fasta input_paths.txt $threads tmp > /dev/null
    /usr/bin/time -f 'snippy\t%e\t%U\t%S' sh ../scripts/run_snippy.sh ref.fasta input_paths.txt $threads tmp > /dev/null
    i=$((i+1))
done
