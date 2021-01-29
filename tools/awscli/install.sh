#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   USER=$(id -un)

   brew install awscli

   brew tap weaveworks/tap
   brew install weaveworks/tap/eksctl
else
   echo "No installation instructions for linux"
fi
