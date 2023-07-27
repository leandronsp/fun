pub struct Node<T> {
    value: T,
    next: Option<Box<Node<T>>>,
}

pub struct SinglyLinkedList<T: PartialEq> {
    head: Option<Box<Node<T>>>,
}

impl<T: PartialEq> SinglyLinkedList<T> {
    pub fn new() -> Self {
        SinglyLinkedList { head: None }
    }

    pub fn prepend(&mut self, value: T) {
        let new_node = Node {
            value,
            next: self.head.take(),
        };

        self.head = Some(Box::new(new_node));
    }

    pub fn append(&mut self, value: T) {
        let new_node = Node {
            value,
            next: None,
        };

        let mut pointer = &mut self.head;

        while let Some(node) = pointer {
            pointer = &mut node.next;
        }

        *pointer = Some(Box::new(new_node));
    }

    pub fn remove(&mut self, value: T) {
        let mut pointer = &mut self.head;

        while let Some(ref mut node) = pointer {
            if node.value == value {
                *pointer = node.next.take();
                return;
            }

            pointer = &mut node.next;
        }
    }

    pub fn to_vec(&self) -> Vec<&T> {
        let mut result = Vec::new();
        let mut current = &self.head;

        while let Some(node) = current {
            result.push(&node.value);
            current = &node.next;
        }

        result
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
        assert_eq!(list.to_vec(), vec![&2, &1]);
    }

    #[test]
    fn test_append() {
        let mut list = SinglyLinkedList::new();

        list.append(1);
        list.append(2);
        assert_eq!(list.to_vec(), vec![&1, &2]);
    }

    #[test]
    fn test_prepend_and_append() {
        let mut list = SinglyLinkedList::new();

        list.prepend(1);
        list.append(2);
        assert_eq!(list.to_vec(), vec![&1, &2]);
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
        assert_eq!(list.to_vec(), vec![&1, &2, &4, &5]);
    }
}
