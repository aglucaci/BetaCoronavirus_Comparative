#!/bin/bash


# Github repo is located at: https://github.com/ddarriba/modeltest

git clone --recursive https://github.com/ddarriba/modeltest


#cd modeltest-ng
cd modeltest
mkdir build && cd build
cmake -DUSE_MPI=ON ..
make



# END OF FILE
