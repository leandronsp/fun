fn main() {
   use std::rc::Rc;
   use std::cell::RefCell;

   # [derive(Debug, PartialEq)]
   struct Node {
       value: i32,
       left: Option<Rc<RefCell<Node>>>,
       right: Option<Rc<RefCell<Node>>>,
   } 

   fn invert_tree(tree: Rc<RefCell<Node>>) -> Rc<RefCell<Node>> {
      let temp = tree.borrow().left.clone();

      if let Some(node) = tree.borrow().right.clone() {
         tree.borrow_mut().left = Some(node);
      }

      //let temp_inverted = invert_tree(temp.unwrap());
      //tree.borrow_mut().right = Some(temp_inverted);

      tree
   }

   // create tree
   let tree = Rc::new(RefCell::new(Node { value: 1, left: None, right: None }));
   assert_eq!(1, tree.borrow().value);
   assert_eq!(None, tree.borrow().left);
   assert_eq!(None, tree.borrow().right);

   // tree.left
   tree.borrow_mut().left = Some(Rc::new(RefCell::new(Node{ value: 2, left: None, right: None })));
   assert_eq!(2, tree.borrow().left.clone().unwrap().borrow().value);

   // tree.right
   tree.borrow_mut().right = Some(Rc::new(RefCell::new(Node{ value: 3, left: None, right: None })));
   assert_eq!(3, tree.borrow().right.clone().unwrap().borrow().value);

   // tree.left.left
   tree.borrow_mut().left.clone().unwrap().borrow_mut().left = Some(Rc::new(RefCell::new(Node { value: 4, left: None, right: None })));
   assert_eq!(4, tree.borrow().left.clone().unwrap().borrow().left.clone().unwrap().borrow().value);

   // tree.right.right
   tree.borrow_mut().right.clone().unwrap().borrow_mut().right = Some(Rc::new(RefCell::new(Node { value: 5, left: None, right: None })));
   assert_eq!(5, tree.borrow().right.clone().unwrap().borrow().right.clone().unwrap().borrow().value);

   // At this moment, we have this tree
   // # Input:
   //       1
   //      / \
   //     2   3
   //    /     \
   //   4       5

   assert_eq!(tree.clone(), invert_tree(tree.clone()));
}
