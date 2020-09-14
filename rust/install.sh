#!/bin/bash

curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
rustup component add rustfmt
rustup toolchain add nightly
rustup component add rust-src
rustup component add clippy
git clone https://github.com/rust-analyzer/rust-analyzer /tmp/rust-analyzer && cd /tmp/rust-analyzer
cargo xtask install --server
cd $BASEDIR
