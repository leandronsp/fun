#[cfg(test)]
mod tests {
    #[test]
    fn if_expressions() {
        let balance = 42;

        if balance > 42 {
            println!("Yo");
        }

        // Inline IF
        // Because IF's are expressions and return value
        let yay = if balance > 40 { "Yay" } else { "yoy" };
        assert_eq!(yay, "Yay");
    }

    #[test]
    fn loops() {
        // Loop
        let mut counter = 0;
        loop {
            counter = counter + 1;
            if counter == 3 { break; };
        }

        // For
        let numbers = [1, 2, 3];
        for n in numbers {
            println!("{}", n);
        }
    }
}
