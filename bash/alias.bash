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
# alias uxplay="$HOME/UxPlay/build/uxplay"
alias ipad="uxplay"
# マイクの入出力を調整(90%, 100%は65535)
MICRO_PHONE="alsa_input.usb-Fonglun_USB_PnP_Audio_Device_201807-00.mono-fallback"
alias miku-san="pacmd list-sources | grep $MICRO_PHONE -A 10"
alias miku-kun="pacmd set-source-volume $MICRO_PHONE 58981 && pacmd list-sources | grep $MICRO_PHONE -A 10"
# easy move using ghq
alias cf='cd $(ghq list --full-path | fzf)'
#---------------------------------------

# claude code
#---------------------------------------
alias ai='$(which claude)'
alias serena-mcp-add='claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context claude-code --project "$(pwd)"'
alias terraform-mcp-add='claude mcp add terraform-mcp -s project --transport stdio -- docker run -i --rm hashicorp/terraform-mcp-server:0.3.0'
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
alias saru="git submodule update --recursive"
# stagingに上げられていない変更ファイル数をカウント
alias stcnt="git st --porcelain | grep '^ M' | wc -l"
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
# cursor
alias cs="cursor . &"
# atcoder
alias mp="cp -n ~/Documents/atcoder_pr/generic_set/main.py ."
alias mpvi="mp && vi main.py"
alias posh="poetry shell;"
function hello_snake() {
  touch exec.sh
  touch input.dat
  chmod +x ./exec.sh ./input.dat
  echo "python main.py < input.dat |& tee ^a" > ./exec.sh
  cp -n ~/Documents/atcoder_pr/generic_set/main.py . && vi main.py
}
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

# for Docker
#---------------------------------------
# alias dc="docker compose --progress=plain"
alias dc="docker compose"
alias d='docker'
alias docas="d stop $(docker ps -q)"
# alias dimg='d inspect $1 | grep -w "Image"'
alias dcr='dc run --rm'
alias dcl='dc logs -f --tail 100 -t'
# フォーマットした形でコンテナを全表示
alias dops='d ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dcps='dc ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
# 終了済のコンテナを全て削除
alias docrm='d ps -a -q -f status=exited | xargs docker rm'
function dnet() {
  printf "%-12s %-25s %-8s %-8s %s\n" "NETWORK ID" "NAME" "DRIVER" "SCOPE" "SUBNET"
  docker network ls --format "{{.ID}}\t{{.Name}}\t{{.Driver}}\t{{.Scope}}" \
    | while IFS=$'\t' read -r id name driver scope; do
      subnet=$(docker network inspect "$id" --format="{{range .IPAM.Config}}{{.Subnet}} {{end}}" | tr -d ' ')
      printf "%-12s %-25s %-8s %-8s %s\n" "$id" "$name" "$driver" "$scope" "$subnet"
    done
}
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

# for nvidia
#---------------------------------------
alias gpu="nvidia-smi -l"
#---------------------------------------

# for kubectl
#---------------------------------------
alias k='kubectl'
complete -F __start_kubectl k
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

# for java
#---------------------------------------
runjava() {
  local filename=$(basename "$1" .java)
  javac "$filename.java" && java "$filename"
}
alias rj='runjava'
#---------------------------------------

# for AWS
#---------------------------------------
alias iam="aws sts get-caller-identity --query Arn --output text"
#---------------------------------------

# for pnpm
#---------------------------------------
alias pn='pnpm'
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
PROMPT_COMMAND="share_history; $PROMPT_COMMAND"
# bashのプロセスを終了する時に、メモリ上の履歴を履歴ファイルに追記する、という動作を停止する
# （history -aによって代替されるため）
shopt -u histappend
