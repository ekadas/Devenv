#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install awscli

   brew tap weaveworks/tap
   brew install weaveworks/tap/eksctl

   brew tap common-fate/granted
   brew install granted
else
   echo "No installation instructions for linux"
fi
