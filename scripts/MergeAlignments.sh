#!/bin/bash
#PBS -N Beta_MERGEAlignments
#PBS -l nodes=1:ppn=28
#PBS -l walltime=999:0:0:0

#@Author: Alexander G Lucaci
#@Usage: qsub -V -q epyc MergeAlignments.sh

# This script combines SARS, SARS2, MERS genes together

#We do this for S, M, N ,E, ORF1ab, ORF1a, ORF1b
#BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"
BASEDIR=$1

#PREMSA="hyphy-analyses/codon-msa/pre-msa.bf"
POSTMSA=$BASEDIR"/scripts/hyphy-analyses/codon-msa/post-msa.bf"

HYPHYMPI=$BASEDIR"/scripts/hyphy-develop/HYPHYMPI"
RES=$BASEDIR"/scripts/hyphy-develop/res"
MAFFT="/usr/bin/mafft"
RUBY="/usr/bin/ruby"
REFERENCEDIR=""
RAXMLHPCMPI=$BASEDIR"/scripts/standard-RAxML/raxmlHPC-MPI"

mkdir -p $BASEDIR"/analysis/Combined"

## HELPER FUNCTIONS


#cat the protein MSAS together
function catProteinMSAs {

    OUTDIR=$BASEDIR"/analysis/Combined/combined_protein_msa"
    mkdir -p $OUTDIR

    ALNDIR=$BASEDIR"/analysis/Alignments"

    DIR="protein"
    SUFFIX="_protein.msa"

    for FILE in $ALNDIR/MERS/$DIR/*$SUFFIX; do
        #cat
        f="$(basename -- $FILE)"
        #echo $FILE 
        #echo $f
        #echo $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f 
        echo $OUTDIR"/combined_"$f 

        if [ -s $OUTDIR"/combined_"$f ];
        then
            echo 6
        else 
            echo cat $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f $ALNDIR/229E/$DIR/$f $ALNDIR/HKU1/$DIR/$f $ALNDIR/NL63/$DIR/$f $ALNDIR/OC43/$DIR/$f > $OUTDIR"/combined_"$f
            cat $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f $ALNDIR/229E/$DIR/$f $ALNDIR/HKU1/$DIR/$f $ALNDIR/NL63/$DIR/$f $ALNDIR/OC43/$DIR/$f > $OUTDIR"/combined_"$f
        fi
    done

}

#cat the nucl files
function catNuclFiles {
    
    OUTDIR=$BASEDIR"/analysis/Combined/combined_nucl"
    mkdir -p $OUTDIR

    ALNDIR=$BASEDIR"/analysis/Alignments"

    DIR="nucleotide"
    SUFFIX="_nuc.fas"

    for FILE in $ALNDIR/MERS/$DIR/*$SUFFIX; do
        #cat
        f="$(basename -- $FILE)"
        #echo $FILE 
        #echo $f
        #echo $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f 
        echo $OUTDIR"/combined_"$f  
        if [ -s $OUTDIR"/combined_"$f ]; 
        then
            echo 4
        else
            echo cat $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f $ALNDIR/229E/$DIR/$f $ALNDIR/HKU1/$DIR/$f $ALNDIR/NL63/$DIR/$f $ALNDIR/OC43/$DIR/$f > $OUTDIR"/combined_"$f  
            cat $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f $ALNDIR/229E/$DIR/$f $ALNDIR/HKU1/$DIR/$f $ALNDIR/NL63/$DIR/$f $ALNDIR/OC43/$DIR/$f > $OUTDIR"/combined_"$f  
        fi
    done

} 

#make ruby tables
#https://mafft.cbrc.jp/alignment/software/makemergetable.rb
function MakeRubyTables {
    #instructions: https://mafft.cbrc.jp/alignment/software/merge.html 
    echo "# Making ruby tables"
    
    #makemergetable.rb is downloaded from the mafft website via wget
    #wget https://mafft.cbrc.jp/alignment/software/makemergetable.rb

    OUTDIR=$BASEDIR"/analysis/Combined/combined_protein_msa"
    mkdir -p $OUTDIR

    ALNDIR=$BASEDIR"/analysis/Alignments"

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
        
        if [ -s $OUTDIR"/combined_"$f".table" ];
        then
            echo 3
        else
            echo $RUBY $BASEDIR"/scripts/makemergetable.rb" $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f > $OUTDIR"/combined_"$f".table" 
            $RUBY $BASEDIR"/scripts/makemergetable.rb" $ALNDIR/MERS/$DIR/$f $ALNDIR/SARS/$DIR/$f $ALNDIR/SARS2/$DIR/$f $ALNDIR/229E/$DIR/$f $ALNDIR/HKU1/$DIR/$f $ALNDIR/NL63/$DIR/$f $ALNDIR/OC43/$DIR/$f > $OUTDIR"/combined_"$f".table" 
        fi
    done
}


#do mafft merge
function DoMafftMerge {
    echo "# Doing mafft --merge"

    #OUTDIR="../analysis/Combined/combined_merged_protein_msa"
    OUTDIR=$BASEDIR"/analysis/Combined/combined_merged_protein_msa"
    mkdir -p $OUTDIR

    #MSADIR="../analysis/Combined/combined_protein_msa"
    MSADIR=$BASEDIR"/analysis/Combined/combined_protein_msa"

    echo "INPUT DIR: "$MSADIR

    echo "OUTPUT DIR: "$OUTDIR

    for FILE in $MSADIR/*_protein.msa; do
        echo "Processing: "$FILE
        f="$(basename -- $FILE)"

        if [ -s $OUTDIR/"merged_"$f ];
        then
            echo "Exists: "$OUTDIR/"merged_"$f
        else

            #$MAFFT --localpair --maxiterate 100 --merge $FILE".table" $FILE > $OUTDIR/"merged_"$f 

            echo $MAFFT --merge $FILE".table" $FILE > $OUTDIR/"merged_"$f 
            $MAFFT --merge $FILE".table" $FILE > $OUTDIR/"merged_"$f 
            #echo $FILE
        fi
    done

}


#do postmsa 
function DoPostMSAMerge {
    echo "Doing hyphy post msa"

    OUTDIR=$BASEDIR"/analysis/Combined/combined_codon_alignment"
    mkdir -p $OUTDIR


    MSADIR=$BASEDIR"/analysis/Combined/combined_merged_protein_msa"
    NUCLDIR=$BASEDIR"/analysis/Combined/combined_nucl"
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
         if [ -s $output ];
         then
             echo "Exists POSTMSAMerge"
         else 
             echo mpirun -np 28 $HYPHYMPI LIBPATH=$RES $POSTMSA --protein-msa $FILE --nucleotide-sequences $nucl --output $output
             mpirun -np 28 $HYPHYMPI LIBPATH=$RES $POSTMSA --protein-msa $FILE --nucleotide-sequences $nucl --output $output
         fi
    done
}


#make trees
function MakeTrees {
   echo "Creating raxml trees"

    OUTDIR=$BASEDIR"/analysis/Combined/combined_codon_alignment_trees"
    mkdir -p $OUTDIR

    ALNDIR=$BASEDIR"/analysis/Combined/combined_codon_alignment"

    for FILE in $ALNDIR/*.fasta; do
        echo "Processing: "$FILE
        f="$(basename -- $FILE)"

        if [ -s $OUTDIR"/RAxML_bestTree."$f ];
        then
            echo 1
        else
            #$RAXMLHPCMPI --msa $FILE --model GTR+G --force
            echo mpirun -np 28 $RAXMLHPCMPI -m GTRGAMMA -s $FILE -n $f -p 12345 -N 2 -w $OUTDIR
            mpirun -np 28 $RAXMLHPCMPI -m GTRGAMMA -s $FILE -n $f -p 12345 -N 2 -w $OUTDIR
        fi

    done

    #mv $ALNDIR/*raxml* $OUTDIR

}


## Main -----
catNuclFiles
catProteinMSAs
MakeRubyTables

DoMafftMerge
DoPostMSAMerge
MakeTrees

exit 0
#end of file
