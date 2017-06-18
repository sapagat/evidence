# Evidence [WIP]

Evidence is a service that provides HTTP descriptors for making pre-signed requests and keep track of uploads in progress.

## Docs

You can read about the service capabilities [here](DOCS.md)

## Development

### Requirements

- Docker https://docs.docker.com/compose/install/
- Makefile

### Commands

- Boot up development server on http://localhost:7000: ``make up``
- Run tests: ``make-test``
- Show logs: ``make-logs``
- Stop services: ``make-down``
- Clean up: ``make-clean``

## Test

Suites available:

- ``end2end``: Checks that the service API provides the capabilities expected by its consumers.
