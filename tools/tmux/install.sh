#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install tmux
else
   sudo pacman -S tmux
fi

ln -sf "$BASEDIR/tools/tmux/tmux.conf" ~/.tmux.conf

tmux_plugins_path=~/.tmux/plugins

if [ ! -d $tmux_plugins_path ]; then
   mkdir -p $tmux_plugins_path
   git clone https://github.com/tmux-plugins/tpm $tmux_plugins_path/tpm
   export TMUX_PLUGIN_MANAGER_PATH=$tmux_plugins_path/tpm
   $TMUX_PLUGIN_MANAGER_PATH/bin/install_plugins
fi
