# zookeeper-docker

================

## Building

### Quick Build

```bash
make build VERSION="3.4.14"
```

### Quick Run

```bash
export DOCKER_CONTAINER_NAME=zookeeper

make run DOCKER_CONTAINER_NAME=${DOCKER_CONTAINER_NAME}
```

### Quik check status of zookeeper

```bash
export DOCKER_CONTAINER_NAME=zookeeper

docker exec -t -i ${DOCKER_CONTAINER_NAME} bin/zkServer.sh status
```
