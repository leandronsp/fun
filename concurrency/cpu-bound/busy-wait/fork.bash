#!/bin/bash

busy_wait() {
  end=$((SECONDS+$1))

  while [ $SECONDS -lt $end ]; do
    # some computation
    answer=$((41+1))
  done
}

for i in {1..15}; do
  echo "Starting process $i"
  busy_wait 20 &
done

wait
