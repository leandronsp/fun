use std::rc::Rc;
use std::cell::RefCell;
use std::sync::Arc;

fn main() {
    smart_pointers();

    //make_big_data();
    //make_big_data_box();

    tree();
    tree_ref();
    tree_rc();
}

//fn make_big_data() -> [i32; 3_000_000] {
//    [0; 3_000_000]
//}
//
//fn make_big_data_box() -> Box<[i32; 3_000_000]> {
//    Box::new([0; 3_000_000])
//}

struct TreeNode<T> {
    value: T,
    children: Vec<TreeNode<T>>,
}

fn tree() {
    let leaf1 = TreeNode { value: "leaf1", children: vec![] };
    let leaf2 = TreeNode { value: "leaf2", children: vec![] };

    let _root = TreeNode { value: "root", children: vec![leaf1, leaf2] };

    // This will not compile due to ownership rules:
    //let _other_parent = TreeNode { value: "other_parent", children: vec![leaf1] };
}

struct TreeNodeRef<'a, T> {
    value: T,
    parent: Option<&'a TreeNodeRef<'a, T>>,
    children: Vec<&'a TreeNodeRef<'a, T>>,
}

fn tree_ref() {
    let mut leaf1 = TreeNodeRef { value: "leaf1", parent: None, children: vec![] };
    let mut leaf2 = TreeNodeRef { value: "leaf2", parent: None, children: vec![] };

    let _root = TreeNodeRef { value: "root", parent: None, children: vec![&leaf1, &leaf2] };
    let _other_parent = TreeNodeRef { value: "other_parent", parent: None, children: vec![&leaf1] };

    // This will not compile due to multiple mutable borrows:
    //leaf1.parent = Some(&root);
    //leaf2.parent = Some(&root);
    //leaf1.parent = Some(&other_parent);
}

struct TreeNodeRc<T> {
    value: T,
    children: Vec<Rc<TreeNodeRc<T>>>,
}

fn tree_rc() {
    let leaf1 = Rc::new(TreeNodeRc { value: "leaf1", children: vec![] });
    let leaf2 = Rc::new(TreeNodeRc { value: "leaf2", children: vec![] });
    let _root = Rc::new(TreeNodeRc { value: "root", children: vec![leaf1.clone(), leaf2.clone()] });
    let _other_parent = Rc::new(TreeNodeRc { value: "other_parent", children: vec![leaf1.clone()] });
}


fn smart_pointers() {
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
    //println!("x = {}", x.borrow());

    // Weak Rc
    let five = Rc::new(5);
    let weak_five = Rc::downgrade(&five);
    println!("weak_five = {:?}", weak_five.upgrade());

    // Arc
    let five = Arc::new(5);
    let shared_five = Arc::clone(&five);
    println!("five = {}, shared_five = {}", five, shared_five);
}
