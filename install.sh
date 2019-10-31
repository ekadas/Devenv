#!/bin/bash

PYTHON2=2.7.16
PYTHON3=3.8.0

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

if [ "$OS" = "Darwin" ]; then
   confirm "brew" brew/install.sh
fi

if [ "$OS" = "Darwin" ]; then
   confirm "iterm2" iterm2/install.sh
fi

confirm "python" python/install.sh

confirm "bash" bash/install.sh
source ~/.bash_profile

confirm "tmux" tmux/install.sh

confirm "git" git/install.sh

confirm "neovim" nvim/install.sh

confirm "nvm" nvm/install.sh

confirm "rbenv" rbenv/install.sh

confirm "rust" rust/install.sh

if [ "$OS" = "Darwin" ]; then
   confirm "docker" docker/install.sh
fi

if [ "$OS" = "Darwin" ]; then
   # NOTE: this may require setting pyenv first
   confirm "gcloud" gcloud/install.sh
fi

if [ "$OS" = "Darwin" ]; then
   confirm "kubectl" kubectl/install.sh
fi

unset PYENV_VERSION
