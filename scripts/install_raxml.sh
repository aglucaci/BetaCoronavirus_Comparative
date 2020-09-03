#!/bin/bash


git clone https://github.com/stamatak/standard-RAxML.git

cd standard-RAxML
#make -f Makefile.AVX.MPI.gcc
make -f Makefile.MPI.gcc
rm *.o


# End of file
