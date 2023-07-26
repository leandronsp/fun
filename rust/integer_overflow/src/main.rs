fn main() {
    wrapping_add();
    checked_add();
}

fn wrapping_add() {
    let max = std::u8::MAX; // 255
    let overflow = max.wrapping_add(1);
    println!("{}", overflow); // It will print 0
}

fn checked_add() {
    let max = std::u8::MAX; // 255
    let result = max.checked_add(1);
    match result {
        Some(val) => println!("{}", val),
        None => panic!("Overflow occurred!"),
    }
}
