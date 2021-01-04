#!/bin/bash
#PBS -N HCoV_MEME_aBSREL_BUSTEDS
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
mkdir -p $BASEDIR"/analysis/SLAC"
mkdir -p $BASEDIR"/analysis/FUBAR"

for virus in MERS SARS 229E OC43 NL63 HKU1 SARS2; do
    echo "# Processing: "$virus
    FASTA=$BASEDIR"/analysis/Alignments/"$virus"/compressed/*.fasta"
 
    OUTPUTDIRMEME=$BASEDIR"/analysis/MEME/"$virus
    mkdir -p $OUTPUTDIRMEME

    OUTPUTDIRBUSTEDS=$BASEDIR"/analysis/BUSTEDS/"$virus
    mkdir -p $OUTPUTDIRBUSTEDS

    OUTPUTDIRaBSREL=$BASEDIR"/analysis/aBSREL/"$virus
    mkdir -p $OUTPUTDIRaBSREL

    OUTPUTDIRSLAC=$BASEDIR"/analysis/SLAC/"$virus
    mkdir -p $OUTPUTDIRSLAC

    OUTPUTDIRFUBAR=$BASEDIR"/analysis/FUBAR/"$virus
    mkdir -p $OUTPUTDIRFUBAR

    for gene in $FASTA; do
        f="$(basename -- $gene)"
        echo $gene $TREEDIR/$virus/"RAxML_bestTree."$f
    
        #$HYPHY LIBPATH=$RES $GARD --type codon --alignment $gene
        
        if [ -s $OUTPUTDIRMEME"/"$f".MEME.json" ]; 
        then
            echo ""
        else  
            echo mpirun -np 64 $HYPHY LIBPATH=$RES $MEME --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --output $OUTPUTDIRMEME"/"$f".MEME.json" --branches Internal
            mpirun -np 64 $HYPHY LIBPATH=$RES $MEME --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --output $OUTPUTDIRMEME"/"$f".MEME.json" --branches Internal
        fi

        if [ -s $OUTPUTDIRaBSREL"/"$f".aBSREL.json" ];
        then
            echo ""
        else
            echo mpirun -np 64 $HYPHY LIBPATH=$RES $ABSREL --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --output $OUTPUTDIRaBSREL"/"$f".aBSREL.json" --branches Internal
            mpirun -np 64 $HYPHY LIBPATH=$RES $ABSREL --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --output $OUTPUTDIRaBSREL"/"$f".aBSREL.json" --branches Internal
        fi

        if [ -s $OUTPUTDIRBUSTEDS"/"$f".BUSTEDS.json" ];
        then
            echo ""
        else
            echo mpirun -np 64 $HYPHY LIBPATH=$RES $BUSTEDS --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --srv Yes --output $OUTPUTDIRBUSTEDS"/"$f".BUSTEDS.json" --branches Internal
            mpirun -np 64 $HYPHY LIBPATH=$RES $BUSTEDS --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --srv Yes --output $OUTPUTDIRBUSTEDS"/"$f".BUSTEDS.json" --branches Internal
        fi

        # SLAC
        if [ -s $OUTPUTDIRSLAC"/"$f".SLAC.json" ];
        then
            echo ""
        else
            echo mpirun -np 64 $HYPHY LIBPATH=$RES SLAC --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --srv Yes --output $OUTPUTDIRSLAC"/"$f".SLAC.json" --branches All
            mpirun -np 64 $HYPHY LIBPATH=$RES SLAC --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --srv Yes --output $OUTPUTDIRSLAC"/"$f".SLAC.json" --branches All
        fi

        # FUBAR
        if [ -s $OUTPUTDIRFUBAR"/"$f".FUBAR.json" ];
        then
            echo ""
        else
            echo mpirun -np 64 $HYPHY LIBPATH=$RES FUBAR --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --grid 50 --chains 10 --chain-length 10000000 --burn-in 1000000 --output $OUTPUTDIRFUBAR"/"$f".FUBAR.json"
            mpirun -np 64 $HYPHY LIBPATH=$RES FUBAR --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --grid 50 --chains 10 --chain-length 10000000 --burn-in 1000000 --output $OUTPUTDIRFUBAR"/"$f".FUBAR.json"
        fi


        echo ""
    done
    # End inner for loop
done


# End of file
