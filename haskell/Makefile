hello:
	@docker-compose run app ghc -e 'putStrLn "hello world"'

bash:
	@docker-compose run app bash

repl:
	@docker-compose run app ghci

setup.tests:
	@docker-compose run app bash -c "cabal update && cabal install --lib HUnit"

run.tests:
	@docker-compose run app bash -c 'cabal install --lib HUnit && \
		echo "----Basic----" && ghci tests/tutorial/0-Basic.hs -e "runTestTT tests" && \
		echo "----Lists----" && ghci tests/tutorial/1-Lists.hs -e "runTestTT tests" && \
		echo "----Variables----" && ghci tests/tutorial/2-Variables.hs -e "runTestTT tests" && \
		echo "----Functions----" && ghci tests/tutorial/3-Functions.hs -e "runTestTT tests" && \
		echo "----PatternMatching----" && ghci tests/tutorial/4-PatternMatching.hs -e "runTestTT tests" && \
		echo "----Modules----" && ghci tests/tutorial/5-Modules.hs -e "runTestTT tests" && \
		echo "----Types----" && ghci tests/tutorial/6-Types.hs -e "runTestTT tests"'
