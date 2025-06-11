echo ".bash_profile stands up"
#bashrcに移行予定
set -o vi
export LSCOLORS=gxfxcxdxbxegexabagacad
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
#export GOPATH="$HOME/go"
#export PATH="$PATH:$GOPATH/bin"
export LANG=ja_JP.UTF-8


#export PS1="\[\e[38;5;45m\][\u \W]\$ \[\e[m\]"
#いずれも実用性に欠ける
#export PS1='\[\e[30;47m\] \t \[\e[37;46m\]\[\e[30m\] \W \[\e[36;49m\]\[\e[0m\] '
#export PS1="\[\033[31m\](*-)\[\033[0m\]< \[\033[32m\]\w\[\033[0m\] $ "
#export PS1="\[\e[38;5;45m\][\u \W]\$ \[\e[m\]
#\[\033[31m\](*'-')\[\033[0m\]< "
#cat ~/natori.ascii
. "$HOME/.cargo/env"

export PATH="$HOME/.poetry/bin:$PATH"


# Added by Toolbox App
export PATH="$PATH:/home/kumamoto/.local/share/JetBrains/Toolbox/scripts"

# Added by nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
