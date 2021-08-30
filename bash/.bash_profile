echo ".bash_profile stands up"
set -o vi
export LSCOLORS=gxfxcxdxbxegexabagacad
alias ls="ls -G"
export PS1="\[\e[38;5;45m\][\u \W]\$ \[\e[m\]"
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
