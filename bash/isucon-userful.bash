# alpインストール
#---------------------------------------
cd /tmp
wget https://github.com/tkuchiki/alp/releases/download/v1.0.9/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install alp /usr/local/bin/alp
rm alp_linux_amd64.zip
alp
#---------------------------------------


# nginxの設定を読み込み
#---------------------------------------
mkdir ~/webapp/conf
sudo ln -sb /etc/nginx/sites-enabled/isucondition.conf ~/webapp/conf/isucondition.conf
cd ~/webapp/conf
# 設定を変えたらここ
sudo systemctl restart nginx.service
#---------------------------------------

# MySQLの設定を読み込み
#---------------------------------------
sudo ln -sb /etc/mysql/my.conf ~/webapp/conf/my.conf
cd ~/webapp/conf
# 設定を変えたらここ
sudo systemctl restart nginx.service
#---------------------------------------

# goのサービスの自動起動無効化
#---------------------------------------
sudo systemctl disable --now isucondition.go.service
#---------------------------------------

# git(公開会議を.gitignoreにいれること)
#---------------------------------------
git config --global user.email "onioni9999nagare@gmail.com"
git config --global user.name "Kumamoto"
#---------------------------------------

# gitconfig
#---------------------------------------
[core]
editor = vim
#---------------------------------------

# ssh
#---------------------------------------
ssh-keygen -t ed25519 -C "onioni9999nagare@gmail.com"

isucon@churadata-isucon-app-3:~/.ssh$ ssh-keygen -t ed25519 -C "onioni9999nagare@gmail.com"
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/isucon/.ssh/id_ed25519): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
#---------------------------------------

