args = $(filter-out $@, $(MAKECMDGOALS))

bash:
	@docker-compose run --rm app bash

hello.world:
	@docker-compose run --rm app dart run tutorial/hello.dart

server:
	@docker-compose run \
		--rm \
		--name ds \
		--service-ports \
		app \
		dart run demo-server/bin/server.dart


%:
	@:
