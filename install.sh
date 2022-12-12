#!/bin/bash
set -euo pipefail

# shellcheck source=./util.sh
source "$(dirname "$0")/util.sh"

BASEDIR="$(
   cd "$(dirname "$0")"
   pwd -P
)"
OS=$(uname -s)
export BASEDIR OS

for dir in tools/*/; do
   path=${dir%*/}
   tool=${path##*/}
   confirm "$tool" "$path/install.sh"
done
