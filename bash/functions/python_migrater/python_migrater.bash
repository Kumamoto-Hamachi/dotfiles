#!/usr/bin/env bash

python_migrater(){
	# タイトルコール, パス取得, 初期配置移動
	echo "終了したい時は基本appとかでreturnと打てば抜けられるよ"
	local current_dir=${PWD}
	local SCRIPT_DIR=$(cd $(dirname $0); pwd) # フルパス指定
	echo "current_dir is ${current_dir}" # debug
	echo "script_dir is ${SCRIPT_DIR}" # debug
	#cd "$(dirname "$0")" # 上と比べよう
	cd ${SCRIPT_DIR}
	cat title.ascii
	# ウェイター, 料理人取得
	source migration_waitor.bash
	source migration_cook.bash
	# 処理
	order_array=("1" "2" "3" "4" "9")
	migration_waitor "${order_array[*]}"
	cd ${current_dir} # pythonの実行のため
	migration_cook
}
python_migrater
