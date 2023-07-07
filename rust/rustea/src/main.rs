use std::io::Write;
use std::net::{TcpListener, TcpStream};

fn main() {
    let listener = TcpListener::bind("0.0.0.0:3000").unwrap();
    println!("Listening on 3000...");

    for stream in listener.incoming() {
        let connection = stream.unwrap();
        handle_connection(connection);
    }
}

fn handle_connection(mut connection: TcpStream) {
    let response = "HTTP/1.1 200 OK\r\n\r\n\r\n<h1>Hello</h1>";
    connection.write_all(response.as_bytes()).unwrap();
}
