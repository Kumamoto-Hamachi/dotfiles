echo ".bash_profile stands up"
#bashrcに移行予定
set -o vi
export LSCOLORS=gxfxcxdxbxegexabagacad
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
export LANG=ja_JP.UTF-8


. "$HOME/.cargo/env"

export PATH="$HOME/.poetry/bin:$PATH"


# Added by Toolbox App
export PATH="$PATH:/home/kumamoto/.local/share/JetBrains/Toolbox/scripts"

# Added by nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
