use std::fs;

pub fn run() {
    let mut sum = 0;
    
    fs::read_to_string("src/day001/input-1.txt")
        .unwrap()
        .lines()
        .for_each(|line| {
            println!("Line: {}", line);
            let mut first_digit = 0;
            let mut last_digit = first_digit;

            line
                .chars()
                .for_each(|char| {
                    if char.is_digit(10) {
                        last_digit = char.to_digit(10).unwrap();

                        if first_digit == 0 {
                            first_digit = last_digit;
                        }
                    } 
                });

            let two_digits = first_digit * 10 + last_digit;
            sum += two_digits;
        });

    println!("Sum: {}", sum);
}
