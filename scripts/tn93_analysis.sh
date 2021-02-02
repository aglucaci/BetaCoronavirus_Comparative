#!/bin/bash



TN93="/home/aglucaci/tn93/tn93"


FILES=catted/*.compressed.codon.fas

mkdir -p TN93_results

for f in $FILES;
do
   a=${f##*/}
   echo $a
   echo $TN93 -t 1 -o TN93_results/$a".dst" $f
   $TN93 -t 1 -o TN93_results/$a".dst" $f

done






