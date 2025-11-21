#!/bin/sh
apt remove libgoogle-glog-dev
apt remove libgoogle-glog0v5

cd /workspace/deps
wget https://github.com/google/glog/archive/refs/tags/v0.6.0.tar.gz
tar -xvzf v0.6.0.tar.gz
rm v0.6.0.tar.gz && cd glog-0.6.0

mkdir build && cd build
cmake ..
make -j$(nproc)
make install