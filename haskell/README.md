# has-kell

My Haskell playground.

## Requirements

Docker.

### Setup
```
make setup
```

### Hello World
```
make hello.inline # hello world inline
make hello.fromhs # hello world using the `Hello.hs` file
```

### Running tests
```
make setup.tests
make run.tests
```

### Playing with REPL
```
make repl
```

### Quicksort?
```
make quicksort input="[2, 3, 1]" # [1, 2, 3]
make quicksort input="[8, 4, 2, 5]" # [2, 4, 5, 8]
```
