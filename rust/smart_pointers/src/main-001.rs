fn main() {
    copy_example();

    let name = String::from("Rust");
    print_name(&name);

    println!("Name Again: {}", name);

    let phrase = String::from("Hello");

    let phrase_ref = &phrase;
    let phrase_ref_mut = &mut &phrase;

    println!("Phrase: {}", phrase_ref);
    println!("Phrase: {}", phrase_ref_mut);
    println!("Phrase: {}", phrase);

    // Borrow Checker rules 
    // Multiple borrows (readings)
    // One mutable borrow (writing)

    // varias coisas
    println!("bye");
}

fn copy_example() {
    // Copy
    let result = [1, 2, 3, 4, 5];
    let copied = result;

    println!("Result {:?}", result);
    println!("Copied {:?}", copied);
}

fn print_name(name: &String) {
    println!("Name: {}", name);
} 
