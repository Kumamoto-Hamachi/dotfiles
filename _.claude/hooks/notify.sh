#!/bin/bash
INPUT=$(cat)
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // "unknown"')
CWD=$(echo "$INPUT" | jq -r '.cwd // "unknown"')
PROJECT=$(basename "$CWD")

# tmuxセッション情報を取得
TMUX_INFO=""
if [ -n "$TMUX_PANE" ]; then
  TMUX_INFO=$(tmux display-message -t "$TMUX_PANE" -p '#{session_name}:#{window_index}' 2>/dev/null)
fi

if [ -n "$TMUX_INFO" ]; then
  LABEL="[$TMUX_INFO] $PROJECT"
else
  LABEL="$PROJECT"
fi

# 前回の通知を上書きするD-Bus通知送信関数
send_notify() {
  local icon="$1" title="$2" body="$3" id_file="$4"
  local replace_id=0
  if [ -f "$id_file" ]; then
    replace_id=$(cat "$id_file" 2>/dev/null)
    replace_id=${replace_id:-0}
  fi

  local result
  result=$(gdbus call --session \
    --dest org.freedesktop.Notifications \
    --object-path /org/freedesktop/Notifications \
    --method org.freedesktop.Notifications.Notify \
    "Claude Code" "$replace_id" "$icon" "$title" "$body" \
    '[]' '{}' 'int32 -1' 2>/dev/null)

  # 返り値 (uint32 ID,) からIDを抽出して保存
  echo "$result" | sed -n 's/^(uint32 \([0-9]*\),)$/\1/p' > "$id_file" 2>/dev/null
}

NOTIFY_DIR="/tmp/claude-notify"
mkdir -p "$NOTIFY_DIR"

case "$EVENT" in
  Stop)
    # サブエージェントの完了通知は抑制
    AGENT_TYPE=$(echo "$INPUT" | jq -r '.agent_type // empty')
    if [ -n "$AGENT_TYPE" ]; then
      exit 0
    fi

    SUMMARY=$(echo "$INPUT" | jq -r '.last_assistant_message // ""' | head -c 100)
    if [ ${#SUMMARY} -ge 100 ]; then
      SUMMARY="${SUMMARY}..."
    fi

    BODY="応答完了"
    if [ -n "$SUMMARY" ]; then
      BODY="${BODY}\n${SUMMARY}"
    fi

    send_notify "dialog-ok" "Claude [$LABEL]" "$BODY" "$NOTIFY_DIR/stop.id"
    pw-play /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null &
    ;;
  Notification)
    MESSAGE=$(echo "$INPUT" | jq -r '.message // "許可依頼"')
    send_notify "dialog-question" "Claude [$LABEL]" "$MESSAGE" "$NOTIFY_DIR/notification.id"
    pw-play /usr/share/sounds/freedesktop/stereo/bell.oga 2>/dev/null &
    ;;
esac
