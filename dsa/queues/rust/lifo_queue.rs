struct LIFOQueue<T> {
    stack: Vec<T>,
    amortized: Vec<T>
}

impl<T> LIFOQueue<T> {
    fn new() -> Self {
        Self { stack: Vec::new(), amortized: Vec::new() }
    }

    fn enqueue(&mut self, item: T) {
        self.stack.push(item)
    }

    fn dequeue(&mut self) -> Option<T> {
        if self.amortized.is_empty() {
            while let Some(item) = self.stack.pop() {
                self.amortized.push(item);
            }
        }
        self.amortized.pop()
    }
}

fn main() {
    let mut queue:LIFOQueue<i32> = LIFOQueue::new();

    queue.enqueue(1);
    queue.enqueue(2);
    queue.enqueue(3);

    while let Some(element) = queue.dequeue() {
        println!("{}", element);
    }
}
