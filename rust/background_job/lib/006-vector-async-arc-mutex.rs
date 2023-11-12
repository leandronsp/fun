use std::fmt::Display;
use std::sync::Arc;
use std::sync::Mutex;

use std::thread;
use std::time::Duration;

fn main() {
    let queue = Arc::new(Mutex::new(Vec::new()));

    enqueue(queue.clone(), "Some job to do: 1");
    enqueue(queue.clone(), "Another job: 2");

    thread::spawn(move || {
        process_queue(queue);
    });

    thread::sleep(Duration::from_millis(500));
}

fn enqueue<T>(queue: Arc<Mutex<Vec<T>>>, job: T) {
    queue.lock().unwrap().push(job);
}

fn process_queue<T>(queue: Arc<Mutex<Vec<T>>>) where T: Display {
    loop {
        match queue.lock().unwrap().pop() {
            Some(job) => println!("Job: {}", job),
            None => break,
        }
    }
}
