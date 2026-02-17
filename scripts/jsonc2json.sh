#!/usr/bin/bash
# JSONC → JSON 変換スクリプト
# settings.jsonc からコメントを除去して settings.json を生成する

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

JSONC_FILE="${REPO_DIR}/_.claude/settings.jsonc"
JSON_FILE="${REPO_DIR}/_.claude/settings.json"

if [ ! -f "$JSONC_FILE" ]; then
  echo "✗ settings.jsonc が見つかりません: $JSONC_FILE"
  exit 1
fi

node -e "
  const fs = require('fs');
  const input = fs.readFileSync('$JSONC_FILE', 'utf8');
  // 文字列リテラル内のコメント記号を保護しつつコメントを除去
  const stripped = input
    .replace(/\"(?:[^\"\\\\]|\\\\.)*\"/g, (m) => m.replace(/\\/\\//g, '__SLASH__'))
    .replace(/\\/\\/.*$/gm, '')
    .replace(/\\/\\*[\\s\\S]*?\\*\\//g, '')
    .replace(/__SLASH__/g, '//')
    // 末尾カンマを除去（JSONでは不正）
    .replace(/,(\s*[\\]\\}])/g, '\$1');
  const parsed = JSON.parse(stripped);
  fs.writeFileSync('$JSON_FILE', JSON.stringify(parsed, null, 2) + '\\n');
"

echo "✓ settings.json を生成しました: $JSON_FILE"
