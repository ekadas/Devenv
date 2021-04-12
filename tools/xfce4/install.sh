#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   echo "No installation instructions for mac"
else
   config_path=~/.config/xfce4/terminal
   mkdir -p $config_path
   rm $config_path/terminalrc
   ln -sf "$BASEDIR/tools/xfce4/terminalrc" "$config_path/terminalrc"
fi
