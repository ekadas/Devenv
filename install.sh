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

# install brew
if [ "$OS" = "Darwin" ]; then
   confirm "brew" brew/install.sh
fi

if [ "$OS" = "Darwin" ]; then
   confirm "iterm2" iterm2/install.sh
fi

# configure python
confirm "python" python/install.sh

# configures bash
confirm "bash" bash/install.sh
source ~/.bash_profile

# symlinks tmux configuration
confirm "tmux" tmux/install.sh

# configure git
confirm "git" git/install.sh

# configure nvim
## install vim-plug
confirm "neovim" nvim/install.sh

# configure gcloud
if [ "$OS" = "Darwin" ]; then
   # NOTE: this may require setting pyenv first
   confirm "gcloud" gcloud/install.sh
fi

unset PYENV_VERSION
