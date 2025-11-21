#!/bin/sh
cd /workspace/deps
git clone -b 1.14.x https://github.com/ceres-solver/ceres-solver.git
cd ceres-solver && mkdir build && cd build
cmake ..
make -j$(nproc)
make install