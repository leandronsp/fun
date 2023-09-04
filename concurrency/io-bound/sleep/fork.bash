#!/bin/bash

# sleep 15

for i in {1..8}; do
  echo "Starting process $i"
  sleep 20 &
done

wait
