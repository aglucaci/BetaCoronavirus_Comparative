#!/bin/bash
#PBS -N MEME_aBSREL_BUSTEDS

#@Usage: qsub -V -q epyc -l nodes=1:ppn=28 MEME_BUSTEDS_aBSREL.sh


BASEDIR="/home/aglucaci/Coronavirus_Comparative_Analysis_August_2020"
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

for virus in MERS SARS SARS2; do
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
        
        if [ -s $OUTPUTDIRMEME"/"$f".MEME.json" ]; 
        then
            echo ""
        else  
            echo mpirun -np 28 $HYPHY LIBPATH=$RES $MEME --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --output $OUTPUTDIRMEME"/"$f".MEME.json"
            #mpirun -np 28 $HYPHY LIBPATH=$RES $MEME --alignment $gene --tree $MERSTREEDIR/"RAxML_bestTree."$f
            mpirun -np 28 $HYPHY LIBPATH=$RES $MEME --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --output $OUTPUTDIRMEME"/"$f".MEME.json"
        fi

        if [ -s $OUTPUTDIRaBSREL"/"$f".aBSREL.json" ];
        then
            echo ""
        else
            echo mpirun -np 28 $HYPHY LIBPATH=$RES $ABSREL --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --output $OUTPUTDIRaBSREL"/"$f".aBSREL.json"
            #mpirun -np 28 $HYPHY LIBPATH=$RES $ABSREL --alignment $gene --tree $MERSTREEDIR/"RAxML_bestTree."$f
            mpirun -np 28 $HYPHY LIBPATH=$RES $ABSREL --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --output $OUTPUTDIRaBSREL"/"$f".aBSREL.json"
        fi

        if [-s $OUTPUTDIRBUSTEDS"/"$f".BUSTEDS.json" ];
        then
            echo ""
        else
            echo mpirun -np 28 $HYPHY LIBPATH=$RES $BUSTEDS --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --srv Yes --output $OUTPUTDIRBUSTEDS"/"$f".BUSTEDS.json"
            #mpirun -np 28 $HYPHY LIBPATH=$RES $BUSTEDS --alignment $gene --tree $MERSTREEDIR/"RAxML_bestTree."$f --srv Yes
            mpirun -np 28 $HYPHY LIBPATH=$RES $BUSTEDS --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --srv Yes --output $OUTPUTDIRBUSTEDS"/"$f".BUSTEDS.json"
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
