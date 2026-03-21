# Create a Tmux Dev Layout with editor, ai, and terminal
# Usage: tdl <o|cc|cx|other_ai> [<second_ai>]
tdl() {
  [[ -z $1 ]] && {
    echo "Usage: tdl <o|cc|cx|other_ai> [<second_ai>]"
    return 1
  }
  [[ -z $TMUX ]] && {
    echo "You must start tmux to use tdl."
    return 1
  }

  local current_dir="${PWD}"
  local cli_pane editor_pane ai_pane ai2_pane
  local ai="$1"
  local ai2="$2"

  # Resolve AI command aliases
  _tdl_resolve_ai() {
    case "$1" in
    o) echo "opencode" ;;
    cc) echo "claude" ;;
    cx) echo "codex" ;;
    *) echo "$1" ;;
    esac
  }

  ai=$(_tdl_resolve_ai "$ai")
  [[ -n $ai2 ]] && ai2=$(_tdl_resolve_ai "$ai2")

  # Current pane becomes the CLI pane (top)
  cli_pane="$TMUX_PANE"

  tmux rename-window -t "$cli_pane" "$(basename "$current_dir")"

  # Split CLI pane vertically - CLI stays on top 15%, bottom 85%
  editor_pane=$(tmux split-window -v -p 85 -t "$cli_pane" -c "$current_dir" -P -F '#{pane_id}')

  # Split editor pane horizontally - AI on right 30%
  ai_pane=$(tmux split-window -h -p 30 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')

  if [[ -n $ai2 ]]; then
    ai2_pane=$(tmux split-window -v -t "$ai_pane" -c "$current_dir" -P -F '#{pane_id}')
    tmux send-keys -t "$ai2_pane" "$ai2" C-m
  fi

  tmux send-keys -t "$ai_pane" "$ai" C-m
  tmux send-keys -t "$editor_pane" "$EDITOR ." C-m
  tmux select-pane -t "$editor_pane"
}
