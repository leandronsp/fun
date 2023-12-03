fn main() {
    let _result = 5;
    let _result_infered: u32 = 42;
    let _my_bool: bool = true;
    let _my_char: char = 'a';
    let _my_float: f32 = 3.14;
    let my_string: &str = "Hello World!"; 
    let my_array: [i32; 5] = [1, 2, 3, 4, 5];
    let my_array = [1, 2, 3, 4, 5];
    let my_tuple: (i32, &str) = (1, "Hello World!");
    let my_typle = (1, 2, 3, "Leandro", 3.12, true);

    // fixed-sized
    // immutable
    // stack

    let mut my_mutable_string = String::from("Hello World!"); /// fixed-sized, mutable, heap
    my_mutable_string.push('!');

    let mut my_mutable_string = String::new(); // no fixed-sized, mutable, heap
    my_mutable_string.push_str("Leandro");

    let mut my_vector: Vec<i32> = Vec::new(); // no fixed-sized, mutable, heap
    my_vector.push(42);

    println!("Result: {}", my_mutable_string);
}
