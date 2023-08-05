struct Deque<T> {
    store: Vec<T>
}

impl<T> Deque<T> {
    fn new() -> Deque<T> {
        Deque { store: Vec::new() }
    }

    fn rpush(&mut self, element: T) {
        self.store.push(element);
    }

    fn lpush(&mut self, element: T) {
        self.store.insert(0, element);
    }

    fn rpop(&mut self) -> Option<T> {
        match self.store.len() {
            0 => None,
            _ => Some(self.store.pop().unwrap())
        }
    }

    fn lpop(&mut self) -> Option<T> {
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
    fn test_deque() {
        let mut deque = Deque::new();

        deque.rpush(1);
        deque.rpush(2);
        deque.rpush(3);

        assert_eq!(deque.rpop(), Some(3));
        assert_eq!(deque.rpop(), Some(2));
        assert_eq!(deque.rpop(), Some(1));
        assert_eq!(deque.rpop(), None);

        deque.lpush(1);
        deque.lpush(2);
        deque.lpush(3);

        assert_eq!(deque.lpop(), Some(3));
        assert_eq!(deque.lpop(), Some(2));
        assert_eq!(deque.lpop(), Some(1));
        assert_eq!(deque.lpop(), None);
    }
}
