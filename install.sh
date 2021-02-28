#!/bin/bash
set -euo pipefail

source "$(dirname "$0")/util.sh"

BASEDIR="$( cd "$(dirname "$0")" ; pwd -P )"
OS=$(uname -s)

pconfiguring () {
   print_green "\n→ Configuring $1"
}

confirm () {
   read -r -p "Configure $1? [y/N] " response
   if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
      pconfiguring $1
      source $2
      print_green "→ Done\n"
   fi
}

for dir in tools/*/ ; do
   path=${dir%*/}
   tool=${path##*/}
   confirm "$tool" $path/install.sh
done
