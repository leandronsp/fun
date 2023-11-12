use std::fmt::Display;
use std::sync::Arc;

use std::thread;
use std::time::Duration;

fn main() {
    let queue = Arc::new(Vec::new());

    enqueue(queue.clone(), "Some job to do: 1");
    enqueue(queue.clone(), "Another job: 2");

    thread::spawn(move || {
        process_queue(queue);
    });

    thread::sleep(Duration::from_millis(500));
}

fn enqueue<T>(queue: Arc<Vec<T>>, job: T) {
    queue.push(job);
}

fn process_queue<T>(queue: Arc<Vec<T>>) where T: Display {
    loop {
        match queue.pop() {
            Some(job) => println!("Job: {}", job),
            None => break,
        }
    }
}
