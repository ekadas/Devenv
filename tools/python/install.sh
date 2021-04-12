#!/bin/bash

python=3.8.0

if [ "$OS" = "Darwin" ]; then
   brew install pyenv-virtualenv >/dev/null
   CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
   export CFLAGS
else
   curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer >/dev/null | bash >/dev/null
fi
pyenv install -s $python >/dev/null
