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
- Run tests: ``make test``
- Show logs: ``make logs``
- Stop services: ``make down``
- Clean up: ``make clean``


## Test

### Suites available

- ``end2end``
- ``features``
- ``integration``
- ``health``

Any of the above mentioned test suites can be executed by running:

```
make test-<suite-name>
```

#### end2end

This suite checks that the service HTTP API provides the capabilities expected by its consumers.

It is an out of process test, i.e, it execises the service as a deployed artifact. To achieve this it uses stubbed external services.

*For example it uses ``minio`` as an ``s3`` stub.*

#### features

This suite checks the behaviour of each endpoint. It relies on the app booted in *test mode*, this way more variabilty can be introduced and errors and exceptions can be tested in a faster and controlled manner.

It is an in process test, i.e, endpoints are excesided directly (not via HTTP) and external services are consumed via stubbed clients.

*For example, it uses a stubbed s3 client.*

#### integration

This suite checks that the gateways behaviour is the expected. To achieve this it consumes the stubbed external service.

*For example, when testing ``Warehouse::Gateway`` consumes ``minio`` in order to check that it can retrieve pre-signed request instructions.*

#### health

This suite checks that the health endpoint behaviour is the expected.


### CI

This project is integrated with Travis CI: https://travis-ci.org/sapagat/evidence

## Production

## Dependencies

- Amazon S3
- Redis

**Note** You can check if the dependencies are met by checking the health endpoint: ``GET /health``

### Environment variables

The following environment variables must be set:

```
RACK_ENV=production

AUTH_TOKEN=<shared-key>

S3_BUCKET=<bucket-name>
S3_REGION=<region>
S3_ACCESS_KEY_ID=<access-key-id>
S3_SECRET_ACCESS_KEY=<secret-access-key>

REDIS_HOST=<redis-host>
REDIS_PORT=<redis-port>
REDIS_TIMEOUT=<redis-timeout>
```

### Procfile

Use a ``Procfile``, a text file in the root directory of your application, to explicitly declare what command should be executed to start your app.

An example app you deployed looks like this:

```
web: bundle exec rackup config.ru -p $PORT
```
