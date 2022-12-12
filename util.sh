#!/bin/bash

# colors
GREEN='\033[0;32m'
NC='\033[0m'

print_green() {
   echo -e "$GREEN$1$NC"
}

pconfiguring() {
   print_green "\n→ Configuring $1"
}

confirm() {
   read -r -p "Configure $1? [y/N] " response
   if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
      pconfiguring "$1"
      source "$2"
      print_green "→ Done\n"
   fi
}
