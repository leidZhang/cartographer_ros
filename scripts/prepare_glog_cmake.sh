#!/bin/bash

# Detect architecture
ARCH=$(uname -m)

if [[ "$ARCH" == "x86_64" ]]; then
  LIB_PATH="/usr/lib/x86_64-linux-gnu/libglog.so"
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
  LIB_PATH="/usr/lib/aarch64-linux-gnu/libglog.so"
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi

# Target dir
CONFIG_DIR="/usr/local/lib/cmake/glog"
CONFIG_FILE="${CONFIG_DIR}/glogConfig.cmake"

# Create dir
sudo mkdir -p "${CONFIG_DIR}"

# Write content
sudo tee "${CONFIG_FILE}" > /dev/null << 'EOF'
# glogConfig.cmake
if (NOT TARGET glog::glog)
  add_library(glog::glog UNKNOWN IMPORTED)
  set_target_properties(glog::glog PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "/usr/include"
    IMPORTED_LOCATION "/usr/lib/x86_64-linux-gnu/libglog.so"
  )
endif()
set(glog_VERSION "0.4.0")
EOF

# Provider permission
sudo chmod 644 "${CONFIG_FILE}"

echo "Written glogConfig.cmake to ${CONFIG_FILE}"
