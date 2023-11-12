fn main() {
    println!("This is a demonstration of ownership, borrowing and smart pointers in Rust.");

    // 1. Data on the stack (fixed size)
    {
        println!("Data on the stack (fixed size):");
        let age: i32 = 42;
        println!("Age: {}", age);

        // Transfer ownership: Copy
        let score: i32 = age;
        println!("[transfer ownership]: copy - `age` is still valid here! => {}", age);
        println!("Score: {}", score);
        println!("===============");

        assert_eq!(42, age); // age is still valid here
        assert_eq!(42, score); // score is still valid here
    }

    // 2. Data on the heap (dynamic size)
    {
        println!("Data on the heap (dynamic size):");
        let name: String = String::from("John");
        println!("Name: {}", name);
        assert_eq!("John", name);

        // Transfer ownership: Move
        let mut other_name: String = name;
        println!("[transfer ownership]: move - `name` is no longer valid here!");
        other_name.push_str(" Doe");
        println!("Other Name: {}", other_name);
        assert_eq!("John Doe", other_name);

        // Transfer ownership: Clone
        let cloned_name: String = other_name.clone();
        println!("[transfer ownership]: clone - `other_name` is still valid here! => {}", other_name);
        println!("Cloned Name: {}", cloned_name);
        assert_eq!("John Doe", cloned_name);
        assert_eq!("John Doe", other_name);

        println!("===============");
    }

    // 3. References & Borrowing
    {
        println!("References & Borrowing:");

        let name: String = String::from("John");

        // Borrowing
        let borrowed_name: &String = &name;
        println!("[borrowing]: `name` is still valid here! => {}", name);
        println!("Borrowed Name (reference): {}", borrowed_name);
        assert_eq!("John", borrowed_name);
        assert_eq!("John", name);

        // Mutable borrowing
        println!("Mutable borrowing:");
        let mut mutable_name: String = String::from("John");
        println!("Opening a new scope because we cannot have two mutable references to the same data in the same scope.");
        {
            let borrowed_name_mut: &mut String = &mut mutable_name;
            borrowed_name_mut.push_str(" Doe");
            println!("Borrowed Name (mutable reference): {}", borrowed_name_mut);
            assert_eq!("John Doe", borrowed_name_mut);
            assert_eq!("John Doe", *borrowed_name_mut); // Dereference
        }
        println!("[borrowing]: `mutable_name` is still valid here and has been mutated! => {}", mutable_name);
        assert_eq!("John Doe", mutable_name);

        println!("===============");
    }

    // 4. References & Lifetimes
    {
        println!("References & Lifetimes:");

        fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
            if x.len() > y.len() {
                x
            } else {
                y
            }
        }

        let phrase1: &str = "Hello";
        let phrase2: &str = "World!";

        let longest_phrase: &str = longest(phrase1, phrase2);

        println!("The longest phrase is: {}", longest_phrase);
        println!("===============");
    }

    // 5. Smart Pointers (Box)
    {
        println!("Smart Pointers (Box):");

        let age = Box::new(42);
        println!("Age: {}", age);
        assert_eq!(42, *age); // Dereference

        println!("Box transfers ownership (Move):");
        // Transfer ownership: Move
        let other_age = age;
        println!("[transfer ownership]: move - `age` is no longer valid here!");
        println!("Other Age: {}", other_age);

        println!("Box transfers ownership (Clone):");
        // Transfer ownership: Clone
        let age = Box::new(42);
        let cloned_age = Box::clone(&age);
        println!("[transfer ownership]: clone - `age` is still valid here! => {}", age);
        println!("Cloned Age: {}", cloned_age);

        println!("===============");
    }

    // 6. Smart Pointers (Rc + Weak)
    {
        println!("Smart Pointers (Rc + Weak):");
        use std::rc::Rc;

        let age = Rc::new(42);
        println!("Age: {}", age);
        println!("Strong Count: {}", Rc::strong_count(&age));

        println!("Rc shares ownership (Clone):");
        // Shared ownership: Rc::clone
        let age = Rc::new(42);
        let shared_age = Rc::clone(&age);
        println!("[shared ownership]: Rc::clone - `age` is still valid here! => {}", age);
        println!("Shared Age: {}", shared_age);
        println!("Strong Count: {}", Rc::strong_count(&age));

        // Downgrade (Weak)
        println!("Rc downgrades ownership (Weak):");
        let age = Rc::new(42);
        println!("Strong Count before downgrade: {}", Rc::strong_count(&age));
        println!("Weak Count before downgrade: {}", Rc::weak_count(&age));

        let weak_age = Rc::downgrade(&age);

        println!("Strong Count after downgrade: {}", Rc::strong_count(&age));
        println!("Weak Count after downgrade: {}", Rc::weak_count(&age));

        // Upgrade (Strong)
        println!("Rc upgrades ownership (Strong):");
        println!("Strong Count before upgrade: {}", Rc::strong_count(&age));
        println!("Weak Count before upgrade: {}", Rc::weak_count(&age));

        // Upgrade weak reference to strong reference (returns Option)
        // Unwrap is safe because we know the reference is still valid
        let strong_age = weak_age.upgrade().unwrap();
        println!("Strong Age: {}", strong_age);

        println!("Strong Count after upgrade: {}", Rc::strong_count(&age));
        println!("Weak Count after upgrade: {}", Rc::weak_count(&age));

        println!("===============");
    }

    // 7. Smart Pointers (RefCell)
    {
        println!("Smart Pointers (RefCell):");
        use std::cell::RefCell;
        let name = String::from("John");
        println!("Immutable Name: {}", name);
        let name_ref_cell = RefCell::new(name);
        name_ref_cell.borrow_mut().push_str(" Doe");
        println!("Immutable Name w/ RefCell after mutation: {}", name_ref_cell.borrow());
    }
}
