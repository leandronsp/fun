use std::rc::Rc;
use std::rc::Weak;
use std::cell::RefCell;

#[derive(Debug)]
struct Node<T> {
    value: T,
    next: Option<Rc<RefCell<Node<T>>>>,
}

impl<T> Node<T> {
    fn new(value: T) -> Self {
       Self { value, next: None }
    }
}

#[derive(Debug)]
struct Queue<T> {
    head: Option<Rc<RefCell<Node<T>>>>,
    tail: Option<Rc<RefCell<Node<T>>>>,
}

impl<T> Queue<T> {
    fn new() -> Self {
        Self { head: None, tail: None }
    }

    fn push(&mut self, value: T) {
        let node = Rc::new(RefCell::new(Node::new(value)));

        match self.tail.take() {
            None => {
                self.head = Some(Rc::clone(&node));
            },
            Some(tail) => {
                tail.upgrade().unwrap().borrow_mut().next = Some(Rc::clone(&node));
            }
        }

        self.tail = Some(Rc::downgrade(&node));
    }

    fn pop(&mut self) -> Option<T> {
        match self.head.take() {
            None => None,
            Some(head) => {
                self.head = head.borrow_mut().next.take();

                match Rc::try_unwrap(head) {
                    Ok(head) => Some(head.into_inner().value),
                    Err(_) => None
                }
            },
        }
    }
}

fn main() {
    let mut queue = Queue::new();

    queue.push(1);
    queue.push(2);

    assert_eq!(queue.pop().unwrap(), 1);
    assert_eq!(queue.pop().unwrap(), 2);
    assert_eq!(queue.pop(), None);
}
