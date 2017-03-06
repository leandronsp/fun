# Eulerglot

In this project I show problems at [Project Euler](https://projecteuler.net/archives) and solve them using different languages.

- Ruby
- Javascript
- Elixir
- Clojure  

### Running tests

#### Ruby
	bundle install
	bundle exec rspec spec/
	bundle exec guard (TDD!)

#### Elixir
	mix deps.get
	mix test
	mix test.watch (TDD!)
	
#### Clojure
	lein install
	lein test
	lein test-refresh (TDD!)

#### Javascript
	npm install
	npm test
