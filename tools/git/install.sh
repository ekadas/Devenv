#!/bin/bash

ln -sf $BASEDIR/tools/git/gitconfig ~/.gitconfig
if [ "$OS" = "Darwin" ]; then
   ln -sf $BASEDIR/tools/git/gitexcludes ~/.gitexcludes
fi
