#!/bin/bash

curl --silent -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null
## install python-neovim
pyenv virtualenv -f $PYTHON2 nvim2 > /dev/null
export PYENV_VERSION=nvim2
pip install neovim > /dev/null
pyenv virtualenv -f $PYTHON3 nvim3 > /dev/null
export PYENV_VERSION=nvim3
pip install neovim > /dev/null
ln -sf $BASEDIR/nvim ~/.config/nvim
