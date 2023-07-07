pub fn run() {
    struct Stack<T> {
        head: LinkedList<T>,
    }

    type LinkedList<T> = Option<Box<Node<T>>>;

    struct Node<T> {
        elem: T,
        next: LinkedList<T>,
    }

    impl<T> Stack<T> {
        pub fn new() -> Self {
            Stack { head: None }
        }

        pub fn push(&mut self, elem: T) {
            let new_node = Box::new(Node {
                elem: elem,
                next: self.head.take(),
            });

            self.head = Some(new_node);
        }

        pub fn pop(&mut self) -> Option<T> {
            self.head.take().map(|node| {
                self.head = node.next;
                node.elem
            })
        }

        pub fn peek(&self) -> Option<&T> {
            self.head.as_ref().map(|node| &node.elem)
        }

        pub fn peek_mut(&mut self) -> Option<&mut T> {
            self.head.as_mut().map(|node| &mut node.elem)
        }
    }

    impl<T> Drop for Stack<T> {
        fn drop(&mut self) {
            let mut cur_link = self.head.take();
            while let Some(mut boxed_node) = cur_link {
                cur_link = boxed_node.next.take();
            }
        }
    }

    let mut stack = Stack::new();

    assert_eq!(stack.pop(), None);

    stack.push(1);
    stack.push(2);
    stack.push(3);

    assert_eq!(stack.pop(), Some(3));
    assert_eq!(stack.pop(), Some(2));

    stack.push(4);
    stack.push(5);

    assert_eq!(stack.pop(), Some(5));
    assert_eq!(stack.pop(), Some(4));
    assert_eq!(stack.pop(), Some(1));

    assert_eq!(stack.pop(), None);

    let mut stack = Stack::new();

    assert_eq!(stack.peek(), None);
    assert_eq!(stack.peek_mut(), None);

    stack.push(1);
    stack.push(2);
    stack.push(3);

    assert_eq!(stack.peek(), Some(&3));
    assert_eq!(stack.peek_mut(), Some(&mut 3));

    stack.peek_mut().map(|value| *value = 42);

    assert_eq!(stack.peek(), Some(&42));
    assert_eq!(stack.pop(), Some(42));
}
