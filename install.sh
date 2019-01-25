#!/bin/bash

PYTHON2=2.7.15
PYTHON3=3.7.1

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

# configure python
confirm "python" install/python.sh

# configures bash
confirm "bash" install/bash.sh
source ~/.bash_profile

# symlinks tmux configuration
confirm "tmux" install/tmux.sh

# configure git
confirm "git" install/git.sh

# configure nvim
## install vim-plug
confirm "neovim" install/neovim.sh

# configure gcloud
if [ "$OS" = "Darwin" ]; then
   # NOTE: this may require setting pyenv first
   confirm "gcloud" install/gcloud.sh
fi

unset PYENV_VERSION
