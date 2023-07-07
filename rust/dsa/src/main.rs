pub(crate) mod dsa;

fn main() {
    dsa::vector::run();
    dsa::stack::run();
    dsa::queue::run();
    dsa::binary_tree::run();
    dsa::linked_list_stack::run();

    println!("Done!");
}
