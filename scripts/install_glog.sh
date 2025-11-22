#!/usr/bin/env bash
set -e

REQUIRED_VERSION="0.6.0"

check_version() {
    if command -v pkg-config >/dev/null && pkg-config --exists libglog; then
        CURRENT_VERSION=$(pkg-config --modversion libglog || echo "none")
        echo "Detected glog version: $CURRENT_VERSION"
        if dpkg --compare-versions "$CURRENT_VERSION" ge "$REQUIRED_VERSION"; then
            echo "✔ System already has compatible glog version ($CURRENT_VERSION)."
            return 0
        fi
    fi
    return 1
}

echo "==== Checking for existing glog version ===="
if check_version; then
    exit 0
fi

echo "==== Installing dependencies ===="
sudo apt update
sudo apt install -y build-essential cmake wget libgflags-dev

echo "==== Downloading glog $REQUIRED_VERSION ===="
wget -q https://github.com/google/glog/archive/refs/tags/v$REQUIRED_VERSION.tar.gz
tar -xzf v$REQUIRED_VERSION.tar.gz
rm v$REQUIRED_VERSION.tar.gz

cd glog-$REQUIRED_VERSION

echo "==== Building glog from source ===="
mkdir -p build && cd build
cmake .. -DBUILD_SHARED_LIBS=ON
make -j"$(nproc)"
sudo make install

echo "==== Updating linker paths ===="
echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/local-glog.conf >/dev/null
sudo ldconfig

echo "==== Ensuring CMake detects new glog ===="
if ! grep -q "/usr/local/lib/pkgconfig" ~/.bashrc; then
    echo 'export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH' >> ~/.bashrc
fi

if ! grep -q "/usr/local" ~/.bashrc; then
    echo 'export CMAKE_PREFIX_PATH=/usr/local:$CMAKE_PREFIX_PATH' >> ~/.bashrc
fi

echo "==== Reloading environment ===="
source ~/.bashrc

echo "==== Validating installation ===="
if check_version; then
    echo "🎉 Successfully installed glog $REQUIRED_VERSION!"
else
    echo "⚠ Installation completed, but version check failed. Reboot or re-source environment:"
    echo "    source ~/.bashrc"
fi

