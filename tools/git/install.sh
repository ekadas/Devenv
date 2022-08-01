#!/bin/bash

ln -sf "$BASEDIR/tools/git/gitconfig" ~/.gitconfig
if [ "$OS" = "Darwin" ]; then
   ln -sf "$BASEDIR/tools/git/gitexcludes" ~/.gitexcludes
fi
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o "$(brew --prefix)/etc/bash_completion.d/git"
