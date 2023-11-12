fn main() {
    use std::rc::{Weak, Rc};
    use std::cell::RefCell;

    struct Node<T> {
        value: T,
        next: Option<Rc<RefCell<Node<T>>>>,
    }

    impl<T> Node<T> {
        fn new(value: T) -> Self {
            Self { value, next: None }
        }
    }

    struct LinkedListQueue<T> {
        head: Option<Rc<RefCell<Node<T>>>>,
        tail: Option<Weak<RefCell<Node<T>>>>,
    }

    impl<T> LinkedListQueue<T> {
        fn new() -> Self {
            Self { head: None, tail: None }
        }

        fn enqueue(&mut self, value: T) {
            let node = Rc::new(RefCell::new(Node::new(value)));

            match self.tail.take() {
                Some(tail) => tail
                    .upgrade()
                    .unwrap()
                    .borrow_mut()
                    .next = Some(node.clone()),
                None => self.head = Some(node.clone()),
            }

            self.tail = Some(Rc::downgrade(&node));
        }

        fn dequeue(&mut self) -> Option<T> {
            match self.head.take() {
                Some(head) => {
                    self.head = head.borrow_mut().next.take();

                    match Rc::try_unwrap(head) {
                        Ok(head) => Some(head.into_inner().value),
                        Err(_) => None,
                    }
                },
                None => None,
            }
        }
    }

    let mut queue = LinkedListQueue::new();

    queue.enqueue(1);
    queue.enqueue(2);
    queue.enqueue(3);

    assert_eq!(queue.dequeue(), Some(1));
    assert_eq!(queue.dequeue(), Some(2));
    assert_eq!(queue.dequeue(), Some(3));
    assert_eq!(queue.dequeue(), None);
}
