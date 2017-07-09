# Evidence API docs

## Obtain instructions

Provides an http descriptor for uploading to S3 using a pre-signed request. In addion it provides an ``attempt_id`` that identifies the upload.

### Contract

- Endpoint: ``/provide_instructions``
- Method: ``POST``

### Example

Request:

```
POST /provide_instructions HTTP/1.1
Content-Type: application/json

{}
```

Response:

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "attempt_id": "4d6ac229-0def-4a88-882d-66914c3d1e6d",
  "instructions": {
    "url": "https://s3.a_region.amazonaws.com/a_bucket/test.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=an_access_key_id%2F20170618%2Fa_region%2Fs3%2Faws4_request&X-Amz-Date=20170618T105131Z&X-Amz-Expires=900&X-Amz-SignedHeaders=host&X-Amz-Signature=58a85acf1be5dfc674230a7f2065c5d64f6f4601a7af4faa769e2a52956a35b6",
    "method": "PUT"
  }
}
```


## Resolve attempt

Resolves the evidence upload and consumes the attempt.

### Contract

- Endpoint: ``/resolve_attempt``
- Method: ``POST``
- Requires an attempt id.

### Example

Request:

```
POST /resolve HTTP/1.1
Content-Type: application/json

{
  "attempt_id": "4d6ac229-0def-4a88-882d-66914c3d1e6d"
}
```

Response:

```
HTTP/1.1 200 OK
```

