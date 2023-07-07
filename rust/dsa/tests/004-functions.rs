#[cfg(test)]
mod tests {
    #[test]
    fn functions_test() {
        fn print_calc() {
           println!("{}", 10 + 32);
        }

        print_calc();

        fn sum(x:i32, y:i32) -> i32 {
            return x + y;
        }

        assert_eq!(sum(41, 1), 42);
    }

    #[test]
    fn statements_vs_expressions() {
        // Statement does not return value
        let balance = 42;

        fn get_balance() -> i32 {
            42
        }

        // Expressions return value
        get_balance();

        // Expressions return value
        { 1 + 1 };

        assert_eq!(balance, 42);
    }
}
