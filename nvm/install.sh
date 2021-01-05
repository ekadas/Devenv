#!/bin/bash

mkdir $NVM_DIR
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

# install node versions
nvm install --lts
nvm use --lts

# install lsps, linters and formatters
npm install -g \
   prettier \
   prettier-plugin-java \
   standard \
   typescript typescript-language-server \
   vscode-json-languageserver \
   yaml-language-server \
   elm elm-test elm-format @elm-tooling/elm-language-server \
   vscode-css-languageserver-bin
