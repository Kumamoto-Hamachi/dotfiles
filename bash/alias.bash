echo "alias.bash stands up"
# Basic
#---------------------------------------
alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias cl="clear"
alias ls="ls -G"
alias sb="source ~/.bashrc"
alias sbp="source ~/.bash_profile"
alias pbcopy="xclip -selection c"
alias pbpaste="xclip -selection c -o"
alias pp="pwd | pbcopy"
alias open="xdg-open"
alias pdf="zathura --fork"
#---------------------------------------

# apt
#---------------------------------------
alias aptl="apt list --installed 2>/dev/null | grep"
alias aptgrade="sudo apt-get update && sudo apt-get -y upgrade"
#---------------------------------------

# git
#---------------------------------------
alias st="git st"
alias br="git br"
#---------------------------------------

# Vi
#---------------------------------------
alias vi="nvim"
alias ev="vi ~/.config/nvim/init.vim"
alias evi="vi ~/.vimrc"
alias eb="vi ~/.bashrc"
alias ebp="vi ~/.bash_profile"
alias hv="vi ~/config_master/vim/vim_info.md"
#---------------------------------------

# python
#---------------------------------------
alias f8="flake8"
alias po='poetry run'
alias pop='poetry run python'
# pycharm
alias charm="pycharm . &"
# atcoder
alias mp="cp -n ~/Documents/atcoder_pr/generic_set/main.py ."
alias mpv="mp && vi main.py"
#---------------------------------------

# docker
#---------------------------------------
alias dc="docker-compose"
alias docas="docker stop $(docker ps -q)"
#---------------------------------------
