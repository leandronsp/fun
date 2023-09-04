#!/bin/bash

declare -A subscriptions

cleanup() {
  echo "Cleaning up..."
  
  for fifo in "${!subscriptions[@]}"; do
    rm -f "$fifo"
  done

  echo "Bye!"
}

trap cleanup EXIT

subscribe() {
  local topic=$1
  mkfifo $topic
  subscriptions[$topic]=1
}

unsubscribe() {
  local topic=$1
  rm -f "$topic"
  unset subscriptions[$topic]
}

publish() {
  local topic=$1
  local msg=$2

  echo "$msg" > $topic
}

listen() {
  local topic=$1
  local msg 

  while true; do
    if [[ -e "$topic" ]]; then
      msg=$(dd if="$topic" iflag=nonblock 2>/dev/null)

      if [[ -n "$msg" ]]; then
        echo "Received message in $topic: $msg"
      fi
    fi

    sleep 0.1
  done
}

export -f subscribe 
export -f unsubscribe 
export -f publish 
export -f listen 
