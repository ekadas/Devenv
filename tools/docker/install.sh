#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install --cask docker
else
   echo "No installation instructions for linux"
fi
