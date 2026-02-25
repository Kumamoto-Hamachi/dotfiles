#!/usr/bin/env bash
# colorfield - パイプ入力の指定フィールドに色を付ける
#
# Usage:
#   command | colorfield FIELD_NUM COLOR
#   command | colorfield 2 RED        # 先頭から2番目
#   command | colorfield -1 BLUE      # 末尾から1番目(最後)
#   command | colorfield -2 GREEN     # 末尾から2番目
#
# Colors:
#   RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE,
#   BOLD_RED, BOLD_GREEN, ... (BOLD_付きで太字)

colorfield() {
  local field="${1:?Usage: colorfield FIELD_NUM COLOR (negative for from end)}"
  local color_name="${2:?Usage: colorfield FIELD_NUM COLOR (negative for from end)}"

  # 色名 -> ANSIコード変換
  local code
  case "${color_name^^}" in
    RED)          code="31" ;;
    GREEN)        code="32" ;;
    YELLOW)       code="33" ;;
    BLUE)         code="34" ;;
    MAGENTA)      code="35" ;;
    CYAN)         code="36" ;;
    WHITE)        code="37" ;;
    BOLD_RED)     code="1;31" ;;
    BOLD_GREEN)   code="1;32" ;;
    BOLD_YELLOW)  code="1;33" ;;
    BOLD_BLUE)    code="1;34" ;;
    BOLD_MAGENTA) code="1;35" ;;
    BOLD_CYAN)    code="1;36" ;;
    BOLD_WHITE)   code="1;37" ;;
    *)
      echo "Unknown color: $color_name" >&2
      echo "Available: RED GREEN YELLOW BLUE MAGENTA CYAN WHITE (BOLD_ prefix for bold)" >&2
      return 1
      ;;
  esac

  awk -v n="$field" -v c="$code" '{
    # 負の値なら末尾から計算 (-1=最後, -2=最後から2番目)
    target = (n < 0) ? NF + n + 1 : n
    for (i = 1; i <= NF; i++) {
      if (i > 1) printf " "
      if (i == target)
        printf "\033[" c "m" $i "\033[0m"
      else
        printf "%s", $i
    }
    printf "\n"
  }'
}
