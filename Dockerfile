# syntax=docker/dockerfile:1.4
ARG VERSION
FROM ghcr.io/phpstan/phpstan:${VERSION}

RUN <<EOT sh -ex
  composer global require phpstan/phpstan-strict-rules
  composer global require phpstan/phpstan-phpunit
  composer global require phpstan/phpstan-mockery
EOT
