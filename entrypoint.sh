#!/bin/bash
set -Eeuxo pipefail
cd $GITHUB_WORKSPACE
rustup default stable
rustup target add x86_64-unknown-linux-musl
rustup target add aarch64-unknown-linux-musl
bash -c "$*"
