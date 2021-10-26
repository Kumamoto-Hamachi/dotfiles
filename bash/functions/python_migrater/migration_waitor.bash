#!/usr/bin/env bash
source ../check_array.bash # TODO これ雑

migration_waitor() {
	local order_array=($1)
	while :
	do
		echo -e "へい, いらっしゃい! どのマイグレートにしやしょうか?
python manage.py
 0. 終了
 1. table定義反映/初回(migrate APP名)
 2. 変更点を記録したfileを作成する(makemigrations APP名 {--name migration})
 3. 過去に実行済のmigration一覧(showmigrations APP名)
 4. 特定地点までmigrationを戻す(migrate APP名 migration名)
 9. (\e[5;31m Warning \e[m)migration実施前の状態に戻す(migrate APP名 zero)"
		printf "オーダー: "
		read order
		if [ $order = "0" ]; then
			echo "終了するね"
			exit
		elif check_array $order "${order_array[*]}"; then
			printf "OK, APP名を教えてくれ(showの時はanyもOK): "
			read app_name
			return
		else
			echo -e "おいおい, そんな\e[0;31m $order \e[mみたいなオーダーは受け付けられないぜ."
		fi
	done
}
