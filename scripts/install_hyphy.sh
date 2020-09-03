#!/bin/bash
#Last update 05-28-2020
#module load aocc/2.1.0

#Download and install HyPhy
#git clone https://github.com/veg/hyphy.git
git clone https://github.com/veg/hyphy.git hyphy-develop

cd hyphy-develop
#cd hyphy

#cmake ./
cmake . -DNOAVX=ON

make -j MP
make -j MPI

make install

#Download hyphy standalone analyses
cd ..
git clone https://github.com/veg/hyphy-analyses.git

#End of file




