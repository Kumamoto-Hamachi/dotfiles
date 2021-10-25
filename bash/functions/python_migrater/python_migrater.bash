#!/usr/bin/env bash

python_migrater(){
	echo "終了したい時は基本returnで"
	local current_dir=${PWD}
	echo ${current_dir} # debug
	cd "$(dirname "$0")" # フルパスで指定したくないので
	source migration_waitor.bash
	source migration_cook.bash

	order_array=("1" "2" "3" "9")
	migration_waitor "${order_array[*]}"
	cd ${current_dir} # pythonの実行のため
	migration_cook
}
python_migrater
