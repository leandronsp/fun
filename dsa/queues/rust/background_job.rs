use std::sync::{Arc, Mutex};
use std::sync::Condvar;
use std::thread;
use std::collections::HashMap;
use std::time::Duration;

struct Node<T> {
    value: T,
    next: Option<Arc<Mutex<Node<T>>>>,
    previous: Option<Arc<Mutex<Node<T>>>>,
}

impl<T> Node<T> {
    fn new(value: T) -> Node<T> {
        Node { value, next: None, previous: None, }
    }
}

struct Deque<T> {
    head: Option<Arc<Mutex<Node<T>>>>,
    tail: Option<Arc<Mutex<Node<T>>>>,
}

#[allow(dead_code)]
impl<T> Deque<T> {
    fn new() -> Deque<T> {
        Deque { head: None, tail: None }
    }

    fn lpush(&mut self, value: T) {
        let node = Arc::new(Mutex::new(Node::new(value)));

        match &self.head {
            Some(head_ref) => {
                node.lock().unwrap().next = Some(head_ref.clone());
                head_ref.lock().unwrap().previous = Some(node.clone());
                self.head = Some(node.clone());
            },
            None => {
                self.head = Some(node.clone());
                self.tail = Some(node.clone());
            }
        }
    }

    fn rpush(&mut self, value: T) {
        let node = Arc::new(Mutex::new(Node::new(value)));

        match &self.tail {
            Some(tail_ref) => {
                node.lock().unwrap().previous = Some(tail_ref.clone());
                tail_ref.lock().unwrap().next = Some(node.clone());
                self.tail = Some(node.clone());
            },
            None => {
                self.head = Some(node.clone());
                self.tail = Some(node.clone());
            }
        }
    }

    fn lpop(&mut self) -> Option<T> where T: Clone {
        match &self.head {
            Some(head_ref) => {
                let value = head_ref.lock().unwrap().value.clone();
                let next_ref = head_ref.lock().unwrap().next.clone();

                match &next_ref {
                    Some(next_ref) => {
                        next_ref.lock().unwrap().previous = None;
                        self.head = Some(next_ref.clone());
                    },
                    None => {
                        self.head = None;
                        self.tail = None;
                    }
                }
                Some(value)
            },
            None => None
        }
    }

    fn rpop(&mut self) -> Option<T> where T: Clone {
        match &self.tail {
            Some(tail_ref) => {
                let value = tail_ref.lock().unwrap().value.clone();
                let previous_ref = tail_ref.lock().unwrap().previous.clone();

                match &previous_ref {
                    Some(previous_ref) => {
                        previous_ref.lock().unwrap().next = None;
                        self.tail = Some(previous_ref.clone());
                    },
                    None => {
                        self.head = None;
                        self.tail = None;
                    }
                }
                Some(value)
            },
            None => None
        }
    }

    fn rpoplpush(&mut self, other: &mut Deque<T>) -> Option<T> where T: Clone {
        let value = self.rpop();

        match &value {
            Some(value) => other.lpush(value.clone()),
            None => ()
        }

        value
    }

    fn to_vec(&self) -> Vec<T> where T: Clone {
        let mut vec = Vec::new();
        let mut current = self.head.clone();

        while let Some(node) = current {
            vec.push(node.lock().unwrap().value.clone());
            current = node.lock().unwrap().next.clone();
        }

        vec
    }
}

struct BlockingDeque<T> {
    store: Mutex<Deque<T>>,
    emitter: Condvar,
}

#[allow(dead_code)]
impl<T> BlockingDeque<T> {
    fn new() -> BlockingDeque<T> {
        BlockingDeque {
            store: Mutex::new(Deque::new()),
            emitter: Condvar::new(),
        }
    }

    fn lpush(&self, t: T) {
        self.store.lock().unwrap().lpush(t);
        self.emitter.notify_one();
    }

    fn rpush(&self, t: T) {
        self.store.lock().unwrap().rpush(t);
        self.emitter.notify_one();
    }

    fn blpop(&self) -> Option<T> where T: Clone {
        let mut store = self.store.lock().unwrap();

        while store.head.is_none() {
            store = self.emitter.wait(store).unwrap();
        }

        store.lpop()
    }

    fn brpop(&self) -> Option<T> where T: Clone {
        let mut store = self.store.lock().unwrap();

        while store.head.is_none() {
            store = self.emitter.wait(store).unwrap();
        }

        store.rpop()
    }

    fn brpoplpush(&self, other: &BlockingDeque<T>) -> Option<T> where T: Clone {
        let mut store = self.store.lock().unwrap();

        while store.tail.is_none() {
            store = self.emitter.wait(store).unwrap();
        }

        let value = store.rpoplpush(&mut other.store.lock().unwrap());

        self.emitter.notify_one();

        value
    }

    fn lpop(&self) -> Option<T> where T: Clone {
        self.store.lock().unwrap().lpop()
    }

    fn rpop(&self) -> Option<T> where T: Clone {
        self.store.lock().unwrap().rpop()
    }

    fn to_vec(&self) -> Vec<T> where T: Clone {
        self.store.lock().unwrap().to_vec()
    }
}

struct Worker {
    task_queue: Arc<BlockingDeque<i32>>,
    processing_queue: Arc<BlockingDeque<i32>>,
    dlq: Arc<BlockingDeque<i32>>,
    retries: Arc<Mutex<HashMap<i32, i32>>>,
}

impl Worker {
    fn new() -> Worker {
        Worker {
            task_queue: Arc::new(BlockingDeque::new()),
            processing_queue: Arc::new(BlockingDeque::new()),
            dlq: Arc::new(BlockingDeque::new()),
            retries: Arc::new(Mutex::new(HashMap::new())),
        }
    }
}

struct Processor {}

impl Processor {
    fn start(worker: Arc<Worker>) {
        let task_queue = worker.task_queue.clone();
        let processing_queue = worker.processing_queue.clone();
        let dlq = worker.dlq.clone();
        let retries = worker.retries.clone();

        thread::spawn(move || {
            loop {
                let task = task_queue.brpoplpush(&processing_queue);

                match task {
                    Some(task) => {
                        if task == 42 {
                            let mut retries = retries.lock().unwrap();
                            let current_retry = *retries.entry(task).or_insert(0) + 1;
                            retries.insert(task, current_retry);

                            if current_retry > 3 {
                                processing_queue.brpoplpush(&dlq);
                            } else {
                                processing_queue.brpoplpush(&task_queue);
                            }
                        } else {
                            let duration = Duration::from_secs(task as u64);
                            thread::sleep(duration);
                            processing_queue.brpop();
                        }
                    },
                    None => ()
                }
            }
        });
    }
}

mod tests {
    use super::*;

    #[test]
    fn test_background_processor() {
        // Start a worker
        let worker = Arc::new(Worker::new());
        Processor::start(worker.clone());

        // Push a task to the task_queue
        worker.task_queue.lpush(1);
        assert_eq!(worker.task_queue.to_vec().len(), 1);
        assert_eq!(worker.processing_queue.to_vec().len(), 0);

        // Wait for the task to be processed
        while worker.processing_queue.to_vec().len() == 0 {
            thread::sleep(Duration::from_millis(100));
        }
        assert_eq!(worker.task_queue.to_vec().len(), 0);
        assert_eq!(worker.processing_queue.to_vec().len(), 1);

        // Push a task to the task_queue (a task that will fail)
        worker.task_queue.lpush(42);

        // Wait for the task to be processed, failed and put in the DLQ
        while worker.dlq.to_vec().len() == 0 {
            thread::sleep(Duration::from_millis(100));
        }
        assert_eq!(worker.task_queue.to_vec().len(), 0);
        assert_eq!(worker.processing_queue.to_vec().len(), 0);
        assert_eq!(worker.dlq.to_vec().len(), 1);
    }
}
