.PHONY: shell
.PHONY: clean
	
TOOLCHAIN_NAME=rg35xx-toolchain
WORKSPACE_DIR := $(shell pwd)/workspace
DOCKER_CMD := /bin/bash
INTERACTIVE := 1
ifeq ($(INTERACTIVE),1)
    DOCKER_IT := -it
else
    DOCKER_IT :=
endif
UID := $(shell id -u)
GID := $(shell id -g)

CONTAINER_NAME=$(shell docker ps -f "ancestor=$(TOOLCHAIN_NAME)" --format "{{.Names}}")
BOLD=$(shell tput bold)
NORM=$(shell tput sgr0)

.build: Dockerfile
	$(info $(BOLD)Building $(TOOLCHAIN_NAME)...$(NORM))
	mkdir -p ./workspace
	docker build -t $(TOOLCHAIN_NAME) --progress=plain . 2>&1 | tee build.log
	touch .build

ifeq ($(CONTAINER_NAME),)
shell: .build
	$(info $(BOLD)Starting $(TOOLCHAIN_NAME)...$(NORM))
	docker run $(DOCKER_IT) --rm --user $(UID):$(GID) -v "$(WORKSPACE_DIR)":/workspace \
        -v "/etc/group:/etc/group:ro" \
        -v "/etc/passwd:/etc/passwd:ro" \
        -v "/etc/shadow:/etc/shadow:ro" \
        -v "/etc/sudoers:/etc/sudoers:ro" \
				$(TOOLCHAIN_NAME) $(DOCKER_CMD)
else
shell:
	$(info $(BOLD)Connecting to running $(TOOLCHAIN_NAME)...$(NORM))
	docker exec $(DOCKER_IT) $(CONTAINER_NAME) $(DOCKER_CMD)
endif

clean:
	$(info $(BOLD)Removing $(TOOLCHAIN_NAME)...$(NORM))
	docker rmi $(TOOLCHAIN_NAME)
	rm -f .build
