#!/bin/bash

#instructions available from https://github.com/veg/tn93
PWD="/home/aglucaci/Coronavirua_Comparative/scripts"

git clone https://github.com/veg/tn93.git

cd tn93

#cmake .
cmake -DCMAKE_INSTALL_PREFIX=$PWD/tn93


make install



#end of file
