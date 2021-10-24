#!/usr/bin/bash
#conf_array=(vim bash) #TODO
readonly CONFDIR=${PWD} #TODO ~/configs(これをdotfilesに変えるのはよ)
ln -s ${CONFDIR}/bash/.bashrc ${HOME}/.bashrc
ln -s ${CONFDIR}/bash/.bash_profile ${HOME}/.bash_profile
ln -s ${CONFDIR}/tmux/.tmux.conf ${HOME}/.tmux.conf
ln -s ${CONFDIR}/vim/.vimrc ${HOME}/.vimrc
mkdir -p ${HOME}/.config/nvim
ln -s ${CONFDIR}/vim/init.vim ${HOME}/.config/nvim/init.vim
ln -s ${CONFDIR}/vim/toml/dein.toml ${HOME}/.config/nvim/toml/dein.toml
ln -s ${CONFDIR}/vim/toml/dein_lazy.toml ${HOME}/.config/nvim/toml/dein_lazy.toml
