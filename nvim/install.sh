#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install --HEAD neovim
fi

# install vim-plug
curl --silent -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null
# link config
mkdir -p ~/.config
ln -sf $BASEDIR/nvim ~/.config/nvim

# install fzf dependency
if ! command -v fd &> /dev/null ; then
   if [ "$OS" = "Darwin" ]; then
      brew install fd
   else
      sudo pacman -S fd
   fi
fi

# install formatter
## requires go
if ! command -v go &> /dev/null ; then
   source go/install.sh
fi
go get github.com/mattn/efm-langserver

npm install -g \
   prettier \
   prettier-plugin-java \
   standard \
   typescript typescript-language-server \
   vscode-json-languageserver \
   yaml-language-server \
   elm elm-test elm-format @elm-tooling/elm-language-server \
   vscode-css-languageserver-bin \
   bash-language-server
