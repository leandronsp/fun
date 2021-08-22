args = $(filter-out $@, $(MAKECMDGOALS))

run:
	@docker-compose run \
		--rm \
		--service-ports \
		--entrypoint --flutter-android-emulator \
		app \
		create my_app

%:
	@:
