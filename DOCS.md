# Evidence API docs

## Authentication

Evidence service uses a pre-shared token authentication check. This shared key is specified by the environment variable ``AUTH_TOKEN``.

The HTTP request's body has to include ``auth_token`` parameter and must match with the ``AUTH_TOKEN`` environment variable.
If the token is invilaid the service will respond with a ``401`` response.

## Obtain instructions

Provides an http descriptor for uploading to S3 using a pre-signed request. In addion it provides an ``attempt_id`` that identifies the upload.

### Contract

- Endpoint: ``/provide_instructions``
- Method: ``POST``
- Requires a evidence ``key`` to be specified as well as the ``auth_token``.

### Example

Request:

```
POST /provide_instructions HTTP/1.1
Content-Type: application/json

{
    "auth_token": "de00fcdd-4731-441b-b872-4f1a5d811fe8",
    "key": "/year/reports.pdf"
}
```

Response:

```
HTTP/1.1 200 OK
Content-Type: application/json

{
    "attempt_id": "4d6ac229-0def-4a88-882d-66914c3d1e6d",
    "key": "/year/reports.pdf",
    "instructions": {
        "url": "https://s3.a_region.amazonaws.com/a_bucket/test.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=an_access_key_id%2F20170618%2Fa_region%2Fs3%2Faws4_request&X-Amz-Date=20170618T105131Z&X-Amz-Expires=900&X-Amz-SignedHeaders=host&X-Amz-Signature=58a85acf1be5dfc674230a7f2065c5d64f6f4601a7af4faa769e2a52956a35b6",
        "method": "PUT"
  }
}
```


## Resolve attempt

Resolves the evidence upload by checking it is stored in S3 and consumes the attempt.

### Contract

- Endpoint: ``/resolve_attempt``
- Method: ``POST``
- Requires an ``attempt_id`` as well as the ``auth_token``.

### Example

Request:

```
POST /resolve HTTP/1.1
Content-Type: application/json

{
    "auth_token": "de00fcdd-4731-441b-b872-4f1a5d811fe8",
    "attempt_id": "4d6ac229-0def-4a88-882d-66914c3d1e6d"
}
```

Response:

```
HTTP/1.1 200 OK

{
    "key": "/year/reports.pdf"
}
```

