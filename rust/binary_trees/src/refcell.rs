fn main() {
   use std::cell::RefCell;

   // Rule for interior mutability
   // multiple borrows
   // OR
   // only ONE mutable borrow

   // panic!("already borrowed");
   // ONE borrow + ONE mutable borrow
   //let age = RefCell::new(Some(42));
   //let borrowed_age = age.borrow(); // <----- ONE BORROW

   //*age.borrow_mut() = None; // <------- ONE MUTABLE BORROW

   // Success
   // ONLY ONE mutable borrow
   let age = RefCell::new(Some(42));
   let mut borrowed_age = age.borrow_mut(); // <----- the only mutable borrow is HERE

   let value = borrowed_age.take(); // <------ takes ownership of borrowed value
   assert_eq!(42, value.unwrap());
}
