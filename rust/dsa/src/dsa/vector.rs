pub fn run() {
    let mut vec:Vec<i32> = Vec::new();

    vec.push(1);
    vec.push(2);
    vec.push(3);

    assert_eq!(vec.pop(), Some(3));
    assert_eq!(vec.pop().unwrap(), 2);
    assert_eq!(vec.pop(), Some(1));
    assert_eq!(vec.pop(), None);
}
