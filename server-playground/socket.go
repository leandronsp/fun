// A UNIX socket server written in Go, using the net package.

package main

import (
  "fmt"
  "net"
  "os"
)

func main() {
  // Remove any existing socket
  os.Remove("/tmp/echo.sock")

  // Create a listener
  listener, err := net.Listen("unix", "/tmp/echo.sock")
  if err != nil {
    fmt.Println("Error while listening", err)
    return
  }

  fmt.Println("Listening on socket /tmp/echo.sock...")
  fmt.Println("===> Connect using netcat: `nc -U /tmp/echo.sock`")
  fmt.Println("===> Connect using curl: `curl -s --unix-socket /tmp/echo.sock http://localhost/`")
  fmt.Println("===> Press CTRL+C to exit.")

  // Accept connections
  for {
    conn, err := listener.Accept()

    if err != nil {
      fmt.Println("Error while accepting connection", err)
      return
    }

    // Handle the connection
    buf := make([]byte, 512)
    for {
      nr, err := conn.Read(buf)

      if err != nil {
        fmt.Println("Error while reading from the socket", err)
        return
      }

      data := buf[0:nr]
      fmt.Printf("%v", string(data))

      break
    }

    conn.Close()
  }

  // Close the listener socket
  defer listener.Close()
}
