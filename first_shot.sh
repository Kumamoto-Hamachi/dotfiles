#!/usr/bin/bash
#conf_array=(vim bash) #TODO
readonly CONFDIR=${PWD}
ln -s ${CONFDIR}/vim/.vimrc ${HOME}/.vimrc
ln -s ${CONFDIR}/bash/.bashrc ${HOME}/.bashrc
ln -s ${CONFDIR}/bash/.bash_profile ${HOME}/.bash_profile
