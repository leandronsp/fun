args = $(filter-out $@, $(MAKECMDGOALS))

vnc:
	@docker-compose run \
		--rm \
		--service-ports \
		--name vnc \
		vnc

vnc.bash:
	@docker exec -it vnc bash

sdkmanager.setup:
	@docker exec -it vnc bash -c "./sdkmanager.sh"

emulator:
	@docker exec -it vnc bash -c "./emulator.sh"


%:
	@:
