# Create a Tmux Dev Layout with editor, ai, and terminal
# Usage: tdl <o|cc|cx|other_ai> [<second_ai>]
tdl() {
  [[ -z $1 ]] && {
    echo "Usage: tdl <oc|cl|cx|other_ai> [<second_ai>]"
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

  # Current pane becomes the left side
  editor_pane="$TMUX_PANE"

  tmux rename-window -t "$editor_pane" "$(basename "$current_dir")"

  # Split horizontally first - AI on right 30% (full height)
  ai_pane=$(tmux split-window -h -p 30 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')

  # Split left side vertically - CLI on top 15%, nvim below 85%
  cli_pane=$(tmux split-window -v -p 85 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')
  # After split: editor_pane = top (CLI), cli_pane = bottom (nvim)
  # Swap names to match intent
  local tmp="$editor_pane"
  editor_pane="$cli_pane"
  cli_pane="$tmp"

  if [[ -n $ai2 ]]; then
    ai2_pane=$(tmux split-window -v -t "$ai_pane" -c "$current_dir" -P -F '#{pane_id}')
    tmux send-keys -t "$ai2_pane" "$ai2" C-m
  fi

  tmux send-keys -t "$ai_pane" "$ai" C-m
  tmux send-keys -t "$editor_pane" "$EDITOR ." C-m
  tmux select-pane -t "$editor_pane"
}
