#!/bin/bash

USER=$(id -un)

brew install awscli

brew tap weaveworks/tap
brew install weaveworks/tap/eksctl
