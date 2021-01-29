#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install kubernetes-cli
else
   echo "No installation instructions for linux"
fi
