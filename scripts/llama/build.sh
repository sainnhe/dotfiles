#!/bin/bash

UNAME=$(uname)
BUILD_DIR="build"

COMMON_ARGS=(
    -DCMAKE_BUILD_TYPE=Debug
    -DCMAKE_INSTALL_PREFIX="$HOME/.local"
    -DGGML_NATIVE=ON
    -DGGML_LTO=ON
    -DGGML_BUILD_EXAMPLES=OFF
    -DGGML_BUILD_TESTS=OFF
    -DBUILD_SHARED_LIBS=OFF
)

if [ "$UNAME" = "Linux" ]; then
    CORES="$(nproc)"
    PLATFORM_ARGS=(
        # SSL
        -DLLAMA_OPENSSL=ON

        # GPU
        -DGGML_CUDA=ON
        -DCMAKE_CUDA_ARCHITECTURES="native"
        -DGGML_CUDA_GRAPHS=ON
        -DGGML_CUDA_FA_ALL_QUANTS=ON

        # CPU
        -DGGML_AVX512=ON
        -DGGML_AVX512_VBMI=ON
        -DGGML_AVX512_VNNI=ON
        -DGGML_AVX512_BF16=ON
        -DGGML_OPENMP=ON
    )
elif [ "$UNAME" = "Darwin" ]; then
    PLATFORM_ARGS=(
        # Apple Silicon / Metal
        -DGGML_METAL=ON
        -DGGML_METAL_EMBED_LIBRARY=ON
        -DGGML_ACCELERATE=ON
        -DGGML_BLAS=ON
        -DGGML_BLAS_VENDOR=Apple
    )
else
    echo "ERR: Unsupported system $UNAME"
    exit 1
fi

cmake -B $BUILD_DIR "${COMMON_ARGS[@]}" "${PLATFORM_ARGS[@]}"
cmake --build $BUILD_DIR --config Release --parallel "$CORES"
cmake --install $BUILD_DIR
