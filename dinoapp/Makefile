install.gems:
	@docker build -t dinoapp --target base .
	@docker run \
		--rm \
		-it \
		-v $(CURDIR):/app \
		-v rubygems_dinoapp:/usr/local/bundle \
		-w /app \
		dinoapp \
		bash -c "gem install rack byebug sqlite3 adelnor puma unicorn rack-handlers"

db.seed:
	@docker build -t dinoapp --target base .
	@docker run \
		--rm \
		-it \
		-v $(CURDIR):/app \
		-v rubygems_dinoapp:/usr/local/bundle \
		-w /app \
		dinoapp \
		bash -c "ruby tasks/seed_db.rb"

web.server:
	@docker build -t dinoapp --target base .
	@docker run \
		--rm \
		--name dinoapp \
		-it \
		-v $(CURDIR):/app \
		-v rubygems_dinoapp:/usr/local/bundle \
		-w /app \
		-p 3000:3000 \
		dinoapp \
		bash -c "ruby bin/server"

bash:
	@docker build -t dinoapp --target base .
	@docker run \
		--rm \
		-it \
		-v $(CURDIR):/app \
		-v rubygems_dinoapp:/usr/local/bundle \
		-w /app \
		dinoapp \
		bash

prod.setup:
	@bash iac/setup ${instance}

prod.deploy:
	@bash iac/deploy ${instance}
