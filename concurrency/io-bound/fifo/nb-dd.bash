#!/bin/bash

cleanup() {
  echo "Cleaning up..."
  rm -f client0 client1
  echo "Bye!"
}

trap cleanup EXIT

mkfifo client0
mkfifo client1

echo "Server started..."

while true; do
  # Read from client0
  line0=$(dd if=client0 iflag=nonblock 2>/dev/null)
  if [[ -n "$line0" ]]; then
    echo "Message from client0: $line0"
  fi

  # Read from client1
  line1=$(dd if=client1 iflag=nonblock 2>/dev/null)
  if [[ -n "$line1" ]]; then
    echo "Message from client1: $line1"
  fi

  sleep 0.5
done
