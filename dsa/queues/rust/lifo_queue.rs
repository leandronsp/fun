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

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_lifo_queue() {
        let mut queue = LIFOQueue::new();

        queue.enqueue(1);
        queue.enqueue(2);
        queue.enqueue(3);

        assert_eq!(queue.dequeue(), Some(1));
        assert_eq!(queue.dequeue(), Some(2));
        assert_eq!(queue.dequeue(), Some(3));
        assert_eq!(queue.dequeue(), None);
    }
}
