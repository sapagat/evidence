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

### Suites available

- ``end2end``: Checks that the service API provides the capabilities expected by its consumers.
- ``features``: Checks the behaviour its endpoint using test specific configuration and stubs.
- ``health``: Checks the behaviour of the health check endpoint.
- ``integration``

Any of the avobe mentioned test suites can be executed by running:

```
make test-<suite-name>
```

### CI

This project is integrated with Travis CI: https://travis-ci.org/sapagat/evidence

## Production

### Environment variables

The following environment variables must be set:

```
RACK_ENV=production
S3_BUCKET='<bucket-name>'
S3_REGION='<region>'
S3_ACCESS_KEY_ID='<access-key-id>'
S3_SECRET_ACCESS_KEY='<secret-access-key>'
```

### Procfile

Use a ``Procfile``, a text file in the root directory of your application, to explicitly declare what command should be executed to start your app.

An example app you deployed looks like this:

```
web: bundle exec rackup config.ru -p $PORT
```
