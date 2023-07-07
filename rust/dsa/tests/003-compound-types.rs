#[cfg(test)]
mod tests {
    #[test]
    fn tuple_types() {
        let tup = (1, 2, 3);
        assert_eq!(tup, (1, 2, 3));

        // Can mix types
        let tup:(i32, f64, char) = (42, 4.12, 'A');
        assert_eq!(tup, (42, 4.12, 'A'));

        // Getting by reference
        let first:&i32 = &tup.0;
        assert_eq!(first, &42);

        // Pattern Matching destructuring
        let (a, b, c) = (1, 2, 'Y');
        assert_eq!(a, 1);
        assert_eq!(b, 2);
        assert_eq!(c, 'Y');

        let x = (1, 2, 3);
        let (a, b, c) = (x.0, x.1, x.2);
        assert_eq!(a, 1);
        assert_eq!(b, 2);
        assert_eq!(c, 3);
    }

    #[test]
    fn array_types() {
        let arr = [1, 2, 3];
        assert_eq!(arr, [1, 2, 3]);

        // Arrays do not mix types
        // Raises a mismatch type error
        //let arr = [1, 2, 'Z'];

        // An array of 5 elements
        let arr:[i32; 5] = [1, 2, 3, 4, 5];
        assert_eq!(arr, [1, 2, 3, 4, 5]);

        // Getting by reference
        let first:&i32 = &arr[1];
        assert_eq!(first, &2);

        let three_repeated = [3; 4];
        assert_eq!(three_repeated, [3, 3, 3, 3]);

        let arr = [1, 2, 3];
        assert_eq!(arr[0], 1);
        assert_eq!(arr[1], 2);
        assert_eq!(arr[2], 3);

        // Memory-safety in action!
        // Raises an index out of bounds error
        //let not_found = arr[3];
    }
}
