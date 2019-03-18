#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install neovim
fi

# install vim-plug
curl --silent -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null
# link config
mkdir -p ~/.config/nvim
ln -sf $BASEDIR/nvim/init.vim ~/.config/nvim/init.vim

## install python-neovim
pyenv virtualenv -f $PYTHON2 nvim2 > /dev/null
export PYENV_VERSION=nvim2
pip install neovim > /dev/null
pyenv virtualenv -f $PYTHON3 nvim3 > /dev/null
export PYENV_VERSION=nvim3
pip install neovim > /dev/null
ln -sf $BASEDIR/nvim ~/.config/nvim
