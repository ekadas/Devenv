#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install tmux
else
   sudo pacman -S tmux
fi
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf $BASEDIR/tmux/tmux.conf ~/.tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins
