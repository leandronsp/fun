use std::rc::Rc;
use std::cell::RefCell;

pub struct Node<T> {
    value: T,
    next: Option<Rc<RefCell<Node<T>>>>
}

impl<T> Node<T> {
    fn new(value: T) -> Self {
        Self { value: value, next: None }
    }
}

pub struct SinglyLinkedList<T> {
    head: Option<Rc<RefCell<Node<T>>>>
}

impl<T> SinglyLinkedList<T> {
    pub fn new() -> Self {
        SinglyLinkedList { head: None }
    }

    pub fn prepend(&mut self, value: T) {
        let node = Rc::new(RefCell::new(Node::new(value)));

        match &self.head {
            Some(head_ref) => {
                node.borrow_mut().next = Some(head_ref.clone());
            },
            None => self.head = Some(node.clone())
        }

        self.head = Some(node);
    }

    pub fn append(&mut self, value: T) {
        let node = Rc::new(RefCell::new(Node::new(value)));

        match &self.head {
            Some(head_ref) => {
                let mut pointer = head_ref.clone();

                while let Some(node) = &pointer.clone().borrow().next {
                    pointer = node.clone();
                }

                pointer.borrow_mut().next = Some(node);
            },
            None => {
                self.head = Some(node);
            }
        }
    }

    pub fn remove(&mut self, value: T) where T: PartialEq + Clone + std::fmt::Display {
        let mut pointer = self.head.clone();
        let mut previous: Option<Rc<RefCell<Node<T>>>> = None;

        while let Some(node) = pointer {
            if node.borrow().value == value {
                match previous {
                    Some(prev_node) => {
                        prev_node.borrow_mut().next = node.borrow().next.clone();
                    }
                    None => {
                        self.head = node.borrow().next.clone();
                    }
                }

                return;
            }

            previous = Some(node.clone());
            pointer = node.borrow().next.clone();
        }
    }

    pub fn to_vec(&self) -> Vec<T> where T: Clone {
        let mut vec = Vec::new();

        let mut pointer = self.head.clone();

        while let Some(node) = pointer {
            vec.push(node.borrow().value.clone());
            pointer = node.borrow().next.clone();
        }

        vec
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_prepend() {
        let mut list = SinglyLinkedList::new();

        list.prepend(1);
        list.prepend(2);
        assert_eq!(list.to_vec(), vec![2, 1]);
    }

    #[test]
    fn test_append() {
        let mut list = SinglyLinkedList::new();

        list.append(1);
        list.append(2);
        assert_eq!(list.to_vec(), vec![1, 2]);
    }

    #[test]
    fn test_prepend_and_append() {
        let mut list = SinglyLinkedList::new();

        list.prepend(1);
        list.append(2);
        assert_eq!(list.to_vec(), vec![1, 2]);
    }

    #[test]
    fn test_remove() {
        let mut list = SinglyLinkedList::new();

        list.append(1);
        list.append(2);
        list.append(3);
        list.append(4);
        list.append(5);

        list.remove(3);
        assert_eq!(list.to_vec(), vec![1, 2, 4, 5]);

        list.remove(1);
        assert_eq!(list.to_vec(), vec![2, 4, 5]);
    }
}
