#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install tmux
else
   sudo pacman -S tmux
fi
ln -sf $BASEDIR/tmux/tmux.conf ~/.tmux.conf
