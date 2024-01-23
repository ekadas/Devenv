#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install mise
else
   echo "No installation instructions for linux"
fi
