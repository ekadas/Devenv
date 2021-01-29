#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew cask install iterm2
else
   echo "No installation instructions for linux"
fi
