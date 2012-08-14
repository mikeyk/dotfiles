#! /bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -ns $DIR/zshrc ~/.zshrc
ln -ns $DIR/zsh ~/.zsh
ln -ns $DIR/vimrc ~/.vimrc
ln -nsf $DIR/vimstuff ~/.vim
ln -ns $DIR/zsh/themes/prose ~/.oh-my-zsh/themes/prose.zsh-theme
