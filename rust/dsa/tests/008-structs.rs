// Struct allows to package together and name multiple related values
// in a meaningful group
// - Similar to Tuples, they both hold multiple related values of different types
// - Unlike Tuples, Structs hold a meaningful name
#[cfg(test)]
mod tests {
    #[test]
    fn structs() {
        struct User {
            active: bool,
            name: String,
            score: u64
        }

        let user = User {
            active: true,
            name: String::from("Leandro"),
            score: 8
        };

        assert_eq!(user.name, "Leandro");
        assert_eq!(user.active, true);
        assert_eq!(user.score, 8);
    }

    #[test]
    fn tuple_structs() {
        struct Color(i32, i32, i32);
        let black = Color(0, 0, 0);

        assert_eq!(black.0, 0);
    }

    #[test]
    fn struct_methods() {
        // Methods are similar to functions, but
        // they are declared within the context of a Struct
        // Their first parameter is always `self`
        struct Account {
            name: String,
            balance: u32
        }

        impl Account {
            fn deposit(&mut self, amount: u32) {
                self.balance = self.balance + amount;
            }

            fn display(&self) -> String {
                format!("{}'s balance is {}", self.name, self.balance)
            }
        }

        let mut account_a = Account {
            name: "Leandro".to_string(),
            balance: 0
        };

        account_a.deposit(10);
        assert_eq!(account_a.display(), "Leandro's balance is 10");
    }

    #[test]
    fn associated_functions() {
        struct Account {
            name: String,
            balance: u32
        }

        impl Account {
            fn new(name: String, balance: u32) -> Self {
                Self {
                   name,
                   balance
                }
            }
        }

        let account_a = Account::new(
            "Leandro".to_string(),
            50
        );

        assert_eq!(account_a.name, "Leandro");
        assert_eq!(account_a.balance, 50);
    }
}
