use std::{collections::HashMap, fs};

pub fn run() {
    let grammar: HashMap<&str, i32> = [
        ("one", 1), ("two", 2), ("three", 3),
        ("four", 4), ("five", 5), ("six", 6),
        ("seven", 7), ("eight", 8), ("nine", 9),
        ("1", 1), ("2", 2), ("3", 3),
        ("4", 4), ("5", 5), ("6", 6),
        ("7", 7), ("8", 8), ("9", 9),
    ].iter().cloned().collect();

    let mut sum = 0;
    let data = fs::read_to_string("src/day001/input-1.txt").unwrap();

    data
        .lines()
        .for_each(|line| {
            println!("Line: {}", line);
            let numbers = extract_numbers(line);

            let first_number = grammar.get(&numbers[0][..]).unwrap();
            let last_number = grammar.get(&numbers[numbers.len() - 1][..]).unwrap();
            
            sum += first_number * 10 + last_number;
        });

    println!("Sum: {}", sum);
}

fn extract_numbers(input: &str) -> Vec<String> {
    let mut results = Vec::new();
    let mut buffer = String::new();
    let mut overlap = String::new();

    for char in input.chars() {
        if char.is_digit(10) {
            results.push(char.to_string());
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

    results
}

fn extract_number(buffer: &str) -> Option<String> {
    let re = regex::Regex::new(r"one|two|three|four|five|six|seven|eight|nine").unwrap();
    let mut results = Vec::new();

    for cap in re.captures_iter(buffer) {
        results.push(cap[0].to_string());
    }

    if results.len() == 1 {
        Some(results[0].clone())
    } else {
        None
    }
}
