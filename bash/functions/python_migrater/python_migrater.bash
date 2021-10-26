#!/usr/bin/env bash

python_migrater(){
	echo "終了したい時は基本appとかでreturnと打てば抜けられるよ"
	local current_dir=${PWD}
	echo ${current_dir} # debug
	local SCRIPT_DIR=$(cd $(dirname $0); pwd) # フルパス指定
	#cd "$(dirname "$0")" # 上と比べよう
	cd ${SCRIPT_DIR}
	source migration_waitor.bash
	source migration_cook.bash

	order_array=("1" "2" "3" "4" "9")
	migration_waitor "${order_array[*]}"
	cd ${current_dir} # pythonの実行のため
	migration_cook
}
python_migrater
