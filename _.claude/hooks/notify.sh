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

    BODY="応答が完了しました"
    if [ -n "$SUMMARY" ]; then
      BODY="${BODY}\n${SUMMARY}"
    fi

    notify-send -u normal -i utilities-terminal "Claude [$LABEL]" "$BODY"
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null &
    ;;
  Notification)
    MESSAGE=$(echo "$INPUT" | jq -r '.message // "許可を求めています"')
    notify-send -u critical -i dialog-warning "Claude [$LABEL]" "$MESSAGE"
    paplay /usr/share/sounds/freedesktop/stereo/bell.oga 2>/dev/null &
    ;;
esac
