#!/bin/bash

# refer  spf13-vim bootstrap.sh`

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

lnif() {
    if [ ! -e $2 ] ; then
        ln -s $1 $2
    fi
    if [ -L $2 ] ; then
        ln -sf $1 $2
    fi
}


echo "setting up symlinks"
lnif $CURRENT_DIR/vimrc $HOME/.vimrc


if [ ! -e $CURRENT_DIR/vundle ]; then
    echo "Installing Vundle"
    git clone http://github.com/gmarik/vundle.git $CURRENT_DIR/bundle/vundle
fi


echo "update/install plugins using Vundle"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u $CURRENT_DIR/vimrc +BundleInstall! +BundleClean +qall
export SHELL=$system_shell



echo "compile YouCompleteMe"
echo "if error,you need to compile it yourself"
cd $CURRENT_DIR/bundle/YouCompleteMe/
bash -x install.sh --clang-completer
