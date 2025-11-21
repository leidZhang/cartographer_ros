#!/bin/sh
set -e

# Remove old versions
apt remove -y libgoogle-glog-dev libgoogle-glog0v5

# Download and extract
wget https://github.com/google/glog/archive/refs/tags/v0.6.0.tar.gz
tar -xvzf v0.6.0.tar.gz
rm v0.6.0.tar.gz

# Go into the extracted folder in the current directory
cd "$PWD/glog-0.6.0"

# Build
mkdir -p build && cd build
cmake ..
make -j$(nproc)
make install
