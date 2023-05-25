# OpenAPI Definitions and specifications

The Domino REST API is driven by multiple OpenAPI specifications. Every Domino server is surfacing the specifications according to its configuration. Additionally each configured access to a database (refered to as scope) is available on your server.

The deninitions below serve as reference and guide, so you can learn about the API without having the API installed.

!!! info "API definitions are individual"

    Please note: depending on your server configuration, not all endpoints will be active. Custom access definitions are not visible here

## Basis

The main API of the Domino REST API. It allows access to documents, views, folders and agents. An external application will only need this specification

[Explore the basis API](https://redocly.github.io/redoc/?url=https://frascati.projectkeep.io/api/v1/schema/openapi.basis.json)

## Admin

Access to administravive functions allowing to manage:

- Users
- Groups
- Access control lists (ACL)

[Explore the admin API](https://redocly.github.io/redoc/?url=https://frascati.projectkeep.io/api/admin-v1/schema/openapi.admin.json)

## Setup

The setup API provides endpoints to configure access to databases. You can specify what documents, views, folders, agents and items are made available in the REST API. Requires designer access to databases and `LocalKeepAdmins` membership

[Explore the setup API](https://redocly.github.io/redoc/?url=https://frascati.projectkeep.io/api/setup-v1/schema/openapi.setup.json)

## PIM

PIM stands for "Personal Information Management" and includes access to mail, calendar, contacts, todos and notebook. Access is based on users ownership of mail resources

[Explore the PIM API](https://redocly.github.io/redoc/?url=https://frascati.projectkeep.io/api/pim-v1/schema/openapi.pim.json)

## POI

We named this API in honor of an [Apache project](https://poi.apache.org/) that enables the access to Microsoft office formats.

[Explore the POI API](https://redocly.github.io/redoc/?url=https://frascati.projectkeep.io/api/poi-v1/schema/openapi.poi.json)

## Let's connect

--8<-- "feedback.md"
