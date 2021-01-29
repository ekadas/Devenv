#!/bin/bash

BASEDIR="$( cd "$(dirname "$0")" ; pwd -P )"
OS=$(uname -s)

# colors
RED='\033[0;32m'
NC='\033[0m'

pprint () {
   echo -e "$RED$1$NC"
}

pconfiguring () {
   pprint "\n→ Configuring $1"
}

confirm () {
   read -r -p "Configure $1? [y/N] " response
   if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
      pconfiguring $1
      source $2
   fi
}

for dir in tools/*/ ; do
   path=${dir%*/}
   tool=${path##*/}
   confirm "$tool" $path/install.sh
done
