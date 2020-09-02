#!/bin/bash
clear


for folder in 229E HKU1 NL63 MERS SARS SARS2 OC43; do
    echo "Processing: "$folder
    
    #FILE='ls /Users/user/Desktop/HCoV/$folder/*.fasta'
    #echo "    "$FILE
    #var=$(find script*)
    
    
    FILES=$folder/*.fasta
    echo $FILES
    
    cd $folder
    FILE=*.fasta
    echo $FILE
    
    #awk -F "|" '/^>/ {F = $2".fasta"} {print > F}' $FILES
    awk -F "|" '/^>/ {F = $2".fasta"} {print > F}' $FILE
    cd ..
    echo ""
done

#End of file
