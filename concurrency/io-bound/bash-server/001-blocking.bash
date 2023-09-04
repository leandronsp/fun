#!/bin/bash

handleRequest() {
    random_sleep=$(awk -v min=0.01 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
    sleep $random_sleep

    echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>Hello!</h1>"
}

export -f handleRequest

echo 'Listening on 3000...'

while true; do 
  handleRequest | nc -lN 3000
done
