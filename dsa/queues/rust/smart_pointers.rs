use std::rc::Rc;
use std::cell::RefCell;
use std::sync::Arc;

fn main() {
    // Box
    let b = Box::new(42);
    println!("b = {}", b);

    // Rc
    let original = Rc::new(42);
    let clone = Rc::clone(&original);
    println!("original = {}, clone = {}", original, clone);

    // RefCell
    let x = RefCell::new(42);
    let mut y = x.borrow_mut();
    *y = 13;
    println!("y = {}", y);
    // This will panic:
    //println!("x = {}", *x.borrow());

    // Weak Rc
    let five = Rc::new(5);
    let weak_five = Rc::downgrade(&five);
    println!("weak_five = {:?}", weak_five.upgrade());

    // Arc
    let five = Arc::new(5);
    let shared_five = Arc::clone(&five);
    println!("five = {}, shared_five = {}", five, shared_five);

    let cell = RefCell::new(5);

    // Use `borrow` to get a reference to the data.
    // Multiple immutable borrows are allowed.
    let x = *cell.borrow();
    println!("x = {}", x);

    // Use `borrow_mut` to get a mutable reference to the data.
    // Only one mutable borrow is allowed at a time.
    *cell.borrow_mut() += 1;

    // If we try to borrow again while a mutable reference exists, it will cause a panic!
    // Uncomment the next line to see this.
    // let y = *cell.borrow();

    // Use `into_inner` to consume the RefCell and get the inner value.
    // No borrows must exist at this time.
    let inner = cell.into_inner();
    println!("inner = {}", inner);

    let cell = RefCell::new(5);
    *cell.borrow_mut() = 7;
    println!("{}", *cell.borrow()); // prints 7

}
