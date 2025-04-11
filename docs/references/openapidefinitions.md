# OpenAPI definitions and specifications

The Domino REST API is driven by multiple OpenAPI 3.0.2 specifications. Every Domino server is surfacing the specifications according to its configuration. Additionally each configured access to a database (referred to as scope) is available on your server.

The definitions below serve as reference and guide, so you can learn about the API without having the API installed.

!!! info "API definitions are individual"

    Depending on your server configuration, not all endpoints will be active. Custom access definitions are not visible here

## Basis

The main API of the Domino REST API. It allows access to documents, views, folders, and agents. An external application will only need this specification.

[Explore the basis API using the ReDoc viewer](https://redocly.github.io/redoc/?url=https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.basis.json)

[Open the `openapi.basis.json` file](https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.basis.json)

## Admin

Access to administrative functions allowing to manage:

- Users
- Groups
- Access control lists (ACL)

[Explore the admin API using the ReDoc viewer](https://redocly.github.io/redoc/?url=https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.admin.json)

[Open the `openapi.admin.json` file](https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.admin.json)

## Setup

The setup API provides endpoints to configure access to databases. You can specify what documents, views, folders, agents, and items are made available in the REST API. Requires designer access to databases and `LocalKeepAdmins` membership.

[Explore the setup API using the ReDoc viewer](https://redocly.github.io/redoc/?url=https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.setup.json)

[Open the `openapi.setup.json` file](https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.setup.json)

## PIM

PIM stands for "Personal Information Management" and includes access to mail, calendar, contacts, todos, and notebook. Access is based on users ownership of mail resources.

[Explore the PIM API using the ReDoc viewer](https://redocly.github.io/redoc/?url=https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.pim.json)

[Open the `openapi.pim.json` file](https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.pim.json)

## POI

We named this API in honor of an [Apache project](https://poi.apache.org/) that enables the access to Microsoft office formats.

[Explore the POI API using the ReDoc viewer](https://redocly.github.io/redoc/?url=https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.poi.json)

[Open the `openapi.poi.json` file](https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.poi.json)

## WebDAV

*Web Distributed Authoring and Versioning* or WebDAV API provides endpoints to perform remote Web content authoring operations that support the Office Round Trip Experience and Virtual Spreadsheet features of Domino REST API.  

!!!note
    `PROPFIND`, `LOCK`, and `UNLOCK` methods aren't included since these aren't supported by OpenAPI.

[Open the `openapi.webdav.json` file](../assets/downloads/openapi.webdav.json)

## WOPI

*Web Application Open Platform Interface* or WOPI protocol provides a set of endpoints that enable online collaborative editing of document attachments in Domino. WOPI is a well documented open protocol, for more information, see the [WOPI documentation](https://learn.microsoft.com/en-us/microsoft-365/cloud-storage-partner-program/rest/).

[Open the `openapi.wopi.json` file](../assets/downloads/openapi.wopi.json)

## OpenAPI extensions

The OpenAPI specification is extensible, for one you can define new data types beyond [the default types](https://spec.openapis.org/oas/v3.0.3#schema-object) and you can introduce new method attributes prefixed with `x-`.
We added the following data types:

- Names : translate from/to a Domino names item
- Authors: translate from/to a Domino authors item
- Readers: translate from/to a Domino readers item
- RichText

### Custom attributes

| Name                  | Value                    | Purpose                                                 |
| --------------------- | ------------------------ | ------------------------------------------------------- |
| x-keep-version        | number                   | active since which API version, governed by config.json |
| x-keep-nofly          | enum (SERVER,CLIENT,EOS) | In which mode client, server, light is this unavailable |
| x-preview             | boolean                  | Is the endpoint available as preview only               |
| x-keep-scope          | string                   | ANY, $SETUP -> scope requirements for endpoint          |
| x-content-disposition | string                   | specify content use (attachment vs. inline)             |

## Let's connect

--8<-- "feedback.md"
