#!/bin/bash

ln -sf $BASEDIR/git/gitconfig ~/.gitconfig
if [ "$OS" = "Darwin" ]; then
   ln -sf $BASEDIR/git/gitexcludes ~/.gitexcludes
fi
