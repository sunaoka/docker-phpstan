# PHPStan (PHP Static Analysis Tool) with extensions Docker image

Docker image with the following extensions installed on phpstan.

- [phpstan/phpstan-strict-rules](https://github.com/phpstan/phpstan-strict-rules)
- [phpstan/phpstan-deprecation-rules](https://github.com/phpstan/phpstan-deprecation-rules)
- [phpstan/phpstan-phpunit](https://github.com/phpstan/phpstan-phpunit)
- [phpstan/phpstan-mockery](https://github.com/phpstan/phpstan-mockery)
- [spaze/phpstan-disallowed-calls](https://github.com/spaze/phpstan-disallowed-calls)

## Usage

You can update the `phpstan.neon` file in order to use the extension:

```neon
includes:
    - /composer/vendor/phpstan/phpstan-strict-rules/rules.neon
    - /composer/vendor/phpstan/phpstan-deprecation-rules/rules.neon
    - /composer/vendor/phpstan/phpstan-phpunit/extension.neon
    - /composer/vendor/phpstan/phpstan-mockery/extension.neon
    - /composer/vendor/spaze/phpstan-disallowed-calls/extension.neon
```

```bash
docker run --rm -v $(pwd):/app -w /app sunaoka/phpstan:latest analyse --ansi --memory-limit=-1
```
