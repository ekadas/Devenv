#!/bin/bash

if [ "$OS" = "Darwin" ]; then
   brew install awscli

   brew tap weaveworks/tap
   brew install weaveworks/tap/eksctl

   brew tap common-fate/granted
   brew install granted
else
   sudo pacman -S aws-cli-v2

   # install ssm plugin
   git clone https://aur.archlinux.org/aws-session-manager-plugin.git
   makepkg -is -p aws-session-manager-plugin/PKGBUILD
   rm -rf aws-session-manager-plugin
fi
