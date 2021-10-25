echo "alias.bash stands up"
# Basic
#---------------------------------------
alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias cl="clear"
alias sb="source ~/.bashrc"
alias sbp="source ~/.bash_profile"
alias pbcopy="xclip -selection c"
alias pbpaste="xclip -selection c -o"
alias pp="pwd | pbcopy"
alias open="xdg-open"
alias pdf="zathura --fork"
alias ls="ls -G --color=auto"
alias bat="batcat"
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
alias vi="nvim -p" #p2にすると1つのファイルを開いた時も強制的に2つ目の無名ファイル出来る
alias ev="vi ~/.config/nvim/init.vim"
alias evi="vi ~/.vimrc"
alias eb="vi ~/.bashrc"
alias ebp="vi ~/.bash_profile"
alias hv="vi ~/config_master/vim/vim_info.md"
alias vz='vi $(fzf)' # down:ctrl-n, up:ctrl-p, double quotation is not working well
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
alias posh="poetry shell;"
alias pym="python manage.py"
alias pymm="bash $HOME/configs/bash/functions/python_migrater/python_migrater.bash"
#---------------------------------------

# ruby
#---------------------------------------
alias gem="rbenv exec gem"
#---------------------------------------

# docker
#---------------------------------------
alias dc="docker-compose"
alias docas="docker stop $(docker ps -q)"
#---------------------------------------
