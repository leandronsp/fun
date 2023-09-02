#!/bin/bash

cleanup() {
  echo "Cleaning up..."
  rm -f client0 client1
  echo "Bye!"
}

trap cleanup EXIT

mkfifo client0
mkfifo client1

exec 4<> client0
exec 5<> client1

echo "Server started..."

while true; do
  read -u 4 -t 0.01 line0

  if [[ $? = 0 ]]; then
    echo "Message from client0: $line0"
  fi

  read -u 5 -t 0.01 line1

  if [[ $? = 0 ]]; then
    echo "Message from client1: $line1"
  fi

  sleep 0.5
done
