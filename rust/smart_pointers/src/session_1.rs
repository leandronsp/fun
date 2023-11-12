fn main() {
    #[derive(Clone)]
    struct Node<'a, T: 'a> {
        value: T,
        next: Option<&'a Node<'a, T>>,
        prev: Option<&'a Node<'a, T>>,
    }

    let tail = Box::new(Node { value: 2, prev: None, next: None });
    let head = Box::new(Node { value: 1, prev: None, next: Some(&tail) });

    tail.prev = Some(&head);

    assert_eq!(1, head.value);
    assert_eq!(2, head.next.unwrap().value);
    assert_eq!(1, tail.prev.unwrap().value);
}
