GIT_UPDATE_INDEX     ?= $(shell git update-index --refresh)
GIT_REVISION         ?= $(shell git rev-parse HEAD)
GIT_VERSION          ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo dev)

DOCKER_BUILD_IMAGE      ?= ghcr.io/sylr/ubuntu
DOCKER_BUILD_VERSION    ?= $(shell echo $(GIT_VERSION) | tr '+' '_')
DOCKER_BUILD_LABELS      = --label org.opencontainers.image.title=Ubuntu
DOCKER_BUILD_LABELS     += --label org.opencontainers.image.description="Sylr's ubuntu image"
DOCKER_BUILD_LABELS     += --label org.opencontainers.image.url="https://github.com/sylr/docker-ubuntu"
DOCKER_BUILD_LABELS     += --label org.opencontainers.image.source="https://github.com/sylr/docker-ubuntu"
DOCKER_BUILD_LABELS     += --label org.opencontainers.image.revision=$(GIT_REVISION)
DOCKER_BUILD_LABELS     += --label org.opencontainers.image.version=$(GIT_VERSION)
DOCKER_BUILD_LABELS     += --label org.opencontainers.image.created=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
DOCKER_BUILD_BUILD_ARGS  = --build-arg=GO_VERSION=$(DOCKER_BUILD_GO_VERSION)
DOCKER_BUILD_BUILD_ARGS += --build-arg=GIT_REVISION=$(GIT_REVISION)
DOCKER_BUILD_BUILD_ARGS += --build-arg=GIT_VERSION=$(GIT_VERSION)
DOCKER_BUILDX_PLATFORMS ?= linux/amd64,linux/arm64
DOCKER_BUILDX_CACHE_DIR ?= /tmp/.buildx-cache

.PHONY: docker-build docker-push docker-inspect

docker-build:
	docker buildx build . -f Dockerfile --progress=plain \
    -t $(DOCKER_BUILD_IMAGE):$(DOCKER_BUILD_VERSION) \
    --platform=$(DOCKER_BUILDX_PLATFORMS) \
    $(DOCKER_BUILD_BUILD_ARGS) \
    $(DOCKER_BUILD_LABELS) \
    --load

docker-push:
	docker buildx build . -f Dockerfile --progress=plain \
    -t $(DOCKER_BUILD_IMAGE):$(DOCKER_BUILD_VERSION) \
    --platform=$(DOCKER_BUILDX_PLATFORMS) \
    $(DOCKER_BUILD_BUILD_ARGS) \
    $(DOCKER_BUILD_LABELS) \
    --push
