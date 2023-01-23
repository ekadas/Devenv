#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install openjdk@11

   brew install jenv
   jenv add "$(brew --prefix)/Cellar/openjdk@11/11.0.18/libexec/openjdk.jdk/Contents/Home"

   jenv global 11.0.18
fi
