#!/bin/bash
#PBS -N Beta_v2_FT_FUBAR
#PBS -l walltime=999:00:00
#PBS -l nodes=1:ppn=16


#@Usage: qsub -V -q epyc -l nodes=1:ppn=16 fubar-fasttree.sh


BASEDIR=/home/aglucaci/BetaCoronavirus_Comparative
#BASEDIR="$(dirname "$PWD")"

# Declares
MEME=$BASEDIR"/scripts/hyphy-develop/res/TemplateBatchFiles/SelectionAnalyses/MEME.bf"
ABSREL=$BASEDIR"/scripts/hyphy-develop/res/TemplateBatchFiles/SelectionAnalyses/aBSREL.bf"
BUSTEDS=$BASEDIR"/scripts/hyphy-develop/res/TemplateBatchFiles/SelectionAnalyses/BUSTED.bf"

HYPHY=$BASEDIR"/scripts/hyphy-develop/HYPHYMPI"
RES=$BASEDIR"/scripts/hyphy-develop/res"

TREEDIR=$BASEDIR"/analysis/FastTree"

#mkdir -p $BASEDIR"/analysis/MEME"
#mkdir -p $BASEDIR"/analysis/BUSTEDS"
#mkdir -p $BASEDIR"/analysis/aBSREL"
#mkdir -p $BASEDIR"/analysis/SLAC"
#mkdir -p $BASEDIR"/analysis/FUBAR"
mkdir -p $BASEDIR"/analysis/FastTree/FUBAR"

for virus in MERS SARS 229E OC43 NL63 HKU1 SARS2; do
    echo "# Processing: "$virus
    FASTA=$BASEDIR"/analysis/Alignments/"$virus"/compressed/*.fasta"
 
    #OUTPUTDIRMEME=$BASEDIR"/analysis/MEME/"$virus
    #mkdir -p $OUTPUTDIRMEME

    #OUTPUTDIRBUSTEDS=$BASEDIR"/analysis/BUSTEDS/"$virus
    #mkdir -p $OUTPUTDIRBUSTEDS

    #OUTPUTDIRaBSREL=$BASEDIR"/analysis/aBSREL/"$virus
    #mkdir -p $OUTPUTDIRaBSREL

    #OUTPUTDIRSLAC=$BASEDIR"/analysis/SLAC/"$virus
    #mkdir -p $OUTPUTDIRSLAC

    #OUTPUTDIRFUBAR=$BASEDIR"/analysis/FUBAR/"$virus
    #mkdir -p $OUTPUTDIRFUBAR

    OUTPUTDIRFUBAR=$BASEDIR"/analysis/FastTree/FUBAR/"$virus
    mkdir -p $OUTPUTDIRFUBAR

    for gene in $FASTA; do
        #get basename
        f="$(basename -- $gene)"
        
        TREE=$TREEDIR/$virus/"FastTree_bestTree."$f
        echo $gene $TREE
    
        # SLAC
        #if [ -s $OUTPUTDIRSLAC"/"$f".SLAC.json" ];
        #then
        #    echo ""
        #else
        #    echo mpirun -np 64 $HYPHY LIBPATH=$RES SLAC --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --srv Yes --output $OUTPUTDIRSLAC"/"$f".SLAC.json" --branches All
        #    mpirun -np 64 $HYPHY LIBPATH=$RES SLAC --alignment $gene --tree $TREEDIR/$virus/"RAxML_bestTree."$f --srv Yes --output $OUTPUTDIRSLAC"/"$f".SLAC.json" --branches All
        #fi

        # FUBAR
        OUTPUTJSONFUBAR=$OUTPUTDIRFUBAR"/"$f".FUBAR_10.json"
        if [ -s $OUTPUTJSONFUBAR ];
        then
            echo ""
        else
            # output doesnt seem to be redirectings this.
            echo mpirun -np 16 $HYPHY LIBPATH=$RES FUBAR --alignment $gene --tree $TREE --grid 50 --chains 10 --chain-length 10000000 --burn-in 1000000 --output $OUTPUTJSONFUBAR
	    mpirun -np 16 $HYPHY LIBPATH=$RES FUBAR --alignment $gene --tree $TREE --grid 50 --chains 10 --chain-length 10000000 --burn-in 1000000 --output $OUTPUTJSONFUBAR
            
            # move outputs to where I want them
            # The fasttree/fubar/$virus folder
           
            ALIGNMENTDIR=$BASEDIR"/analysis/Alignments/"$virus"/compressed"

	    mv $ALIGNMENTDIR"/"$f".FUBAR.cache" $OUTPUTDIRFUBAR
            echo mv $ALIGNMENTDIR"/"$f".FUBAR.json" $OUTPUTDIRFUBAR
            mv $ALIGNMENTDIR"/"$f".FUBAR.json" $OUTPUTDIRFUBAR
            mv $ALIGNMENTDIR"/"$f".reduced" $OUTPUTDIRFUBAR
        fi


        echo ""
    done

    # End inner for loop
done


# End of file
