#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install openjdk@11

   brew install jenv
   jenv add "$(brew --prefix)/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home"
   jenv add "$(brew --prefix)/opt/openjdk/libexec/openjdk.jdk/Contents/Home"

   jenv global 19.0
fi
