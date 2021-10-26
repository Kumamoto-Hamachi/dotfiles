#!/usr/bin/env bash

migration_cook() {
	if [ $app_name = "return" ]; then
		echo "終了するね"
		return
	fi
	if [ $order = "1" ]; then
		local order_code="no.1 python manage.py migrate $app_name"
		python manage.py migrate $app_name

	elif [ $order = "2" ]; then
		echo "migrationファイル名を指定する?"
		printf "yes or no?(returnで終了): "
		read specified
		if [ $specified = "return" ]; then
			echo "終了するね"
			return
		elif [ $specified = "yes" ]; then
			printf "指定のmigration名を教えてくれ: "
			read migration_name
			local order_code="no.2 python manage.py makemigrations $app_name --name $migration_name"
			python manage.py makemigrations $app_name --name $migration_name
		else
			local order_code="no.2 python manage.py makemigrations $app_name"
			python manage.py makemigrations $app_name
		fi

	elif [ $order = "3" ]; then
		if [ $app_name = "any" ]; then
			local order_code="no.3 python manage.py showmigrations"
			python manage.py showmigrations
		else
			local order_code="no.3 python manage.py showmigrations $app_name"
			python manage.py showmigrations $app_name
		fi
	elif [ $order = "4" ]; then
		printf "migration名も教えてくれ: "
		read migration_name
		if [ $migration_name = "return" ]; then
			echo "終了するね"
			return
		fi
		local order_code="no.4 python manage.py migrate $app_name $migration_name"
		python manage.py migrate $app_name $migration_name
	elif [ $order = "9" ]; then
		echo -e "\e[0;31mテーブルが全部初期化されるけど本当に良いのか？？？\e[m"
		echo "初期化 yes or n ?"
		read flg_bomb
		if [ $flg_bomb != "yes" ]; then
			echo "終了するね"
			return
		else
			local order_code="no.9 python manage.py migrate $app_name zero"
			python manage.py migrate $app_name zero
		fi
	else
		echo -e "\e[0;31mなんかバグってるぞ\e[m"
		return
	fi
	echo -e "\e[1;32mDONE: ${order_code}\e[m"
}

