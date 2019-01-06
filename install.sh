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

# configure python
pconfiguring "pyenv"
if [ "$OS" = "Darwin" ]; then
   brew install pyenv-virtualenv > /dev/null
   export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
else
   curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer > /dev/null | bash > /dev/null
fi
pyenv install -s 3.7.1 > /dev/null
pyenv install -s 2.7.15 > /dev/null

# configures bash
pconfiguring "bash"
if [ "$OS" = "Darwin" ]; then
   ln -sf $BASEDIR/bash/bash_mac ~/.bash_profile
else
   ln -sf $BASEDIR/bash/bash_linux ~/.bashrc
   ln -sf $BASEDIR/bash/bash_linux ~/.bash_profile
fi

# symlinks tmux configuration
pconfiguring "tmux"
ln -sf $BASEDIR/tmux/tmux.conf ~/.tmux.conf

# configure git
pconfiguring "git"
ln -sf $BASEDIR/git/gitconfig ~/.gitconfig
if [ "$OS" = "Darwin" ]; then
   ln -sf $BASEDIR/git/gitexcludes ~/.gitexcludes
fi

# configure nvim
## install vim-plug
pconfiguring "neovim"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null
## install python-neovim
pyenv virtualenv 2.7.15 nvim2 > /dev/null
export PYENV_VERSION=nvim2
pip install neovim > /dev/null
pyenv virtualenv 3.7.1 nvim3 > /dev/null
export PYENV_VERSION=nvim3
pip install neovim > /dev/null
ln -sf $BASEDIR/nvim ~/.config/nvim
unset PYENV_VERSION
