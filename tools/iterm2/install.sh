#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install --cask iterm2
else
   echo "No installation instructions for linux"
fi
