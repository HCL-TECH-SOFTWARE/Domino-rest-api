# Lab 01 - Login to the REST API

## Duration 10 min

## What you will learn

Four ways to login to the REST API

## Prerequisites

- Lab 0 completed
- Domino with REST running
- downloaded `keep` or `keep.cmd` [from here](../downloads/index.md)

## Steps

### Set permissions

The database `KeepConfig.nsf` uses the group `LocalKeepAdmins` for access control. So create that group in your Domino directory and assign your user to it.

!!! danger "Use your own credentials"

    The steps below use "KEEP Admin" and "passw0rd" as credentials
    Replace those with the admin user on your Domino server

### Login using the command line

```bash
curl --location --request POST "http://localhost:8880/api/v1/auth" \
   --header 'Content-Type: application/json' \
   --data-raw '{"username" : "KEEP Admin", "password" : "passw0rd"}'
```

!!! note "All on one line"

    The command above is one line. To make it more readable it is broken
    into multiple lines using the "continuation character". On macOS/Linux
    that is `\`, on Windows `^`

Alternative type `keep login`

You will, on successful login, receive a JSON response we can verify on [jwt.io](https://jwt.io/).

![Successful local login](img/localLogin.png)

### Login using the OpenAPI UI

The second tile on the landing page provides access to the openAPI UI (a.k.a Swagger)

![Access to Swagger](img/swagger1.png)

Check you have the correct port,protocol and host. For a local installation that's

| Variable | required value |
| -------- | -------------- |
| port     | 8880           |
| protocol | http           |
| host     | localhost      |

![Access to Swagger](img/swagger2.png)

Scroll down to `authentication`, expand `authLogin`, and click try it out. Fill in username and password

![Access to Swagger](img/swagger3.png)

The resulting bearer needs to be copied into form behind the button ![Access to Swagger](img/swagger4.png).

![Access to Swagger](img/swagger5.png)

### Login AdminUI

![Admin Login](img/AdminLogin.png)

A successful login will show the AdminUI.

![Admin UI](img/AdminUI.png)

### Login using Postman

- Download Import the Postman [collection](../downloads/dachnug2023.postman_collection.json) and [environment](../downloads/dachnug2023.postman_environment.json)
- Open the Lab1 folder, execute the first entry labeled "Login"

The successful login shows the bearer token and 4 passed tests

![Postman login](img/PostmanLogin.png)

## How to check

- All methods return the bearer token. copy the token and paste it in the [JWT Token checker](https://jwt.io/)
- Each token has a different start/end time

## Things to explore

- [Official Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)
- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)
- Call the `/api` endpoint using curl.
- Check the different OpenAPI collections in the swagger UI.
- Check what happens when invalid credentials are provided.
- Access an endpoint, such as `/api/v1/scopes`, then the logout endpoint and try again.
