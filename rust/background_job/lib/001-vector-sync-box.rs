use std::fmt::Display;

fn main() {
    let queue = Box::new(Vec::new());

    enqueue(*queue.clone(), "Some job to do: 1");
    enqueue(*queue.clone(), "Another job: 2");

    process_queue(*queue);
}

fn enqueue<T>(mut queue: Vec<T>, job: T) {
    queue.push(job);
}

fn process_queue<T>(mut queue: Vec<T>) where T: Display {
    loop {
        match queue.pop() {
            Some(job) => println!("Job: {}", job),
            None => break,
        }
    }
}
