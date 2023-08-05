use std::rc::Rc;
use std::cell::RefCell;

struct Node<T> {
    value: T,
    next: Option<Rc<RefCell<Node<T>>>>,
    previous: Option<Rc<RefCell<Node<T>>>>,
}

impl<T> Node<T> {
    fn new(value: T) -> Node<T> {
        Node { value, next: None, previous: None, }
    }
}

struct LinkedListDeque<T> {
    head: Option<Rc<RefCell<Node<T>>>>,
    tail: Option<Rc<RefCell<Node<T>>>>,
}

impl<T> LinkedListDeque<T> {
    fn new() -> LinkedListDeque<T> {
        LinkedListDeque { head: None, tail: None }
    }

    fn lpush(&mut self, value: T) {
        let node = Rc::new(RefCell::new(Node::new(value)));

        match &self.head {
            Some(head_ref) => {
                node.borrow_mut().next = Some(head_ref.clone());
                head_ref.borrow_mut().previous = Some(node.clone());
                self.head = Some(node.clone());
            },
            None => {
                self.head = Some(node.clone());
                self.tail = Some(node.clone());
            }
        }
    }

    fn rpush(&mut self, value: T) {
        let node = Rc::new(RefCell::new(Node::new(value)));

        match &self.tail {
            Some(tail_ref) => {
                node.borrow_mut().previous = Some(tail_ref.clone());
                tail_ref.borrow_mut().next = Some(node.clone());
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
                let value = head_ref.borrow().value.clone();
                let next_ref = head_ref.borrow().next.clone();

                match &next_ref {
                    Some(next_ref) => {
                        next_ref.borrow_mut().previous = None;
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
                let value = tail_ref.borrow().value.clone();
                let previous_ref = tail_ref.borrow().previous.clone();

                match &previous_ref {
                    Some(previous_ref) => {
                        previous_ref.borrow_mut().next = None;
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

    fn to_vec(&self) -> Vec<T> where T: Clone {
        let mut vec = Vec::new();
        let mut current = self.head.clone();

        while let Some(node) = current {
            vec.push(node.borrow().value.clone());
            current = node.borrow().next.clone();
        }

        vec
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_linked_list_deque() {
        let mut deque = LinkedListDeque::new();

        deque.rpush(1);
        deque.rpush(2);
        deque.rpush(3);

        assert_eq!(deque.to_vec(), vec![1, 2, 3]);

        assert_eq!(deque.rpop(), Some(3));
        assert_eq!(deque.rpop(), Some(2));
        assert_eq!(deque.rpop(), Some(1));
        assert_eq!(deque.rpop(), None);

        deque.lpush(1);
        deque.lpush(2);
        deque.lpush(3);

        assert_eq!(deque.to_vec(), vec![3, 2, 1]);

        assert_eq!(deque.lpop(), Some(3));
        assert_eq!(deque.lpop(), Some(2));
        assert_eq!(deque.lpop(), Some(1));
        assert_eq!(deque.lpop(), None);
    }
}

