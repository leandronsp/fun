#!/bin/bash

busy_wait() {
  end=$((SECONDS+$1))

  while [ $SECONDS -lt $end ]; do
    # some computation
    answer=$((41+1))
  done
}

#busy_wait 15

for i in {1..5}; do
  echo "Starting process $i"
  busy_wait 15 &
done

wait
