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
