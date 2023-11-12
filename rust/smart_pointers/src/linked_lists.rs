fn main() {
    // 1. Singly Linked List (using Box)
    {
        println!("1. Singly Linked List (using Box)");
        struct Node<T> {
            value: T,
            next: Option<Box<Node<T>>>,
        }

        let mut head = Box::new(Node { value: 1, next: None });
        let tail = Box::new(Node { value: 2, next: None });
        
        println!("head: {:?}", head.value);
        println!("tail: {:?}", tail.value);

        head.next = Some(tail);
        println!("head.next: {:?}", head.next.unwrap().value);

        println!("======================================");
    }

    // 2. Singly Linked List (using Rc + RefCell)
    {
        println!("2. Singly Linked List (using Rc + RefCell)");
        use std::rc::Rc;
        use std::cell::RefCell;

        struct Node<T> {
            value: T,
            next: Option<Rc<RefCell<Node<T>>>>,
        }

        // Rc::new() creates a new reference-counted pointer
        // Rc only works with immutable values, that's why we need RefCell
        // RefCell is for interior mutability, mutating data that is immutable from the outside
        let head = Rc::new(RefCell::new(Node { value: 1, next: None }));
        let tail = Rc::new(RefCell::new(Node { value: 2, next: None }));
        
        // borrow() borrows a reference to the value inside the RefCell
        println!("head: {:?}", head.borrow().value);
        println!("tail: {:?}", tail.borrow().value);

        // borrow_mut() borrows a mutable reference to the value inside the RefCell
        head.borrow_mut().next = Some(tail.clone());

        // clone() creates a new reference to the same value, because the unwrap() method 
        // consumes the Option, taking ownership of its content
        let next_node = head.borrow().next.clone();
        println!("head.next: {:?}", next_node.unwrap().borrow().value);

        println!("======================================");
    }

    // 3. Doubly Linked List (using Rc + RefCell)
    {
        println!("3. Doubly Linked List (using Rc + RefCell)");
        use std::rc::Rc;
        use std::cell::RefCell;

        struct Node<T> {
            value: T,
            next: Option<Rc<RefCell<Node<T>>>>,
            prev: Option<Rc<RefCell<Node<T>>>>,
        }

        // Rc::new() creates a new reference-counted pointer
        // Rc only works with immutable values, that's why we need RefCell
        // RefCell is for interior mutability, mutating data that is immutable from the outside
        let head = Rc::new(RefCell::new(Node { value: 1, next: None, prev: None }));
        let tail = Rc::new(RefCell::new(Node { value: 2, next: None, prev: None }));
        
        // borrow() borrows a reference to the value inside the RefCell
        println!("head: {:?}", head.borrow().value);
        println!("tail: {:?}", tail.borrow().value);

        // borrow_mut() borrows a mutable reference to the value inside the RefCell
        head.borrow_mut().next = Some(tail.clone());
        tail.borrow_mut().prev = Some(head.clone());

        // clone() creates a new reference to the same value, because the unwrap() method 
        // consumes the Option, taking ownership of its content
        println!("head.next: {:?}", head.borrow().next.clone().unwrap().borrow().value);
        println!("tail.prev: {:?}", tail.borrow().prev.clone().unwrap().borrow().value);

        println!("======================================");
    }

    // 4. Circular Doubly Linked List (using Rc/Weak + RefCell)
    {
        println!("4. Circular Doubly Linked List (using Rc/Weak + RefCell)");
        use std::rc::Rc;
        use std::cell::RefCell;
        use std::rc::Weak;

        struct Node<T> {
            value: T,
            next: Option<Rc<RefCell<Node<T>>>>,
            prev: Option<Weak<RefCell<Node<T>>>>,
        }

        // Rc::new() creates a new reference-counted pointer
        // Rc only works with immutable values, that's why we need RefCell
        // RefCell is for interior mutability, mutating data that is immutable from the outside
        let head = Rc::new(RefCell::new(Node { value: 1, next: None, prev: None }));
        let tail = Rc::new(RefCell::new(Node { value: 2, next: None, prev: None }));
        
        // borrow() borrows a reference to the value inside the RefCell
        println!("head: {:?}", head.borrow().value);
        println!("tail: {:?}", tail.borrow().value);

        // borrow_mut() borrows a mutable reference to the value inside the RefCell
        head.borrow_mut().next = Some(tail.clone());
        tail.borrow_mut().prev = Some(Rc::downgrade(&head));
        // Cyclic reference
        tail.borrow_mut().next = Some(head.clone());

        // clone() creates a new reference to the same value, because the unwrap() method 
        // consumes the Option, taking ownership of its content
        println!("head.next: {:?}", head.borrow().next.clone().unwrap().borrow().value);
        println!("tail.prev: {:?}", tail.borrow().prev.clone().unwrap().upgrade().unwrap().borrow().value);
        println!("tail.next: {:?}", tail.borrow().next.clone().unwrap().borrow().value);

        println!("======================================");
    }
}
