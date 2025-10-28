<!--.. Copyright 2016 The Cartographer Authors

.. Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

..      http://www.apache.org/licenses/LICENSE-2.0

.. Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License. -->

# Cartographer ROS Integration (Jetpack5)
This repository is a fork of [Cartographer ROS](https://github.com/ros2/cartographer_ros).  
It has been adapted specifically for **ROS 2 Humble** running on **JetPack 5 Docker containers**.

---

## 🧩 Build from Source
### 1. Install dependencies
Follow the [official Cartographer installation guide](https://google-cartographer-ros.readthedocs.io/en/latest/compilation.html#building-installation) to install all required libraries (e.g., Ceres Solver, Eigen3, Lua, glog, protobuf, etc.).

### 2. Create a ROS 2 workspace
```bash
mkdir -p <workspace-dir>/src
cd <workspace-dir>
```

### 3. Clone repositories
```
cd src
git clone https://github.com/ros2/cartographer_ros.git
git clone https://github.com/leidZhang/cartographer_ros.git
```
If needed, also clone [perception_pcl](https://github.com/ros-perception/perception_pcl) (use the humble branch):
```
git clone -b humble https://github.com/ros-perception/perception_pcl.git
```

### 4. Install ROS dependencies
```
sudo rosdep init   # (skip if already initialized)
rosdep update
rosdep install --from-paths src --ignore-src -r -y
```
### 5. Build the workspace
```
colcon build --symlink-install
```

## ⚠️ Common Issues & Fixes
### 1. Missing `.cmake` files for glog 
If `FindGlog.cmake` or other CMake files are missing, build glog v0.6.0 from source:
```
wget https://github.com/google/glog/archive/refs/tags/v0.6.0.tar.gz
tar -xvzf v0.6.0.tar.gz
cd glog-0.6.0

mkdir build && cd build
cmake ..
make -j$(nproc)
sudo make install
```
### 2. Ceres Solver incompatible with glog
Build Ceres Solver 1.14.x from source for compatibility:
```
git clone -b 1.14.x https://github.com/ceres-solver/ceres-solver.git
cd ceres-solver && mkdir build && cd build
cmake ..
make -j$(nproc)
sudo make install
```
### 3. `pcl_conversions` build error
Ensure the `perception_pcl` repository is checked out to the `humble` branch:

<!-- .. _our Contribution page: https://github.com/cartographer-project/cartographer_ros/blob/master/CONTRIBUTING.md

.. |build| image:: https://travis-ci.org/cartographer-project/cartographer_ros.svg?branch=master
    :alt: Build Status
    :scale: 100%
    :target: https://travis-ci.org/cartographer-project/cartographer_ros
.. |docs| image:: https://readthedocs.org/projects/google-cartographer-ros/badge/?version=latest
    :alt: Documentation Status
    :scale: 100%
    :target: https://google-cartographer-ros.readthedocs.io/en/latest/?badge=latest
.. |license| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
     :alt: Apache 2 license.
     :scale: 100%
     :target: https://github.com/cartographer-project/cartographer_ros/blob/master/LICENSE -->

