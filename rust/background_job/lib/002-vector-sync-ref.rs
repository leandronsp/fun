use std::fmt::Display;

fn main() {
    let mut queue = Vec::new();

    enqueue(&mut queue, "Some job to do: 1");
    enqueue(&mut queue, "Another job: 2");

    process_queue(&mut queue);
}

fn enqueue<T>(queue: &mut Vec<T>, job: T) {
    queue.push(job);
}

fn process_queue<T>(queue: &mut Vec<T>) where T: Display {
    loop {
        match queue.pop() {
            Some(job) => println!("Job: {}", job),
            None => break,
        }
    }
}
