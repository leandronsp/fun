#[cfg(test)]
mod tests {
    #[test]
    fn ownership() {
        // String literal (fixed-size)
        {
            let greeting = "hello";
            assert_eq!(greeting, "hello");
        }

        // Not found in this scope
        //assert_eq!(&greeting, None);

        // String type (dynamic-size)
        {
            let mut greeting = String::from("hello");
            greeting.push_str(", world");

            assert_eq!(greeting, "hello, world");
        }

        // Not found in this scope
        //assert_eq!(&greeting, None);

        //Copy
        {
            let x = 5;
            let y = x;

            assert_eq!(y, 5);
            assert_eq!(x, 5);
        }

        // Move
        {
            let g1 = String::from("hello");
            let g2 = g1;

            assert_eq!(g2, "hello");
            // Raises error
            // Value borrowed here after move
            //assert_eq!(g1, "hello");

            let g3 = String::from("helloo");

            let (s2, len) = calculate_length(g3);
            assert_eq!(s2, "helloo");
            assert_eq!(len, 6);

            // Raises error
            // Value borrowed here after move
            //assert_eq!(g3, "helloo");

            // Reference
            let g4 = String::from("hello");
            let len = calculate_length_by_reference(&g4);
            assert_eq!(g4, "hello");
            assert_eq!(len, 5);

            // Referências são imutáveis no borrowing
            let _g5 = String::from("hello");
            // Raises an error
            // the data it refers to cannot be borrowed as mutable
            //change(&g5);

            // Mutate references require the mut statement
            let mut g6 = String::from("hello");
            change(&mut g6);
            assert_eq!(&g6, "hello, world");
            assert_eq!(&g6, "hello, world");

            let mut g7 = String::from("hello");
            let _r1 = &mut g7;
            let _r2 = &mut g7;

            // Raises an error
            // cannot borrow `g7` as mutable more than once at a time
            //assert_eq!(r1, "hello");
            //assert_eq!(r2, "hello");

            // Multiple usage of mutable reference is allowed
            // across different scopes
            let mut g7 = String::from("hello");
            {
                let r1 = &mut g7;
                assert_eq!(r1, "hello");
            }

            let r2 = &mut g7;
            assert_eq!(r2, "hello");
        }

        // String Slices
        let greeting = String::from("hello, world");
        let word = slice(&greeting);
        assert_eq!(word, "hello");
        assert_eq!(greeting, "hello, world");

        // Array Slices
        let array = [1, 2, 3, 4, 5];
        let first_three = &array[0..3];
        assert_eq!(first_three, [1, 2, 3]);
    }

    fn slice(s: &String) -> &str {
        &s[0..5]
    }

    fn change(s: &mut String) {
        s.push_str(", world");
    }

    // Raises an error
    // the data it refers to cannot be borrowed as mutable
    //fn change(s: &String) {
    //    s.push_str(", world");
    //}

    fn calculate_length_by_reference(s: &String) -> usize {
        s.len()
    }

    fn calculate_length(s: String) -> (String, usize) {
        // Raises error
        // Value borrowed here after move
        //(s, s.len())

       let length = s.len();
       (s, length)
    }
}
