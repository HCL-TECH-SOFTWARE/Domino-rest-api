# OpenAPI Definitions and specifications

The Domino REST API is driven by multiple OpenAPI specifications. Every Domino server is surfacing the specifications according to its configuration. Additionally each configured access to a database (refered to as scope) is available on your server.

The deninitions below serve as reference and guide, so you can learn about the API without having the API installed.

!!! info "API definitions are individual"

    Please note: depending on your server configuration, not all endpoints will be active. Custom access definitions are not visible here

## Basis

The main API of the Domino REST API. It allows access to documents, views, folders and agents. An external application will only need this specification

[Explore the basis API using the ReDoc viewer](https://redocly.github.io/redoc/?url=https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.basis.json)

## Admin

Access to administravive functions allowing to manage:

- Users
- Groups
- Access control lists (ACL)

[Explore the admin API using the ReDoc viewer](https://redocly.github.io/redoc/?url=https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.admin.json) [Download openapi.admin.json](https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.admin.json)

## Setup

The setup API provides endpoints to configure access to databases. You can specify what documents, views, folders, agents and items are made available in the REST API. Requires designer access to databases and `LocalKeepAdmins` membership

[Explore the setup API using the ReDoc viewer](https://redocly.github.io/redoc/?url=https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.admin.json) [Download openapi.admin.json](https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.admin.json)

## PIM

PIM stands for "Personal Information Management" and includes access to mail, calendar, contacts, todos and notebook. Access is based on users ownership of mail resources

[Explore the PIM API using the ReDoc viewer](https://redocly.github.io/redoc/?url=https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.pim.json) [Download openapi.pim.json](https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.pim.json)

## POI

We named this API in honor of an [Apache project](https://poi.apache.org/) that enables the access to Microsoft office formats.

[Explore the POI API using the ReDoc viewer](https://redocly.github.io/redoc/?url=https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.poi.json) [Download openapi.poi.json](https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.poi.json)

## Let's connect

--8<-- "feedback.md"
