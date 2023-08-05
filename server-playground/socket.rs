// A UNIX socket server written in pure Rust

use std::io::Read;
use std::os::unix::net::{UnixListener, UnixStream};
use std::path::Path;

fn main() {
    let socket = Path::new("/tmp/echo.sock");

    if socket.exists() {
        std::fs::remove_file(socket).unwrap();
    }

    let listener = UnixListener::bind(socket).unwrap();
    println!("Listening on socket {:?}", socket);
    println!("===> Connect using netcat: `nc -U {:?}`", socket);
    println!("===> Connect using curl: `curl -s --unix-socket {:?} http://localhost/`", socket);
    println!("===> Press Ctrl+C to exit\n",);

    for stream in listener.incoming() {
        match stream {
            Ok(stream) => {
                handle_stream(stream);
            }
            Err(err) => {
                println!("Error while accepting connection: {:?}", err);
                break;
            }
        }
    }
}

fn handle_stream(mut stream: UnixStream) {
    let mut buf = [0; 512];

    loop {
        match stream.read(&mut buf) {
            Ok(0) => break,
            Ok(n) => {
                let data = String::from_utf8(buf[0..n].to_vec()).unwrap();
                println!("{}", data);

                break;
            }
            Err(_) => break,
        }
    }
}
