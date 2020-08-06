#!/bin/bash
#PBS -l nodes=1:ppn=16
#PBS -l walltime=99:0:0:0

#@Author: Alexander G Lucaci
#@Usage: qsub -V -q epyc Combined.sh 
# This script combines SARS, SARS2, MERS genes together

#We do this for S, M, N ,E, ORF1ab, ORF1a
BASEDIR="/home/aglucaci/COVID-19/ComparativeAnalyses_Coronavirus"
#git clone https://github.com/veg/hyphy-analyses.git

#PREMSA="hyphy-analyses/codon-msa/pre-msa.bf"
POSTMSA=$BASEDIR"/scripts/hyphy-analyses/codon-msa/post-msa.bf"

HYPHY=$BASEDIR"/scripts/hyphy-develop/HYPHYMP"
RES=$BASEDIR"/scripts/hyphy-develop/res"
MAFFT="/usr/bin/mafft"
RUBY="/usr/bin/ruby"
RAXML=/usr/local/bin/raxml-ng
REFERENCEDIR=""

mkdir ../analysis/Combined

## HELPER FUNCTIONS

#cat the protein MSAS together
function catProteinMSAs {

    OUTDIR="../analysis/Combined/combined_protein_msa"
    mkdir $OUTDIR

    ALNDIR="../analysis/Alignments"

    DIR="protein"
    SUFFIX="_protein.msa"

    for FILE in $ALNDIR/MERS/$DIR/*$SUFFIX; do
        #cat
        f="$(basename -- $FILE)"
        #echo $FILE 
        #echo $f
        #echo $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f 
        echo $OUTDIR"/combined_"$f  
        cat $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f > $OUTDIR"/combined_"$f
   
    done

}

#cat the nucl files
function catNuclFiles {
    
    OUTDIR="../analysis/Combined/combined_nucl"
    mkdir $OUTDIR

    ALNDIR="../analysis/Alignments"

    DIR="nucleotide"
    SUFFIX="_nuc.fas"

    for FILE in $ALNDIR/MERS/$DIR/*$SUFFIX; do
        #cat
        f="$(basename -- $FILE)"
        #echo $FILE 
        #echo $f
        #echo $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f 
        echo $OUTDIR"/combined_"$f  
        cat $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f > $OUTDIR"/combined_"$f  
    done

} 

#make ruby tables
#https://mafft.cbrc.jp/alignment/software/makemergetable.rb
function MakeRubyTables {
    #instructions: https://mafft.cbrc.jp/alignment/software/merge.html 
    echo "# Making ruby tables"
    
    #makemergetable.rb is downloaded from the mafft website via wget
    #wget https://mafft.cbrc.jp/alignment/software/makemergetable.rb

    OUTDIR="../analysis/Combined/combined_protein_msa"
    mkdir $OUTDIR

    ALNDIR="../analysis/Alignments"

    DIR="protein"
    SUFFIX="_protein.msa"

    for FILE in $ALNDIR/MERS/$DIR/*$SUFFIX; do
        #cat
        f="$(basename -- $FILE)"
        #echo $FILE 
        #echo $f
        #echo $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f 
        #echo $OUTDIR"/combined_"$f  
        #cat $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f > $OUTDIR"/combined_"$f
        $RUBY makemergetable.rb $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f > $OUTDIR"/combined_"$f".table" 
   done

    

}


#do mafft merge
function DoMafftMerge {
    echo "# Doing mafft --merge"

    #OUTDIR="../analysis/Combined/combined_merged_protein_msa"
    OUTDIR=$BASEDIR/analysis/Combined/combined_merged_protein_msa
    mkdir $OUTDIR

    #MSADIR="../analysis/Combined/combined_protein_msa"
    MSADIR=$BASEDIR/analysis/Combined/combined_protein_msa

    echo "INPUT DIR: "$MSADIR

    echo "OUTPUT DIR: "$OUTDIR

    for FILE in $MSADIR/*_protein.msa; do
        echo "Processing: "$FILE
        f="$(basename -- $FILE)"

        if [ -a $OUTDIR/"merged_"$f ]
        then
            echo "Exists: "$OUTDIR/"merged_"$f
        else

            #$MAFFT --localpair --maxiterate 100 --merge $FILE".table" $FILE > $OUTDIR/"merged_"$f 
            $MAFFT --merge $FILE".table" $FILE > $OUTDIR/"merged_"$f 
     
            #echo $FILE
        fi
    done

}


#do postmsa 
function DoPostMSAMerge {
    echo "Doing hyphy post msa"

    OUTDIR=$BASEDIR/analysis/Combined/combined_codon_alignment
    mkdir $OUTDIR


    MSADIR=$BASEDIR/analysis/Combined/combined_merged_protein_msa
    NUCLDIR=$BASEDIR/analysis/Combined/combined_nucl
    NUCLSUFFIX="_nuc.fas"

   

    for FILE in $MSADIR/*.msa; do
         f="$(basename -- $FILE)"

         nucl=${f//merged_/}
         nucl=${nucl//_protein.msa/} 
         nucl=$NUCLDIR/$nucl$NUCLSUFFIX
         echo "Nucleotide file: "$nucl
         
         f=${f//_protein.msa}
         output=$OUTDIR/"codon_aln_"$f

         #echo $FILE
         if [ -s $FILE ]
         then 
              $HYPHY LIBPATH=$RES $POSTMSA --protein-msa $FILE --nucleotide-sequences $nucl --output $output
         fi
    done
}


#make trees
function MakeTrees {
   echo "Creating raxml trees"

    OUTDIR=$BASEDIR/analysis/Combined/combined_codon_alignment_trees
    mkdir $OUTDIR

    ALNDIR=$BASEDIR/analysis/Combined/combined_codon_alignment

    for FILE in $ALNDIR/*.fasta; do
        echo "Processing: "$FILE

        if [ -s $FILE ]
        then
            echo 1
            $RAXML --msa $FILE --model GTR+G --force
        fi

    done

    mv $ALNDIR/*raxml* $OUTDIR

}


## Main -----
#can run on head node
#catNuclFiles
#catProteinMSAs
#MakeRubyTables

# qsub these
DoMafftMerge
DoPostMSAMerge
MakeTrees


#end of file
