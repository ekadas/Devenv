#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install neovim
else
   sudo pacman -S neovim
fi

# install vim-plug
curl --silent -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >/dev/null
# link config
mkdir -p ~/.config/nvim
ln -sf $BASEDIR/tools/nvim/* ~/.config/nvim

# install fzf dependency
if ! command -v fd &>/dev/null; then
   if [ "$OS" = "Darwin" ]; then
      brew install fd
   else
      sudo pacman -S fd
   fi
fi
