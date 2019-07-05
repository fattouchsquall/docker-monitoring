SHELL = /bin/sh

# Colors
COLOR_END     = \033[0m
COLOR_INFO    = \033[36m
COLOR_COMMENT = \033[33m
COLOR_GROUP   = \033[1m

# Docker variables
LIGNES = all
APPLICATION_NAME = cadvisor
DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_EXEC = $(DOCKER_COMPOSE) exec $(APPLICATION_NAME) bash

.PHONY: 
	docker-start docker-stop docker-log docker-bash docker-inspect docker-exec

.DEFAULT_GOAL := help

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\n${COLOR_COMMENT}Usage:${COLOR_END}\n  make ${COLOR_INFO}<target>${COLOR_COMMENT}\n\nTargets:\n${COLOR_END}"} /^[a-zA-Z_-]+:.*?##/ { printf "  ${COLOR_INFO}%-20s${COLOR_END} %s\n", $$1, $$2 } /^##@/ { printf "\n${COLOR_GROUP}%s${COLOR_END}\n", substr($$0, 5) }' $(MAKEFILE_LIST)

###########
##@ Docker
##########
	
docker-start: ## Run (and build) docker instance
	@$(DOCKER_COMPOSE) up -d --force-recreate --build --remove-orphans

docker-stop: ## Stop docker instance
	@$(DOCKER_COMPOSE) down --remove-orphans
	
docker-log: ## Output logs of docker (to update the number of lines, you can specify the number with the argument LIGNES: make docker-log LIGNES=5)
	@$(DOCKER_COMPOSE) logs -t --tail=$(LIGNES) $(APPLICATION_NAME)

docker-bash: ## Login to docker instance
	@$(DOCKER_COMPOSE_EXEC) bash
	
docker-inspect: ## Inspect the applicatif docker container
	@docker inspect $(APPLICATION_NAME)

docker-exec: ## Execute any other make task on docker (make docker-exec TASK=test to use it), you can specify the APPLICATION_NAME=cadvisor
	@$(DOCKER_COMPOSE_EXEC) $(MAKE) $(TASK)