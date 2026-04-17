# syntax=docker/dockerfile:1
# check=error=true
ARG VERSION=latest

# https://github.com/phpstan/phpstan/pkgs/container/phpstan
FROM ghcr.io/phpstan/phpstan:${VERSION}

RUN <<EOT sh -ex
  composer global require phpstan/phpstan-strict-rules
  composer global require phpstan/phpstan-deprecation-rules
  composer global require phpstan/phpstan-phpunit
  composer global require phpstan/phpstan-mockery
  composer global require spaze/phpstan-disallowed-calls
EOT
