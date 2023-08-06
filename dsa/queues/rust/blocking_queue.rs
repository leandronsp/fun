use std::sync::{Arc, Mutex};
use std::sync::Condvar;

struct BlockingQueue<T> {
    store: Mutex<Vec<T>>,
    emitter: Condvar,
}

impl<T> BlockingQueue<T> {
    fn new() -> BlockingQueue<T> {
        BlockingQueue {
            store: Mutex::new(Vec::new()),
            emitter: Condvar::new(),
        }
    }

    fn enqueue(&self, t: T) {
        self.store.lock().unwrap().push(t);
        self.emitter.notify_one();
    }

    fn dequeue(&self) -> Option<T> {
        let mut store = self.store.lock().unwrap();

        while store.is_empty() {
            store = self.emitter.wait(store).unwrap();
        }

        Some(store.remove(0))
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_blocking_queue() {
        let queue = Arc::new(BlockingQueue::new());

        {
            queue.enqueue(1);
            queue.enqueue(2);

            assert_eq!(queue.dequeue(), Some(1));
            assert_eq!(queue.dequeue(), Some(2));
        }

        let thread_queue = queue.clone();

        let handle = std::thread::spawn(move || {
            let task = thread_queue.dequeue();
            assert_eq!(task, Some(3));
        });

        {
            queue.enqueue(3);
        }

        handle.join().unwrap();
    }
}
