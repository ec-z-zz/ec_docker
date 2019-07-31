
DOCKER_COMPOSE_FILES := -f ./docker-compose-base.yml \
		-f ./docker-compose-nginx.yml \
		-f ./docker-compose-mysql.yml \
		-f ./docker-compose-postgres.yml \
		-f ./docker-compose-redis.yml \
		-f ./docker-compose-php.yml \
		-f ./docker-compose-gitlab.yml \
		-f ./docker-compose-nodejsapp.yml \


.PHONY: config
config:
	docker-compose \
	$(DOCKER_COMPOSE_FILES) \
	config


.PHONY: to_dev
to_dev:
	cat ./envs/same.env ./envs/dev.env > ./.env


.PHONY: to_prod
to_prod:
	cat ./envs/same.env ./envs/prod.env > ./.env


.PHONY: dev_start
dev_start: stop
dev_start: to_dev
dev_start: 
	docker-compose \
		$(DOCKER_COMPOSE_FILES) \
		start


.PHONY: prod_start
prod_start: stop
prod_start: to_prod
prod_start: 
	docker-compose \
		$(DOCKER_COMPOSE_FILES) \
		start


.PHONY: dev_restart
dev_restart: stop
dev_restart: to_dev
dev_restart: 
	docker-compose \
		$(DOCKER_COMPOSE_FILES) \
		restart


.PHONY: prod_restart
prod_restart: stop
prod_restart: to_prod
prod_restart: 
	docker-compose \
		$(DOCKER_COMPOSE_FILES) \
		restart


.PHONY: stop
stop: 
	docker-compose \
		$(DOCKER_COMPOSE_FILES) \
		stop


.PHONY: container_list
container_list: 
		docker ps --format "table {{.ID}}\t{{.Image}}\t{{.CreatedAt}}\t{{.Status}}\t{{.Ports}}"


.PHONY: dev
dev: stop
dev: to_dev
dev:
	docker-compose \
		$(DOCKER_COMPOSE_FILES) \
		up \
		-d \
		--build \
		--force-recreate


.PHONY: prod
prod: stop
prod: to_prod
prod:
	docker-compose \
		$(DOCKER_COMPOSE_FILES) \
		up \
		-d \
		--build \
		--force-recreate