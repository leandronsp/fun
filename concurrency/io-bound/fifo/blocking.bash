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
  read -u 4 line0
  echo "Message from client0: $line0"

  read -u 5 line1
  echo "Message from client1: $line1"
done
