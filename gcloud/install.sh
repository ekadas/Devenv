#!/bin/bash

USER=$(id -un)

pyenv virtualenv -f $PYTHON2 gcloud > /dev/null
export CLOUDSDK_CORE_DISABLE_PROMPTS=1
export CLOUDSDK_INSTALL_DIR=/usr/local/share
export CLOUDSDK_PYTHON=/Users/$USER/.pyenv/shims/python
export PYENV_VERSION=gcloud
curl --silent https://sdk.cloud.google.com | bash > /dev/null
