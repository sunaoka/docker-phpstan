VERSION := 1.12.10

IMAGE := sunaoka/phpstan

PLATFORM := linux/arm64,linux/amd64

BUILDER := docker-phpstan-builder

BUILDER_ARGS := --build-arg VERSION=$(VERSION) -t $(IMAGE):$(VERSION) -t $(IMAGE):$(basename $(basename $(VERSION))) -t $(IMAGE):latest

all: build test

setup:
	(docker buildx ls | grep $(BUILDER)) || docker buildx create --name $(BUILDER)

build: setup
	docker buildx use $(BUILDER)
	docker buildx build --rm --no-cache --pull --platform $(PLATFORM) $(BUILDER_ARGS) --push .
	docker buildx rm $(BUILDER)

test:
	docker run --pull=always --rm sunaoka/phpstan:latest --version

.PHONY: all setup build
