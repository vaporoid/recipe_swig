# SWIGの使い方

## 必要なもの

* CMake
* C++コンパイラ
* Boost
* SWIG
* Lua
* Java
* JNI

## コンパイル方法（例）

ただし、最新のGCCがパスの通った場所にあるとする。また、`${CMAKE_INSTALL_PREFIX}/include`以下にBoostがインストールされているとする。

    mkdir build
    cd build
    env CC=gcc CXX=g++ \
      cmake \
        -DCMAKE_CXX_FLAGS="-fno-strict-aliasing -Wall -W -Wno-unused-local-typedefs -Wno-missing-field-initializers -Wno-unused-parameter -std=c++11" \
        -DCMAKE_BUILD_TYPE=release \
        -DCMAKE_INSTALL_PREFIX=/opt/vaporoid/package/prefix ..
    make
    make test

