use std::sync::mpsc;
use std::thread;

fn main() {
    let (tx, rx) = mpsc::channel();

    thread::spawn(move || {
      let received = rx.recv().unwrap();
      println!("Got: {}", received);
    });

    let val = String::from("hi");
    tx.send(val).unwrap();

    println!("Val: {}", val);
}
