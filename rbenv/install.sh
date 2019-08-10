#!/bin/bash

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash

rbenv init
rbenv install 2.6.3
rbenv local 2.6.3
gem install bundler
