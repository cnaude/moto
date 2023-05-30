include envfile

SHELL = bash
BUILD_TAG = $(NAME):latest

_OS = $(shell uname -s)

.PHONY: attach build kill run shell

.EXPORT_ALL_VARIABLES:

all: build

build: 
	docker build -t $(BUILD_TAG) .
	@echo -e '\e[96m#############\e[0m'
	@echo -e '\e[96m# \e[93mdocker run $(PORTS) $(ENV_VARS) --name $(NAME) -it --rm -t $(BUILD_TAG)\e[0m'
	@echo -e '\e[96m#############\e[0m'

compose:
	docker-compose up --build --remove-orphans

run: build
		docker run \
		--name $(NAME) \
		-it \
    $(ENV_VARS) \
		--rm -t $(BUILD_TAG)

noint: build
		docker run \
		--name $(NAME) \
    $(ENV_VARS) \
		--rm -t $(BUILD_TAG)

kill:
	docker kill $(NAME)

shell:
	docker run \
		--name $(NAME) \
		-it \
    $(ENV_VARS) \
		--entrypoint /bin/bash \
		--rm -t $(BUILD_TAG)

attach:
	docker exec -it $(NAME) /bin/bash
