use std::collections::VecDeque;

use std::sync::Arc;
use std::sync::Mutex;
use std::thread;

use std::sync::Condvar;

struct Transmitter<T> {
    store: Arc<Mutex<VecDeque<T>>>,
    emitter: Arc<Condvar>,
}

struct Receiver<T> {
    store: Arc<Mutex<VecDeque<T>>>,
    emitter: Arc<Condvar>,
}

struct Channel<T> {
    tx: Transmitter<T>,
    rx: Receiver<T>,
}

#[allow(dead_code)]
impl<T> Transmitter<T> {
    fn send(&self, data: T) {
        self.store.lock().unwrap().push_back(data);
        self.emitter.notify_one();
    }
}

#[allow(dead_code)]
impl<T> Receiver<T> {
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

#[allow(dead_code)]
impl<T> Channel<T> {
    fn new() -> Self {
        let store = Arc::new(Mutex::new(VecDeque::new()));
        let emitter = Arc::new(Condvar::new());

        Channel {
            tx: Transmitter { store: Arc::clone(&store), emitter: Arc::clone(&emitter) },
            rx: Receiver { store: Arc::clone(&store), emitter: Arc::clone(&emitter) },
        }
    }
}

fn main() {
    // Initialize channel
    let channel = Channel::new();
    let (tx, rx) = (channel.tx, channel.rx);

    // Push data to the channel
    tx.send("Some job to do: 1");
    tx.send("Another job: 2");

    // Process the channel
    let worker = thread::spawn(move || {
        loop {
            let job = rx.recv();

            match job {
                Some(job) => println!("Job: {}", job),
                None => break,
            }
        }
    });
    
    // Push more data to the channel
    tx.send("Yet another job");

    worker.join().unwrap();
}
