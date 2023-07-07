pub fn run() {
    struct Stack<T> {
        vec: Vec<T>
    }

    impl<T> Stack<T> {
        fn new() -> Self {
            Self { vec: Vec::new() }
        }

        fn push(&mut self, item: T) {
            self.vec.push(item)
        }

        fn pop(&mut self) -> Option<T> {
            self.vec.pop()
        }
    }

    let mut stack:Stack<i32> = Stack::new();

    stack.push(1);
    stack.push(2);
    stack.push(3);

    assert_eq!(stack.pop(), Some(3));
    assert_eq!(stack.pop().unwrap(), 2);
    assert_eq!(stack.pop(), Some(1));
    assert_eq!(stack.pop(), None);
}
