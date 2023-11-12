fn main() {
    #[derive(Clone)]
    struct Node<T> {
        value: T,
        next: Option<Box<Node<T>>>,
        prev: Option<Box<Node<T>>>,
    }

    let mut tail = Box::new(Node { value: 2,  prev: None, next: None });
    let head = Box::new(Node { value: 1, prev: None, next: Some(tail.clone()) });
    tail.prev = Some(head.clone());

    assert_eq!(1, head.value);
    assert_eq!(2, head.next.unwrap().value);
    assert_eq!(1, tail.prev.unwrap().value);
}
