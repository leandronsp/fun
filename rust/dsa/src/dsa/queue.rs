pub fn run() {
    struct Queue<T> {
        vec: Vec<T>
    }

    impl<T> Queue<T> {
        fn new() -> Self {
            Self { vec: Vec::new() }
        }

        fn enqueue(&mut self, item: T) {
            self.vec.push(item)
        }

        fn dequeue(&mut self) -> Option<T> {
            match self.vec.len() {
                0 => None,
                _ => Some(self.vec.remove(0))
            }
        }
    }

    let mut queue:Queue<i32> = Queue::new();

    queue.enqueue(1);
    queue.enqueue(2);
    queue.enqueue(3);

    assert_eq!(queue.dequeue(), Some(1));
    assert_eq!(queue.dequeue().unwrap(), 2);
    assert_eq!(queue.dequeue(), Some(3));
    assert_eq!(queue.dequeue(), None);
}
