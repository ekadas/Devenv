#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
   echo "No installation instructions for linux"
fi
