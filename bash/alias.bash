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
alias etldr="LANG=C tldr"
alias uxplay="$HOME/UxPlay/build/uxplay"
alias ipad="uxplay"
# マイクの入出力を調整(90%, 100%は65535)
MICRO_PHONE="alsa_input.usb-Fonglun_USB_PnP_Audio_Device_201807-00.mono-fallback"
alias miku-san="pacmd list-sources | grep $MICRO_PHONE -A 10"
alias miku-kun="pacmd set-source-volume $MICRO_PHONE 58981 && pacmd list-sources | grep $MICRO_PHONE -A 10"
# easy move using ghq
alias cf='cd $(ghq list --full-path | fzf)'
#

alias bloomrpc='~/Downloads/App/BloomRPC-1.5.3.AppImage'
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
alias sw="git sw"
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
function hello_snake() {
    touch exec.sh
    touch input.dat
    chmod +x ./exec.sh ./input.dat
    echo "python main.py < input.dat |& tee ^a" > ./exec.sh
    cp -n ~/Documents/atcoder_pr/generic_set/main.py . && vi main.py
}
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
alias d='docker'
# alias dimg='docker inspect $1 | grep -w "Image"'
alias dcr='docker-compose run --rm'
alias dcl='docker-compose logs -f --tail 100 -t'
#---------------------------------------

# for GitHub
#---------------------------------------
alias webpr="gh pr create --web"
alias clean-git="gh clean-branches"
#---------------------------------------

# for zenn
#---------------------------------------
alias new="new:article"
#---------------------------------------

# for isucon
#---------------------------------------
alias app1="ssh app-1.churadata-isucon.cc"
alias app2="ssh app-2.churadata-isucon.cc"
alias app3="ssh app-3.churadata-isucon.cc"
alias bench="ssh bench.churadata-isucon.cc"
alias portrun="ssh -N -L 8443:localhost:443 -L 5000:localhost:5000 app-3.churadata-isucon.cc"
#---------------------------------------

# for nvidia
#---------------------------------------
alias gpu="nvidia-smi -l"
#---------------------------------------

# for kubectl
#---------------------------------------
alias k='kubectl'
alias kn='kubectl -n'
#---------------------------------------

# for reviewdog
#---------------------------------------
alias reviewdog='./bin/reviewdog'
#---------------------------------------

# for circleci
#---------------------------------------
alias cic='circleci'
#---------------------------------------

function share_history {
  # 最後に実行したコマンドを履歴ファイルに追記
  history -a
  # メモリ上のコマンド履歴を消去
  history -c
  # 履歴ファイルからメモリへコマンド履歴を読み込む
  history -r
}
# 上記の一連の処理を、プロンプト表示前に（＝何かコマンドを実行することに）実行する
PROMPT_COMMAND="share_history; $PROMPT_COMMAND";
# bashのプロセスを終了する時に、メモリ上の履歴を履歴ファイルに追記する、という動作を停止する
# （history -aによって代替されるため）
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
shopt -u histappend
