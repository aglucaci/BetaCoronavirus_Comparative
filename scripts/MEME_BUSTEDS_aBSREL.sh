#!/bin/bash
#PBS -N Beta_MEME_aBSREL_BUSTEDS
#PBS -l walltime=999:00:00
#PBS -l nodes=1:ppn=64

#@Usage: qsub -V -q epyc -l nodes=1:ppn=64 MEME_BUSTEDS_aBSREL.sh


#BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"
BASEDIR=$1
#BASEDIR="$(dirname "$PWD")"

# Declares
MEME=$BASEDIR"/scripts/hyphy-develop/res/TemplateBatchFiles/SelectionAnalyses/MEME.bf"
ABSREL=$BASEDIR"/scripts/hyphy-develop/res/TemplateBatchFiles/SelectionAnalyses/aBSREL.bf"
BUSTEDS=$BASEDIR"/scripts/hyphy-develop/res/TemplateBatchFiles/SelectionAnalyses/BUSTED.bf"

HYPHY=$BASEDIR"/scripts/hyphy-develop/HYPHYMPI"
RES=$BASEDIR"/scripts/hyphy-develop/res"



TREEDIR=$BASEDIR"/analysis/raxml"

mkdir -p $BASEDIR"/analysis/MEME"
mkdir -p $BASEDIR"/analysis/BUSTEDS"
mkdir -p $BASEDIR"/analysis/aBSREL"

for virus in MERS SARS SARS2 229E OC43 NL63 HKU1; do
    echo "# Processing: "$virus
    FASTA=$BASEDIR"/analysis/Alignments/"$virus"/compressed/*.fasta"
 
    OUTPUTDIRMEME=$BASEDIR"/analysis/MEME/"$virus
    mkdir -p $OUTPUTDIRMEME

    OUTPUTDIRBUSTEDS=$BASEDIR"/analysis/BUSTEDS/"$virus
    mkdir -p $OUTPUTDIRBUSTEDS

    OUTPUTDIRaBSREL=$BASEDIR"/analysis/aBSREL/"$virus
    mkdir -p $OUTPUTDIRaBSREL

    for gene in $FASTA; do
        f="$(basename -- $gene)"
        echo $gene $TREEDIR/$virus/"RAxML_bestTree."$f
    
        #$HYPHY LIBPATH=$RES $GARD --type codon --alignment $gene
        
        if [ -f $OUTPUTDIRMEME"/"$f".MEME.json" ]; 
        then
            echo ""
        else  
            echo mpirun -np 64 $HYPHY LIBPATH=$RES $MEME --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --output $OUTPUTDIRMEME"/"$f".MEME.json"
            mpirun -np 64 $HYPHY LIBPATH=$RES $MEME --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --output $OUTPUTDIRMEME"/"$f".MEME.json"
        fi

        if [ -f $OUTPUTDIRaBSREL"/"$f".aBSREL.json" ];
        then
            echo ""
        else
            echo mpirun -np 64 $HYPHY LIBPATH=$RES $ABSREL --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --output $OUTPUTDIRaBSREL"/"$f".aBSREL.json"
            mpirun -np 64 $HYPHY LIBPATH=$RES $ABSREL --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --output $OUTPUTDIRaBSREL"/"$f".aBSREL.json"
        fi

        if [-f $OUTPUTDIRBUSTEDS"/"$f".BUSTEDS.json" ];
        then
            echo ""
        else
            echo mpirun -np 64 $HYPHY LIBPATH=$RES $BUSTEDS --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --srv Yes --output $OUTPUTDIRBUSTEDS"/"$f".BUSTEDS.json"
            mpirun -np 64 $HYPHY LIBPATH=$RES $BUSTEDS --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --srv Yes --output $OUTPUTDIRBUSTEDS"/"$f".BUSTEDS.json"
        fi

        #if [-s $OUTPUTDIRBUSTEDS"/"$f".SLAC.json" ];
        #then
        #    echo ""
        #else
        #    echo mpirun -np 28 $HYPHY LIBPATH=$RES SLAC --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --srv Yes --output $OUTPUTDIRBUSTEDS"/"$f".SLAC.json"
        #    
        #    mpirun -np 28 $HYPHY LIBPATH=$RES SLAC --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --srv Yes --output $OUTPUTDIRBUSTEDS"/"$f".SLAC.json"
        #fi


        echo ""
    done
    # End inner for loop
done


# End of file
