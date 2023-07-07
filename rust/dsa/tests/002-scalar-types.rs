#[cfg(test)]
mod tests {
    #[test]
    fn integer_types() {
        let age:u32 = 42;
        assert_eq!(age, 42);

        // Raises an error
        // Unsigned values cannot be negated
        // let balance:u32 = -42;

        let balance:i32 = -42; // default
        assert_eq!(balance, -42);
    }

    #[test]
    fn float_types() {
        let balance:f64 = 42.42; // default
        assert_eq!(balance, 42.42);

        let balance:f32 = -42.42;
        assert_eq!(balance, -42.42);
    }

    #[test]
    fn numeric_operations() {
        let sum = 5 + 10;
        assert_eq!(sum, 15);

        let difference = 42.4 - 4.3;
        assert_eq!(difference, 38.1);

        // default f64 uses double-precision
        let difference = 42.42 - 4.3;
        assert_eq!(difference, 38.120000000000005);

        // f32 uses single-precision
        let difference:f32 = 42.42 - 4.3;
        assert_eq!(difference, 38.12);
    }

    #[test]
    fn boolean_types() {
        let t = true;
        assert_eq!(t, true);

        let f:bool = false;
        assert_eq!(f, false);
    }

    #[test]
    fn char_types() {
        let c = 'c';
        assert_eq!(c, 'c');

        let z:char = 'Z';
        assert_eq!(z, 'Z');

        let heart_eyed_cat = '😻';
        assert_eq!(heart_eyed_cat, '😻');
    }
}
