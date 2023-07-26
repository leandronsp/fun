struct Node<T> {
    value: T,
    next: Option<Box<Node<T>>>
}

impl<T> Node<T> {
    fn new(value: T) -> Self {
        Self { value, next: None }
    }
}

fn main() {
    let mut node:Node<i32> = Node::new(1);

    node.next = Some(Box::new(Node::new(2)));
    node.next.as_mut().unwrap().next = Some(Box::new(Node::new(3)));

    let mut current = Some(&node);

    while let Some(current_node) = current {
        println!("{}", current_node.value);
        current = current_node.next.as_deref();
    }
}
