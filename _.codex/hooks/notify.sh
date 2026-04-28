#!/usr/bin/env bash
set -euo pipefail

INPUT=${1:-}
if [ -z "$INPUT" ] && [ ! -t 0 ]; then
  INPUT=$(cat)
fi

CWD=$(echo "${INPUT:-{}}" | jq -r '.cwd // empty' 2>/dev/null || true)
if [ -z "$CWD" ]; then
  CWD=$(pwd)
fi
PROJECT=$(basename "$CWD")

TMUX_INFO=""
if [ -n "${TMUX_PANE:-}" ]; then
  TMUX_INFO=$(tmux display-message -t "$TMUX_PANE" -p '#{session_name}:#{window_index}' 2>/dev/null || true)
fi

if [ -n "$TMUX_INFO" ]; then
  LABEL="[$TMUX_INFO] $PROJECT"
else
  LABEL="$PROJECT"
fi

SUMMARY=$(echo "${INPUT:-{}}" | jq -r '."last-assistant-message" // .last_assistant_message // ""' 2>/dev/null || true)
SUMMARY=$(printf '%s' "$SUMMARY" | head -c 100)
if [ ${#SUMMARY} -ge 100 ]; then
  SUMMARY="${SUMMARY}..."
fi

BODY="応答完了"
if [ -n "$SUMMARY" ]; then
  BODY="${BODY}\n${SUMMARY}"
fi

NOTIFY_DIR="/tmp/codex-notify"
mkdir -p "$NOTIFY_DIR"
ID_FILE="$NOTIFY_DIR/complete.id"
REPLACE_ID=0
if [ -f "$ID_FILE" ]; then
  REPLACE_ID=$(cat "$ID_FILE" 2>/dev/null || true)
  REPLACE_ID=${REPLACE_ID:-0}
fi

if command -v gdbus >/dev/null 2>&1; then
  RESULT=$(gdbus call --session \
    --dest org.freedesktop.Notifications \
    --object-path /org/freedesktop/Notifications \
    --method org.freedesktop.Notifications.Notify \
    "Codex" "$REPLACE_ID" "dialog-ok" "Codex [$LABEL]" "$BODY" \
    '[]' '{}' 'int32 -1' 2>/dev/null || true)

  echo "$RESULT" | sed -n 's/^(uint32 \([0-9]*\),)$/\1/p' > "$ID_FILE" 2>/dev/null || true
fi

pw-play /usr/share/sounds/freedesktop/stereo/complete.oga >/dev/null 2>&1 &
