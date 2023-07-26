struct Node<T> {
    value: Option<T>,
    next: Option<usize>,
}

impl<T> Node<T> {
    fn new(value: T) -> Self {
        Self { value: Some(value), next: None }
    }
}

struct LinkedListQueue<T> {
    pool: Vec<Node<T>>,
    head: Option<usize>,
    tail: Option<usize>,
}

impl<T> LinkedListQueue<T> {
    fn new() -> Self {
        Self { pool: vec![], head: None, tail: None }
    }

    fn enqueue(&mut self, value: T) {
        let node = Node::new(value);
        let idx = self.pool.len();

        self.pool.push(node);

        match self.tail {
            Some(tail) => {
                self.pool[tail].next = Some(idx);
            },
            None => self.head = Some(idx),
        }

        self.tail = Some(idx);
    }

    fn dequeue(&mut self) -> Option<T> {
        match self.head.take() {
            Some(head) => {
                self.head = self.pool[head].next;

                if let None = self.head {
                    self.tail = None;
                }

                self.pool[head].value.take()
            },
            None => None,
        }
    }
}

fn main() {
    let mut queue = LinkedListQueue::new();

    queue.enqueue(1);
    queue.enqueue(2);
    queue.enqueue(3);

    while let Some(element) = queue.dequeue() {
        println!("{}", element);
    }
}
