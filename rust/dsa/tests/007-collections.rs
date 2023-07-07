// Collections hold multiple values
// Values are stored in the Heap
// Three main collection types: Vector, String and HashMap
//
#[cfg(test)]
mod tests {
    #[test]
    fn vectors() {
        // All elements must have the same type
        let mut scores:Vec<i32> = Vec::new();

        scores.push(1);
        scores.push(2);
        scores.push(3);

        let values = (scores[0], scores[1], scores[2]);
        assert_eq!((1, 2, 3), values);

        // Getting by reference
        let third:&i32 = &scores[2];
        assert_eq!(&3, third);

        // Create a vector with default values (with type inference)
        let mut scores = vec![1, 2, 3];
        scores.push(4);

        assert_eq!(scores.len(), 4);

        // Panics index out of bounds error
        //let _some = scores[100];

        // Using the `get` method does not panic
        assert_eq!(None, scores.get(100));
    }

    #[test]
    #[allow(unused_variables)]
    #[allow(unused_mut)]
    fn strings() {
        // Strings collection
        let mut greeting = String::from("hello");
        greeting.push_str(", world");

        assert_eq!(greeting, "hello, world");
        assert_eq!(greeting.len(), 12);

        // Raises an error
        // `String` cannot be indexed by `{integer}`
        // assert_eq!(greeting[0], 'h');

        // Iterating over Strings
        let greeting = String::from("hello");
        for c in greeting.chars() {
            println!("{}", c);
        }

        // String vs String literal
        let mut greeting = String::from("hello");
        let mut greeting_str = "hello";

        greeting.push_str(", world");

        // Raises an error
        // String literals are immutable
        //greeting_str.push_str(", world");

        // String literal is a slice of String
        let greeting_str = "hello";
        assert_eq!(5, str_len(&greeting_str));

        let greeting = String::from("hello");
        assert_eq!(5, str_len(&greeting));

        let slice_of_greeting = &greeting[..];
        assert_eq!(5, str_len(&slice_of_greeting));
    }

    #[test]
    fn hashmaps() {
        // HashMap is not included in the std::prelude
        // All keys must have the same type as each other
        // All values must have the same type as each other
        let mut scores = std::collections::HashMap::new();

        scores.insert("John", 8);
        scores.insert("Ana", 9);

        // `get` returns Option or None
        assert_eq!(scores.get("John").unwrap(), &8);

        scores.entry("Ana").or_insert(10);
        scores.entry("Rodrigo").or_insert(6);

        assert_eq!(scores.get("Ana").unwrap(), &9);
        assert_eq!(scores.get("Rodrigo").unwrap(), &6);
    }

    fn str_len(s: &str) -> usize {
        s.len()
    }
}
