#!/bin/bash

cleanup() {
  echo "Cleaning up..."
  rm -f fifo1 fifo2 fifo3 fifo4
  echo "Bye!"
}

trap cleanup EXIT

mkfifo fifo1
mkfifo fifo2
mkfifo fifo3
mkfifo fifo4

exec 3<> fifo1
exec 4<> fifo2
exec 5<> fifo3
exec 6<> fifo4

function io_select() {
  local fd
  local msg 
  local ready_fds

  for fd in "$@"; do
    msg=$(dd if=$fd iflag=nonblock 2>/dev/null | \
      tee >(dd of=$fd conv=notrunc 2>/dev/null))

    if [[ -n "$msg" ]]; then
      ready_fds+=($fd)
    fi
  done

  echo "${ready_fds[@]}"
}

while true; do
    ready=$(io_select fifo1 fifo2 fifo3 fifo4)

    for fifo in $ready; do
        msg=$(dd if="$fifo" iflag=nonblock 2>/dev/null)

        if [[ -n "$msg" ]]; then
          echo "Message in $fifo: $msg"
        fi
    done

    sleep 0.1
done
