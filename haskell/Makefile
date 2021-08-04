args = $(filter-out $@, $(MAKECMDGOALS))

hello.inline:
	@docker-compose run app stack ghc -- -e 'putStrLn "hello world inline"'

hello.fromhs:
	@docker-compose run app stack ghc -- app/Hello.hs -e 'main'

bash:
	@docker-compose run app bash

repl:
	@docker-compose run app stack repl

setup:
	@docker-compose run app bash -c 'stack setup'

setup.tests:
	@docker-compose run app bash -c 'stack setup && stack install HUnit'

run.tests:
	@docker-compose run app bash -c 'stack ghc --\
		tests/**/*.hs tests/Suite.hs -e "runTestTT Tests.Suite.tests"'

# Usage: make quicksort input="[2, 3, 1]"
quicksort:
	@[ "${input}" ] || ( echo ">> Missing input (input=\"[List]\")"; exit 1 )
	@docker-compose run app stack ghc -- \
		app/Quicksort.hs -e "quicksort ${input}"

%:
	@:
