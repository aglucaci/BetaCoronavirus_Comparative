#!/bin/bash

git clone --recursive https://github.com/amkozlov/raxml-ng
cd raxml-ng
mkdir build && cd build
cmake -DUSE_MPI=ON ..
make

# END OF FILE
