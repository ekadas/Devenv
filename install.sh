#!/bin/bash

BASEDIR="$( cd "$(dirname "$0")" ; pwd -P )"
OS=$(uname -s)

# configures bash
if [ "$OS" = "Darwin" ]; then
   ln -sf $BASEDIR/bash/bash_mac ~/.bash_profile
else
   ln -sf $BASEDIR/bash/bash_linux ~/.bashrc
   ln -sf $BASEDIR/bash/bash_linux ~/.bash_profile
fi

# symlinks tmux configuration
ln -sf $BASEDIR/tmux/tmux.conf ~/.tmux.conf

# configure git
ln -sf $BASEDIR/git/gitconfig ~/.gitconfig
if [ "$OS" = "Darwin" ]; then
   ln -sf $BASEDIR/git/gitexcludes ~/.gitexcludes
fi

# configure nvim
# install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf $BASEDIR/nvim ~/.config/nvim
