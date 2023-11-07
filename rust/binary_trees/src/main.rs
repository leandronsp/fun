fn main() {
   use std::rc::Rc;
   use std::cell::RefCell;

   # [derive(Debug, PartialEq)]
   struct Node {
       value: i32,
       left: Option<Rc<RefCell<Node>>>,
       right: Option<Rc<RefCell<Node>>>,
   } 

   fn invert_tree_using_recursion(tree: Rc<RefCell<Node>>) -> Rc<RefCell<Node>> {
      let mut borrowed_tree = tree.borrow_mut();
      let temp_left = borrowed_tree.left.take();

      if let Some(thing) = borrowed_tree.right.take() {
         borrowed_tree.left = Some(invert_tree_using_recursion(thing))
      }

      if let Some(thing) = temp_left {
         borrowed_tree.right = Some(invert_tree_using_recursion(thing))
      }

      tree.clone()
   }

   fn invert_tree_using_stack(tree: Rc<RefCell<Node>>) {
      // LIFO
      let mut stack: Vec<Rc<RefCell<Node>>> = Vec::new();
      stack.push(tree.clone());

      while let Some(node) = stack.pop() { 
         let mut current_node = node.borrow_mut();

         let left = current_node.left.take();
         let right = current_node.right.take();

         current_node.left = right;
         current_node.right = left;

         if let Some(left) = &current_node.left {
            stack.push(left.clone());
         }

         if let Some(right) = &current_node.right {
            stack.push(right.clone());
         }
      }
   }

   fn build_tree() -> Rc<RefCell<Node>> {
      let tree = Rc::new(RefCell::new(Node { value: 1, left: None, right: None }));

      tree.borrow_mut().left = Some(Rc::new(RefCell::new(Node{ value: 2, left: None, right: None })));
      tree.borrow_mut().right = Some(Rc::new(RefCell::new(Node{ value: 3, left: None, right: None })));

      // tree.left.left
      tree.borrow_mut().left.clone().unwrap().borrow_mut().left = Some(Rc::new(RefCell::new(Node { value: 4, left: None, right: None })));

      // tree.right.right
      tree.borrow_mut().right.clone().unwrap().borrow_mut().right = Some(Rc::new(RefCell::new(Node { value: 5, left: None, right: None })));

      tree
   }

   let tree = build_tree();

   assert_eq!(1, tree.borrow().value);
   assert_eq!(2, tree.borrow().left.clone().unwrap().borrow().value);
   assert_eq!(3, tree.borrow().right.clone().unwrap().borrow().value);
   assert_eq!(4, tree.borrow().left.clone().unwrap().borrow().left.clone().unwrap().borrow().value);
   assert_eq!(5, tree.borrow().right.clone().unwrap().borrow().right.clone().unwrap().borrow().value);

   // Invert a binary tree
   //
   // At this moment, we have this tree
   // # Input:
   //       1
   //      / \
   //     2   3
   //    /     \
   //   4       5
   //
   // But we expect the following output
   // # Output:
   //       1
   //      / \
   //     3   2
   //    /     \
   //   5       4

   // Using stack
   let tree = build_tree();
   invert_tree_using_stack(tree.clone());

   assert_eq!(1, tree.borrow().value);
   assert_eq!(3, tree.borrow().left.clone().unwrap().borrow().value);
   assert_eq!(5, tree.borrow().left.clone().unwrap().borrow().left.clone().unwrap().borrow().value);
   assert_eq!(2, tree.borrow().right.clone().unwrap().borrow().value);
   assert_eq!(4, tree.borrow().right.clone().unwrap().borrow().right.clone().unwrap().borrow().value);

   // Using recursion
   let tree = build_tree();
   invert_tree_using_recursion(tree.clone());

   assert_eq!(1, tree.borrow().value);
   assert_eq!(3, tree.borrow().left.clone().unwrap().borrow().value);
   assert_eq!(5, tree.borrow().left.clone().unwrap().borrow().left.clone().unwrap().borrow().value);
   assert_eq!(2, tree.borrow().right.clone().unwrap().borrow().value);
   assert_eq!(4, tree.borrow().right.clone().unwrap().borrow().right.clone().unwrap().borrow().value);
}
