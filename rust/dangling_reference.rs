fn dangling_reference() -> &'static str {
    let text = String::from("Hello");
    text.as_str()
}

fn main() {
    let value = dangling_reference();
    println!("{}", value);
}
