args = $(filter-out $@, $(MAKECMDGOALS))

hello.inline:
	@docker-compose run --rm app stack ghc -- -e 'print "hello world inline"'

hello.fromhs:
	@docker-compose run --rm app stack ghc -- app/Hello.hs -e 'main'

bash:
	@docker-compose run --rm app bash

repl:
	@docker-compose run --rm app stack repl

setup:
	@docker-compose run --rm app bash -c 'stack setup && stack build'

run.tests:
	@docker-compose run --rm app bash -c 'stack ghc --\
		tests/**/*.hs tests/Suite.hs -e "runTestTT Tests.Suite.tests"'

# Usage: make quicksort input="[2, 3, 1]"
quicksort:
	@[ "${input}" ] || ( echo ">> Missing input (input=\"[List]\")"; exit 1 )
	@docker-compose run --rm app stack ghc -- \
		app/Quicksort.hs -e "quicksort ${input}"

%:
	@:
