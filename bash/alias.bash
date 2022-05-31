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
alias bash_color=". $HOME/configs/bash/functions/color_check.bash"
alias clocate="locate ${PWD}"
alias eman="LANG=C man"
alias uxplay="$HOME/UxPlay/build/uxplay"
# マイクの入出力を調整(90%, 100%は65535)
MICRO_PHONE="alsa_input.usb-Fonglun_USB_PnP_Audio_Device_201807-00.mono-fallback"
alias miku-kun="pacmd set-source-volume $MICRO_PHONE 58981 && pacmd list-sources | grep $MICRO_PHONE -A 10"
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
alias pr='poetry run'
alias prp='poetry run python'
# pycharm
alias charm="pycharm . &"
# atcoder
alias mp="cp -n ~/Documents/atcoder_pr/generic_set/main.py ."
alias mpv="mp && vi main.py"
alias posh="poetry shell;"
#alias isort="find application/ -name '*.py' -not -path '*migrations*' -not -path 'application/lib/*' | xargs poetry run isort -ns __init__.py -m 3 -y"
#---------------------------------------

# python/Django
#---------------------------------------
alias manage="python manage.py"
alias pymm="bash $HOME/configs/bash/functions/python_migrater/python_migrater.bash"
alias testk="python manage.py test --keep"
# poshする前
alias pshell='poetry run python ./manage.py shell_plus'
# posh前提
alias shell='python ./manage.py shell_plus'
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
