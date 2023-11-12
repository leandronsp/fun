use std::fmt::Display;
use std::rc::Rc;
use std::cell::RefCell;

fn main() {
    let queue = Rc::new(RefCell::new(Vec::new()));

    enqueue(queue.clone(), "Some job to do: 1");
    enqueue(queue.clone(), "Another job: 2");

    process_queue(queue);
}

fn enqueue<T>(queue: Rc<RefCell<Vec<T>>>, job: T) {
    queue.borrow_mut().push(job);
}

fn process_queue<T>(queue: Rc<RefCell<Vec<T>>>) where T: Display {
    loop {
        match queue.borrow_mut().pop() {
            Some(job) => println!("Job: {}", job),
            None => break,
        }
    }
}
