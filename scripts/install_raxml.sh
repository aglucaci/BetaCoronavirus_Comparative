#!/bin/bash


git clone https://github.com/stamatak/standard-RAxML.git

make -f Makefile.AVX.MPI.gcc

rm *.o


# End of file
