#!/bin/sh
git clone -b 1.14.x https://github.com/ceres-solver/ceres-solver.git
cd cd "$PWD/ceres-solver" && mkdir build && cd build
cmake ..
make -j$(nproc)
make install
