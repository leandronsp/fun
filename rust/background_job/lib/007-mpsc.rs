use std::sync::mpsc;
use std::thread;

fn main() {
    // Initialize channel
    let (tx, rx) = mpsc::channel();

    // Push data to the channel
    tx.send("Some job to do: 1").unwrap();
    tx.send("Another job: 2").unwrap();

    let worker = thread::spawn(move || {
        loop {
            let job = rx.recv();

            match job {
                Ok(job) => println!("Job: {}", job),
                Err(_) => break,
            }
        }
    });

    // Push more data to the channel
    tx.send("Yet another job").unwrap();

    worker.join().unwrap();
}
