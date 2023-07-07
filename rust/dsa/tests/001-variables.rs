#[cfg(test)]
mod tests {
    #[test]
    fn variables_are_immutable_by_default() {
        let result = 42;
        assert_eq!(result, 42);

        // Raises an immutable error
        // result = 33;
    }

    #[test]
    fn variables_can_be_mutable() {
        let mut result = 42;
        assert_eq!(result, 42);

        result = 38;
        assert_eq!(result, 38);
    }

    #[test]
    fn constants_are_immutable_and_must_annotate_a_type() {
        const DISTANCE_IN_KM: u32 = 342;
        assert_eq!(DISTANCE_IN_KM, 342);
    }

    #[test]
    fn variables_can_annotate_a_type_too() {
        let result: u32 = 42;
        assert_eq!(result, 42);
    }

    #[test]
    fn variables_can_be_shadowed() {
        let result = 42;
        let result = result + 1;

        assert_eq!(result, 43);

        {
            let result = result + 1;
            assert_eq!(result, 44);
        }

        assert_eq!(result, 43);
    }

    #[test]
    fn variables_cannot_mutate_to_different_types() {
        let mut spaces = "   ";
        assert_eq!(spaces.len(), 3);

        spaces = " ";
        assert_eq!(spaces.len(), 1);

        // Raises mismatched type error
        // spaces = spaces.len();
    }

    #[test]
    fn variables_can_shadow_to_different_types() {
        let spaces = " ";
        let spaces = spaces.len();

        {
            let spaces = " ";
            assert_eq!(spaces, " ");
        }

        assert_eq!(spaces, 1);
    }
}
