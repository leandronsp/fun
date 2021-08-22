args = $(filter-out $@, $(MAKECMDGOALS))

bash:
	@docker-compose run --rm app bash

hello.world:
	@docker-compose run --rm app dart run tutorial/hello.dart

%:
	@:
