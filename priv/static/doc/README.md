# API Documentation

  * [ApiWeb.UserController](#apiweb-usercontroller)
    * [index](#apiweb-usercontroller-index)
    * [create](#apiweb-usercontroller-create)
    * [show](#apiweb-usercontroller-show)
    * [update](#apiweb-usercontroller-update)
    * [delete](#apiweb-usercontroller-delete)

## ApiWeb.UserController
### <a id=apiweb-usercontroller-index></a>index
#### index/2 returns success with a list of users when there are users

##### Request
* __Method:__ GET
* __Path:__ /users
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: F2yvY5Mg3XHTD8kAAABD
```
* __Response body:__
```json
{
  "data": [
    {
      "email": "rebeka_mertz@friesen.biz",
      "id": "71cbb1b3-b3a8-40c0-a7f8-0383625a3e38",
      "name": "Keshaun Willms"
    }
  ]
}
```

### <a id=apiweb-usercontroller-create></a>create
#### create/2 returns success when the user parameters are valid

##### Request
* __Method:__ POST
* __Path:__ /users
* __Request headers:__
```
accept: application/json
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "user": {
    "email": "lula2096@marvin.biz",
    "inserted_at": "2022-07-27T05:30:54.426462Z",
    "name": "Mr. Gardner Schuster I",
    "password": "C0Uyxo1IwBoth5YR854rVgpnjnpqreneuylQN71yswI",
    "password_hash": "$argon2id$v=19$m=65536,t=8,p=2$0gIstrzzJ+TB4KL/MabR1A$hF4w4sgCbLhmbNgYvNdsRT9gt5r0NF4R/NEjoE/DrfU",
    "updated_at": "2023-06-28T01:46:43.385331Z"
  }
}
```

##### Response
* __Status__: 201
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: F2yvY8Q2EIQ_LggAAAHF
location: /users/43f641e2-409f-4ba2-a8d3-c75f0d419d34
```
* __Response body:__
```json
{
  "data": {
    "email": "lula2096@marvin.biz",
    "id": "43f641e2-409f-4ba2-a8d3-c75f0d419d34",
    "name": "Mr. Gardner Schuster I"
  }
}
```

#### create/2 returns error when the user parameters are invalid

##### Request
* __Method:__ POST
* __Path:__ /users
* __Request headers:__
```
accept: application/json
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "user": {
    "email": "???",
    "name": null,
    "password": "?"
  }
}
```

##### Response
* __Status__: 422
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: F2yvZIhPcLe1QLsAAADH
```
* __Response body:__
```json
{
  "errors": {
    "email": [
      "has invalid format"
    ],
    "name": [
      "can't be blank"
    ],
    "password": [
      "should be at least 6 character(s)"
    ]
  }
}
```

### <a id=apiweb-usercontroller-show></a>show
#### show/2 returns success when the user id is found

##### Request
* __Method:__ GET
* __Path:__ /users/94cdf5dd-845b-4050-8e04-9a9fb278e33a
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: F2yvY18aFAA0jUIAAAFF
```
* __Response body:__
```json
{
  "data": {
    "email": "ottis_huels@raynor.org",
    "id": "94cdf5dd-845b-4050-8e04-9a9fb278e33a",
    "name": "Ms. Arvilla Windler"
  }
}
```

#### show/2 returns error when the user id is not found

##### Request
* __Method:__ GET
* __Path:__ /users/f7301f6c-58df-4455-a6d1-67ade3b90ec8
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 422
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: F2yvZFfN00dCKvYAAAJF
```
* __Response body:__
```json
{
  "errors": {
    "id": [
      "not found"
    ]
  }
}
```

### <a id=apiweb-usercontroller-update></a>update
#### update/2 returns success when the user parameters are valid

##### Request
* __Method:__ PUT
* __Path:__ /users/7beb93c0-b42f-49f2-9080-a2ecf8d9345d
* __Request headers:__
```
accept: application/json
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "user": {
    "email": "dariana_smith@denesik.net",
    "inserted_at": "2022-09-25T23:56:01.352595Z",
    "name": "Maryam Medhurst",
    "password": "/Ql7cIbyrWCTzV3DS1NZ/jX9UgfTOB0fhPu6yUB6oAc",
    "password_hash": "$argon2id$v=19$m=65536,t=8,p=2$zZ17a7Bpq83E6l3cUVlx/Q$LjYyrUt4vwqxrWEZcL49h7cVpfnkEXJOb+3tvenNJUM",
    "updated_at": "2023-06-28T01:46:44.595400Z"
  }
}
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: F2yvZAxWfGdIisYAAACH
```
* __Response body:__
```json
{
  "data": {
    "email": "dariana_smith@denesik.net",
    "id": "7beb93c0-b42f-49f2-9080-a2ecf8d9345d",
    "name": "Maryam Medhurst"
  }
}
```

#### update/2 returns error when the user parameters are invalid

##### Request
* __Method:__ PUT
* __Path:__ /users/3422d1de-69d2-4c2b-b983-5c752cded3f3
* __Request headers:__
```
accept: application/json
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "user": {
    "email": "?@?",
    "name": "?",
    "password": null
  }
}
```

##### Response
* __Status__: 422
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: F2yvY3pZrrnpNS8AAAGF
```
* __Response body:__
```json
{
  "errors": {
    "email": [
      "has invalid format"
    ],
    "name": [
      "should be at least 2 character(s)"
    ],
    "password": [
      "can't be blank"
    ]
  }
}
```

### <a id=apiweb-usercontroller-delete></a>delete
#### delete/2 returns success when the user is found

##### Request
* __Method:__ DELETE
* __Path:__ /users/bdb5e0b8-5358-4390-99c5-e7447cf95a58
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 204
* __Response headers:__
```
cache-control: max-age=0, private, must-revalidate
x-request-id: F2yvZHBwyoMXhAoAAACD
```
* __Response body:__
```json

```

#### delete/2 returns error when the user is not found

##### Request
* __Method:__ DELETE
* __Path:__ /users/f7301f6c-58df-4455-a6d1-67ade3b90ec8
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 422
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: F2yvZD9IpQy4wVwAAAIF
```
* __Response body:__
```json
{
  "errors": {
    "id": [
      "not found"
    ]
  }
}
```

