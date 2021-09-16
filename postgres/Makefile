bash:
	@docker-compose run db bash

up:
	@docker-compose run \
		--name pgdb \
		--rm \
		--service-ports \
		-d \
		db

psql:
	@docker exec -it pgdb psql -U pgdev pgdb

down:
	@docker rm -f pgdb
