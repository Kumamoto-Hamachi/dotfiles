# basic bash
#---------------------------------------
alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias cl="clear"
alias sb="source ~/.bashrc"
# vimがあれば
alias vi="vim"
#---------------------------------------


# for only this isucon
#---------------------------------------
# よく使うpathは記録しとこう
alias web="cd /home/isucon/webapp"
# nginxのアクセスログは下記をしないと更新されない
alias ngr="sudo rm /var/log/nginx/access.log && sudo systemctl reload nginx"
# 合計の多い順に
alias clog="cat /var/log/nginx/access.log | alp ltsv --sort=sum -r > /home/isucon/webapp/tmp.log"

# サービス系
# enable-disable python service(サービス自動起動有効, 自動起動無効)
alias enable="sudo systemctl enable --now isucondition.python.service"
alias disable="sudo systemctl disable --now isucondition.python.service"
# pythonコードを変えたとき
alias restart="sudo systemctl restart isucondition.python.service"
# サービス一覧表示
alias show-service="sudo systemctl list-units --type=service"
#---------------------------------------


#---------------------------------------
# .vimrc
" 1. useful vim key-bindings
"---------------------------------------
" easy escape
inoremap jj <esc>
" easy select(one line)
nnoremap <space><space> <S-v>
" all select
nnoremap <C-c> ggVG
vnoremap <C-c> ggVG
" easy save
nnoremap <Space>ww :w<CR>
nnoremap <Space>wq :wq<CR>
set number
"---------------------------------------
