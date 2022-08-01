#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install openjdk@11

   brew install jenv
   jenv add /usr/local/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home

   jenv global 11
fi
