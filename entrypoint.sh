#!/bin/bash
set -Eeuxo pipefail
cd $GITHUB_WORKSPACE

apt-get update
apt-get install -y \
    build-essential \
    cmake 3.10.2 \
    git \
    wget \
    clang \
    gcc \
    g++ \
    zlib1g-dev \
    libmpc-dev \
    libmpfr-dev \
    libgmp-dev

git clone https://github.com/tpoechtrager/osxcross
cd osxcross
wget -nc https://s3.dockerproject.org/darwin/v2/MacOSX10.10.sdk.tar.xz
mv MacOSX10.10.sdk.tar.xz tarballs/
UNATTENDED=yes OSX_VERSION_MIN=10.7 ./build.sh

PATH="$(pwd)/osxcross/target/bin:$PATH"

rustup default stable
rustup target add x86_64-unknown-linux-musl
rustup target add aarch64-unknown-linux-musl
rustup target add x86_64-apple-darwin
rustup target add x86_64-pc-windows-gnu
bash -c "$*"
