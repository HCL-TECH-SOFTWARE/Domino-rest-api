# Standards and Glossary

Provides a reference of standards and commonly used terms for the Domino REST API.

## Standards

Open standards are implemented whenever possible because they are more thoroughly scrutinized, have broader support, and facilitate easier interaction.

<!--We love open standards, there are [so many to pick from](https://xkcd.com/927/).
When possible, we implement those since they are better scrutinized, have wider support, and make interaction easier.

In alphabetical order:-->

- [ECMA-404](https://www.json.org/json-en.html): The JSON Data Interchange Standard (since XML is old and binary formats...)

- [ISO 10646 / RFC 2277](https://tools.ietf.org/html/rfc2277): Unicode UTF-8, working with all languages

- [ISO/IEC 20802-1:2016](https://www.iso.org/standard/69208.html): Open data protocol (OData) v4.0 — Part 1: Core

- [ISO/IEC 20802-2:2016](https://www.iso.org/standard/69209.html): Open data protocol (OData) v4.0 — Part 2: OData JSON

- [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601): Date and Time information, timezone aware

- [JSON Schema](https://datatracker.ietf.org/doc/draft-handrews-json-schema/): The upcoming standard for JSON structure specifications

- [OpenAPI](http://spec.openapis.org/oas/v3.0.3): The REST API standard provided by [the Linux Foundation](https://www.linuxfoundation.org/)

- [RFC 3886](https://tools.ietf.org/html/rfc3986): URI Generic Syntax

- [RFC 5246](https://tools.ietf.org/html/rfc5246): TLS 1.2 (soon [RFC8446](https://tools.ietf.org/html/rfc8446))

- [RFC 6797](https://tools.ietf.org/html/rfc6797): HTTP Strict Transport Security

- [RFC 6838](https://tools.ietf.org/html/rfc6838): Media type definitions, such as header accepts applications/json

- [RFC 7230](https://tools.ietf.org/html/rfc7230): HTTP/1.1

- [RFC 7231](https://httpwg.org/specs/rfc7231.html): HTTP Status Codes

- [RFC 7235](https://httpwg.org/specs/rfc7235.html): HTTP/1.1 Authentication

- [RFC 7517](https://tools.ietf.org/html/rfc7517): Json Web Key (JWK).

- [RFC 7519](https://tools.ietf.org/html/rfc7519): Json Web Token (JWT). All our endpoints short of login and OData (OData needs basic, Excel can't handle JWT)

- [RFC 7540](https://tools.ietf.org/html/rfc7540): HTTP/2

- [RFC 7807](https://tools.ietf.org/html/rfc7807): Problem details for HTTP APIs

- [RFC 8681](https://jmap.io/spec-mail.html): JSON implementation of mail and others

## Glossary

Commonly used terms for the Domino REST API.

### JKS

Java KeyStore, a repository of security certificates used for SSL encryption. Includes authorization and public and private keys.

### JWT

JSON Web Token, used for authentication between two trusted systems.

### NSF

Notes file system

### PEM

Base64 ASCII encoding security certificates used for SSL encryption. Includes authorization and public, private, and root keys.

### PIM

Personal Information Management such as mail calendar, contact, notebook/journals, tasks/todo's

### PKS

Security certificates used for SSL encryption.

### keepconfig.d

Directory where you can modify some of Domino REST API's settings. Located in your Domino data directory for all platforms. For example, in Linux, it's in **`/local/notesdata/keepconfig.d`**. In Windows, it's in **`C:\Domino\Data\keepconfig.d`**.

### domino-keep.log

The default file for storing logs. It's stored in the subdirectory `IBM_TECHNICAL_SUPPORT` of your `Notes/Domino` data directory. For more information, see [Logging](../howto/production/logging.md).