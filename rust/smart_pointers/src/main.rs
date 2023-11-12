fn main() {
    let mut queue = Vec::new();

    enqueue(&mut queue, "Some job to do: 1");
    enqueue(&mut queue, "Another job: 2");

    loop {
        let job = queue.pop();

        match job {
            Some(j) => println!("Job: {}", j),
            None => break,
        }

    }
}

fn enqueue<T>(queue: &mut Vec<T>, job: T) {
    queue.push(job);
}
