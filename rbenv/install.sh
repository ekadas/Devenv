#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install rbenv
else
   curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
fi

rbenv init
rbenv install 2.6.3
rbenv local 2.6.3
gem install bundler
