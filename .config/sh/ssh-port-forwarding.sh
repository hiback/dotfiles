# fip: forward local ports to remote host
fip() {
  (( $# < 2 )) && echo "Usage: fip <host> <port1> [port2] ..." && return 1
  local host="$1"
  shift
  for port in "$@"; do
    ssh -f -N -L "${port}:localhost:${port}" "$host" && echo "Forwarding localhost:${port} -> ${host}:${port}"
  done
}

# dip: disconnect port forwarding
dip() {
  (( $# == 0 )) && echo "Usage: dip <port1> [port2] ..." && return 1
  for port in "$@"; do
    pkill -f "ssh.*-L ${port}:localhost:${port}" && echo "Stopped forwarding port ${port}" || echo "No forwarding on port ${port}"
  done
}

# lip: list active port forwards
lip() {
  local ports
  ports=$(ps -eo args | grep "[s]sh.*-L.*localhost" | grep -oE '[0-9]+:localhost:[0-9]+' | cut -d: -f1)
  if [[ -n $ports ]]; then
    echo "$ports"
  else
    echo "No active forwards"
  fi
}
