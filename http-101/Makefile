bash:
	@docker-compose run app bash

bundle:
	@docker-compose run app bundle

stream.server:
	@docker-compose run \
		--rm \
		app \
		bash -c "ruby stream/server.rb"

stream.client:
	@docker-compose run \
		--rm \
		app \
		bash -c "ruby stream/client.rb"

tcp.server:
	@docker-compose run \
		--rm \
		--service-ports \
		app \
		bash -c "ruby tcp/server.rb"

tcp.client:
	@echo 'Hello Server!' | nc localhost 3000

http.counter-app:
	@docker-compose run \
		--rm \
		--service-ports \
		app \
		bash -c "ruby http/counter-app/server.rb"

http.geonames:
	@docker-compose run \
		--rm \
		--name geonames \
		--service-ports \
		app \
		bash -c "ruby http/geonames/server.rb"

join.network:
	@docker network create ${network} || true
	@docker network connect ${network} ${container}
