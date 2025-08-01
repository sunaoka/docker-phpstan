VERSION :=

VERSION_1X := 1.12.28
VERSION_2X := 2.1.21

TAG :=

IMAGE := sunaoka/phpstan

PLATFORM := linux/arm64,linux/amd64

BUILDER := docker-phpstan-builder-$(VERSION)

BUILD_ARG := --build-arg VERSION=$(VERSION)

TAGS := -t $(IMAGE):$(VERSION) -t $(IMAGE):$(basename $(basename $(VERSION)))

LATEST_TAG :=

all: 1.x 2.x

setup:
	(docker buildx ls | grep $(BUILDER)) || docker buildx create --name $(BUILDER)

1.x:
	$(MAKE) build VERSION=$(VERSION_1X)
	$(MAKE) test TAG=1

2.x:
	$(MAKE) build VERSION=$(VERSION_2X) LATEST_TAG="-t $(IMAGE):latest"
	$(MAKE) test TAG=latest

build: setup
	docker buildx use $(BUILDER)
	docker buildx build --rm --no-cache --pull --platform $(PLATFORM) $(BUILD_ARG) $(TAGS) $(LATEST_TAG) --push .
	docker buildx rm $(BUILDER)

test:
	docker run --pull=always --rm sunaoka/phpstan:$(TAG) --version
	docker run --rm -v $(CURDIR):$(CURDIR) -w $(CURDIR) sunaoka/phpstan:$(TAG) analyse --ansi --memory-limit=-1 -v -c ./tests/phpstan.neon

push:
	docker buildx build --push -t $(BUILD_ARG)

release:
	bash release.sh

.PHONY: all setup 1.x 2.x build test push release
