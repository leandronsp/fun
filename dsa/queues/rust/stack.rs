fn push(stack: &mut Vec<i32>, element: i32) {
    stack.push(element);
}

fn pop(stack: &mut Vec<i32>) -> Option<i32> {
    stack.pop()
}

fn main() {
    let mut stack = Vec::new();

    push(&mut stack, 1);
    push(&mut stack, 2);
    push(&mut stack, 3);

    while let Some(element) = pop(&mut stack) {
        println!("{}", element);
    }

    push(&mut stack, 4);

    let element = pop(&mut stack).unwrap();
    println!("{}", element);
}
