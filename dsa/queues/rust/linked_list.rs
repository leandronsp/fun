struct Node<T> {
    value: T,
    next: Option<Box<Node<T>>>
}

impl<T> Node<T> {
    fn new(value: T) -> Self {
        Self { value, next: None }
    }
}

struct LinkedList<T> {
    head: Option<Box<Node<T>>>
}

impl<T> LinkedList<T> {
    fn new() -> Self {
        Self { head: None }
    }

    fn add(&mut self, value: T) {
        let mut node = Box::new(Node::new(value));

        node.next = self.head.take();
        self.head = Some(node);
    }
}

fn main() {
    let mut list = LinkedList::new();

    list.add(1);
    list.add(2);
    list.add(3);

    let mut current = list.head;

    while let Some(node) = current {
        println!("{}", node.value);
        current = node.next;
    }
}
