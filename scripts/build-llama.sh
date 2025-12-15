#!/bin/bash

cmake -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CUDA_ARCHITECTURES="native" \
    -DCMAKE_INSTALL_PREFIX="$HOME/.local" \
    -DGGML_BUILD_EXAMPLES=OFF \
    -DGGML_BUILD_TESTS=OFF \
    -DGGML_CUDA=ON \
    -DGGML_CUDA_FA_ALL_QUANTS=ON \
    -DGGML_LTO=ON \
    -DGGML_NATIVE=ON
cmake --build build --parallel "$(nproc)"
