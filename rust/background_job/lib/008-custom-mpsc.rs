use std::collections::VecDeque;

use std::sync::Arc;
use std::sync::Mutex;
use std::thread;

use std::sync::Condvar;

struct Channel<T> {
    store: Mutex<VecDeque<T>>,
    emitter: Condvar,
}

#[allow(dead_code)]
impl<T> Channel<T> {
    fn new() -> Channel<T> {
        Channel {
            store: Mutex::new(VecDeque::new()),
            emitter: Condvar::new(),
        }
    }

    fn send(&self, data: T) {
        self.store.lock().unwrap().push_back(data);
        self.emitter.notify_one();
    }

    fn recv(&self) -> Option<T> {
        let mut store = self.store.lock().unwrap();

        while store.is_empty() {
            store = self.emitter.wait(store).unwrap();
        }

        store.pop_front()
    }

    fn try_recv(&self) -> Option<T> {
        self.store.lock().unwrap().pop_front()
    }
}

fn main() {
    // Initialize channel
    let channel = Arc::new(Channel::new());

    // Push data to the channel
    channel.send("Some job to do: 1");
    channel.send("Another job: 2");

    let worker_channel = channel.clone();

    // Process the channel
    let worker = thread::spawn(move || {
        loop {
            let job = worker_channel.try_recv();

            match job {
                Some(job) => println!("Job: {}", job),
                None => break,
            }
        }
    });
    
    // Push more data to the channel
    channel.send("Yet another job");

    worker.join().unwrap();
}
