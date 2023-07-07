pub fn run() {
    #[derive(PartialEq, Debug)]
    struct Node<T> {
        value: T,
        left: Option<Box<Node<T>>>,
        right: Option<Box<Node<T>>>,
    }

    impl<T> Node<T> {
        fn new(value: T) -> Self {
            Self {
                value,
                left: None,
                right: None,
            }
        }

        fn add_left(mut self, node: Node<T>) -> Self {
            self.left = Some(Box::new(node));
            self
        }

        fn add_right(mut self, node: Node<T>) -> Self {
            self.right = Some(Box::new(node));
            self
        }
    }

    let tree = Node::new(42);

    assert_eq!(tree.value, 42);
    assert_eq!(tree.left, None);
    assert_eq!(tree.right, None);

    let tree = Node::new(1).add_left(Node::new(2)).add_right(Node::new(3));

    assert_eq!(tree.value, 1);
    assert_eq!(tree.left.unwrap().value, 2);
    assert_eq!(tree.right.unwrap().value, 3);
}
