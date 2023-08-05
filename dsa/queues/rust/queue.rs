struct Queue<T> {
    store: Vec<T>
}

impl<T> Queue<T> {
    fn new() -> Queue<T> {
        Queue { store: Vec::new() }
    }

    fn enqueue(&mut self, element: T) {
        self.store.push(element);
    }

    fn dequeue(&mut self) -> Option<T> {
        match self.store.len() {
            0 => None,
            _ => Some(self.store.remove(0))
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_queue() {
        let mut queue = Queue::new();

        queue.enqueue(1);
        queue.enqueue(2);
        queue.enqueue(3);

        assert_eq!(queue.dequeue(), Some(1));
        assert_eq!(queue.dequeue(), Some(2));
        assert_eq!(queue.dequeue(), Some(3));
        assert_eq!(queue.dequeue(), None);
    }
}
