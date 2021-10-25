#!/usr/bin/env bash
check_array() {
    local i
    local input=${1}
	local str_array=($2)
    for i in ${str_array[@]}; do
        if [[ ${i} = ${input} ]]; then
            return 0
        fi
    done
    return 1
}
<< COMMENTOUT
- 使い方
配列はそのままでは渡せないので文字列にしてしまおう.
order_array=("1" "2" "3" "9")
order = 1
if check_array $order "${order_array[*]}"; then
COMMENTOUT
