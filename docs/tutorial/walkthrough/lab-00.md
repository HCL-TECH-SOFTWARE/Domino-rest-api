# Lab 0 - Overview

## Duration 20 min

## What you will learn

- Validate your laptop setup
- Get a first overview of the REST API (presentation by instructor)

## Prerequisites

- Laptop
- Internet connection to download site
- Workshop prerequisites

## Steps (not all are needed)

- Verify that you have a running Domino server with admin access
- Download POSTMAN [collection](../downloads/dachnug2023.postman_collection.json) & POSTMAN [environment](../downloads/dachnug2023.postman_environment.json)
- download [`keep`](../downloads/keep) (Mac/Linux) or [`keep.cmd`](../downloads/keep.cmd) (Windows)
- download [ApprovalCentral.zip](../downloads/ApprovalCentral.zip)
- Import into POSTMAN: environment & collection

## How to check

Commands that should work

```bash
node -v
java -version
curl --version
```

- Postman installed (can start)
- Domino running with REST API active: open [localhost:8880](http://localhost:8880) and see:

![Landing page](img/landingPage.png)

## Things to explore

- [Official Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)
- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)
- Open the OpenAPI v3 tile (a.k.a. Swagger)
