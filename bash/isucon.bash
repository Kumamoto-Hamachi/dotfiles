# for local in this game
#---------------------------------------
echo "local isucon stands up"
# すぐにssh出来るように
alias bench="ssh bench.churadata-isucon.cc"
alias app3="ssh app-3.churadata-isucon.cc"
# すぐにbench経由でwebブラウザでアクセス出来るように
alias portrun="ssh -N -L 8443:localhost:443 -L 5000:localhost:5000 app-3.churadata-isucon.cc"
# ローカルですぐにtmp.logをダウンロード
alias scp3="scp isucon@app-3.churadata-isucon.cc:/home/isucon/webapp/tmp.log ./tmp.log"
#---------------------------------------

