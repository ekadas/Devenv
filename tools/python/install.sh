#!/bin/bash

python=3.8.0

if [ "$OS" = "Darwin" ]; then
   brew install pyenv-virtualenv > /dev/null
   export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
else
   curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer > /dev/null | bash > /dev/null
fi
pyenv install -s $python > /dev/null
