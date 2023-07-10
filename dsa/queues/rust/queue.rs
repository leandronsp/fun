fn enqueue(queue: &mut Vec<i32>, element: i32) {
    queue.push(element);
}

fn dequeue(queue: &mut Vec<i32>) -> Option<i32> {
    match queue.len() {
        0 => None,
        _ => Some(queue.remove(0))
    }
}

fn main() {
    let mut queue = Vec::new();

    enqueue(&mut queue, 1);
    enqueue(&mut queue, 2);
    enqueue(&mut queue, 3);

    while let Some(element) = dequeue(&mut queue) {
        println!("{}", element);
    }

    enqueue(&mut queue, 4);

    let element = dequeue(&mut queue).unwrap();
    println!("{}", element);
}
