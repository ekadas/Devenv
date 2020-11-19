#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install go
else
   sudo pacman -S go
fi
