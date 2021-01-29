#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   ln -sf $BASEDIR/tools/bash/bash_mac ~/.bash_profile
   brew install bash-completion
else
   ln -sf $BASEDIR/tools/bash/bash_linux ~/.bashrc
   ln -sf $BASEDIR/tools/bash/bash_linux ~/.bash_profile
fi

source ~/.bash_profile
