CPU_COUNT=2
DOCKER_ORG=dier
DOCKER_BUILD_EXTRA_ARGS=

VERSION=3.4.14
# VERSION=3.5.6
DOCKER_CONTAINER_NAME=zookeeper

clean:
	# nothing to do

build:
	docker build \
		--rm \
		--force-rm \
		--compress \
		--cpu-quota $(CPU_COUNT)00000 \
		$(DOCKER_BUILD_EXTRA_ARGS) \
		-f $(shell pwd)/Dockerfile \
		-t $(DOCKER_ORG)/zookeeper:$(VERSION) \
		$(shell pwd)

run:
	docker run -i -t --rm \
		--cpus $(CPU_COUNT) \
		--name $(DOCKER_CONTAINER_NAME) \
		$(DOCKER_ORG)/zookeeper:$(VERSION)