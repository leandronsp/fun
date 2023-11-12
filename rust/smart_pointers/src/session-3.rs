use std::sync::Arc;
use std::sync::Mutex;

use std::thread;
use std::time::Duration;

#[derive(Debug)]
struct Node<T> {
    value: T,
    next: Option<Arc<Mutex<Node<T>>>>,
}

impl<T> Node<T> {
    fn new(value: T) -> Self {
       Self { value, next: None }
    }
}

#[derive(Debug)]
struct Queue<T> {
    head: Option<Arc<Mutex<Node<T>>>>,
    tail: Option<Arc<Mutex<Node<T>>>>,
}

impl<T> Queue<T> {
    fn new() -> Self {
        Self { head: None, tail: None }
    }

    fn push(&mut self, value: T) {
        let node = Arc::new(Mutex::new(Node::new(value)));

        match self.tail.take() {
            None => {
                self.head = Some(Arc::clone(&node));
            },
            Some(tail) => {
                tail.lock().unwrap().next = Some(Arc::clone(&node));
            }
        }

        self.tail = Some(Arc::clone(&node));
    }

    fn pop(&mut self) -> Option<T> where T: Clone {
        match self.head.take() {
            None => None,
            Some(head) => {
                self.head = head.lock().unwrap().next.take();
                Some(head.lock().unwrap().value.clone())
            },
        }
    }
}

fn main() {
    let queue = Arc::new(Mutex::new(Queue::new()));
    let cloned_queue = queue.clone();

    thread::spawn(move || {
        println!("Waiting for jobs in the queue...");

        loop {
            match cloned_queue.lock().unwrap().pop() {
                None => (),
                Some(job) => {
                    println!("Job arrived: {}", job);

                }
            }
        }
    });

    queue.lock().unwrap().push("Some job to do: 1");
    queue.lock().unwrap().push("Another job: 2");

    thread::sleep(Duration::from_millis(500))
}
