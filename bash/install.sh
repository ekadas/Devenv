#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   ln -sf $BASEDIR/bash/bash_mac ~/.bash_profile
   brew install bash-completion
else
   ln -sf $BASEDIR/bash/bash_linux ~/.bashrc
   ln -sf $BASEDIR/bash/bash_linux ~/.bash_profile
fi
