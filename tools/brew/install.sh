#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
   echo "No installation instructions for linux"
fi
