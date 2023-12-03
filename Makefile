golang.hello:
	@docker compose run --rm golang bash -c "go run hello.go"

rust.hello:
	@docker compose run --rm rust bash -c "rustc hello.rs && ./hello"

ruby.hello:
	@docker compose run --rm ruby bash -c "ruby hello.rb"

elixir.hello:
	@docker compose run --rm elixir bash -c "elixir hello.ex"

golang.bash:
	@docker compose run --rm golang bash

rust.bash:
	@docker compose run --rm rust bash

elixir.bash:
	@docker compose run --rm elixir bash

ruby.bash:
	@docker compose run --rm ruby bash

nodejs.bash:
	@docker compose run --rm nodejs bash
