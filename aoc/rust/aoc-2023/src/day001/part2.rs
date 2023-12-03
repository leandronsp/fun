use std::{collections::HashMap, fs};

pub fn run() {
    let mut sum = 0;
    let data = fs::read_to_string("src/day001/input-1.txt").unwrap();

    data
        .lines()
        .for_each(|line| {
            println!("Line: {}", line);
            let (first_number, last_number) = extract_numbers(line);
            
            sum += first_number * 10 + last_number;
        });

    println!("Sum: {}", sum);

    // Some Tests
    {
        let input = "seven8sevenptdlvvgssixvjvzpvsp7fivefourtwoned";
        let (first_number, last_number) = extract_numbers(input);
        assert_eq!(first_number, 7);
        assert_eq!(last_number, 1);

        let input = "4nineeightseven2";
        let (first_number, last_number) = extract_numbers(input);
        assert_eq!(first_number, 4);
        assert_eq!(last_number, 2);
    }
}

fn extract_numbers(input: &str) -> (i32, i32) {
    let mut results = Vec::new();
    let mut buffer = String::new();
    let mut overlap = String::new();

    for char in input.chars() {
        if char.is_digit(10) {
            results.push(char.to_digit(10).unwrap() as i32);
            buffer.clear();
            overlap.clear();
        } else {
            buffer.push(char);
            overlap.push(char);

            if let Some(found) = extract_number(&buffer) {
                results.push(found);
                buffer.clear();
                overlap = String::from(char);
            }

            if let Some(found) = extract_number(&overlap) {
                results.push(found);
                buffer.clear();
                overlap.clear();
            }
        }
    }

    (results[0], results[results.len() - 1])
}

fn extract_number(buffer: &str) -> Option<i32> {
    let grammar: HashMap<&str, i32> = [
        ("one", 1), ("two", 2), ("three", 3),
        ("four", 4), ("five", 5), ("six", 6),
        ("seven", 7), ("eight", 8), ("nine", 9),
        ("1", 1), ("2", 2), ("3", 3),
        ("4", 4), ("5", 5), ("6", 6),
        ("7", 7), ("8", 8), ("9", 9),
    ].iter().cloned().collect();

    let mut results = Vec::new();

    for (key, value) in grammar.iter() {
        if buffer.contains(key) {
            results.push(value);
        }
    }

    if results.len() == 1 {
        Some(results[0].clone())
    } else {
        None
    }
}
