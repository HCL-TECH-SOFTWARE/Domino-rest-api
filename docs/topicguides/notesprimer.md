# The shiny web world - a primer

--8<-- "future.md"

## Ports

Communication between clients and servers require an address and a port (akin to building name and unit number). There is an [official list](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers) to look at. In Notes/Domino land we usually deal with client access (1352), SMTP (25), http (80) and https(443).

The rule/fact: **Only one service can listen on a specific port at a given address**. So when you have two web servers only one can use the default ports

The offcial port to protocol mapping serves as a simple shortcut when specifing destination locations:

- `http://someserver.com/` is short for `http//someserver.com:80/`
- `https://someserver.com/` is short for `https//someserver.com:443/`

The Domino REST API adds additional ports to be used. When a non-standard port is used, it can be any protocol, so `https://someserver.com:8880` is equally valid as `http://someserver.com:8880`. **Valid** doesn't mean **working**. Which protocol responds depends on the server configuration.

Practical pranks you can play: reconfigure a http server (e.g. Domino's http task) to use port 443 for http and port 80 for https and watch the confusion (Don't do that to a production system)

## JSON

[JSON](https://www.json.org/) is part of the operating system and programming language independent, human readable data (interchange) formats that include [CSV](https://en.wikipedia.org/wiki/Comma-separated_values), [XML](https://en.wikipedia.org/wiki/XML), [JSON](https://en.wikipedia.org/wiki/JSON) and [YAML](https://en.wikipedia.org/wiki/YAML).

!!! info "key value pairs"

    JSON is a set of case-sentitive key-value pairs

The keys are strings and the values can be only a few datat types: string, number, boolean, null or JSON. Notably absent are integers and date/time formats or binary data.

These shortcomings are mitigated in [JSON Schema](https://json-schema.org/) that defines the missing data types (e.g. a date is defined as String in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) Date format)

JSON is both used for data exchange, popular in REST APIs, and configuration settings (replacing [ini](https://en.wikipedia.org/wiki/INI_file) and [properties](https://en.wikipedia.org/wiki/.properties) files).

The Domino REST API makes heavy use of the JSON based [OpenAPI specification](https://www.openapis.org/)

## JSON Web Token (JWT)

A JWT is a string with a fixed structure. It is composed of 3 strings in [Base64](https://en.wikipedia.org/wiki/Base64) encoding joined by `.` (dot). When decoded, the first patr is JSON decribing the signature slgorithm and token type, the second part is also JSON, providing the actual information, while the third part is a digital signature.

!!! warning "NO encyption"

    JWT are not encrypted, so they are not suitable to carry confidential information

- The signature "only" guarantees that the token hasn't been altered since signing
- For verification (see OAUth below) you need access to the public key of th signer
- the actual information could be anythin JSON, but has defined elements like issue date and expiry when used as access token

There is [more to learn about JWT](https://jwt.io/), including an easy tool to check.

JWT are often used, including in the Domino REST API as [Access Tokens](https://www.oauth.com/oauth2-servers/access-tokens/) to gain authorized access to a server. To serve as an access token, it gets presenten with the [Authorization](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization) http(s) header as `Bearer [JWT Token]`.

A reasonable good anology: The JWT token is your concert ticket. At the entrance of the concert hall, security checks if the ticket is valid. They don't care how you did get it: ordered online, queued at the ticket booth, got it from an authorized reseller or won it from the local radio morning show. They only care if it is genuine.

The same principle applies to JWT as access token. As long as the token was signed by a trusted issuer (commonly refered to as Identity Provider or IdP) and is still valid, not expired, concert hall security will let you through. Of course a valid "Adele" ticket won't get you into the "Taylor Swift" concert, so the content of the ticket matters

## OAuth

!!! note "From the [official documentation](https://oauth.net/2/)"

    *OAuth 2.0 is the industry-standard protocol for authorization. OAuth 2.0 focuses on client developer simplicity while providing specific authorization flows for web applications, desktop applications, mobile phones, and living room devices. This specification and its extensions are being developed within the [IETF OAuth Working Group](https://www.ietf.org/mailman/listinfo/oauth)*.

In a nutshell: In OAuth usually two parties are involved: An identity provider (IdP), the place you login and consent and a service provider (SP), the application that does the actual work.

In an OAuth sequence (colloquial refered to as [OAuth dance](https://medium.com/typeforms-engineering-blog/the-beginners-guide-to-oauth-dancing-4b8f3666de10)) to obtain permission to act on a user's behalf (called a [OAuth grant](https://oauth.net/2/grant-types/)), the users get directed to the IdP, where, after authentication, they are asked for consent that the application (the SP) acts on their behalf (the exact flow depends on [the grant type](https://oauth.net/2/grant-types/)).

The result of the dance is at least an access token and quite commonly a refresh token. The application uses the access token for interaction with the API. Ideally access tokens are short lived, minutes rather than hours. On expiration the application would use the refresh token to obtain a new access token without the need of user interaction. Refesh tokens can be issued with very long valididty (days, weeks or months). If a refresh token is suspected to be compromised, it can be invalidated, so obtaining a new access token would fail and trigger the consent dialogue.

!!! tip "Lots to learn"

    Make sure to [learn more](https://oauth.net/2/) about this complex topic!

OAuth is a very open and complex standard. To use its Authorization capabilities for Authetication, the **[OpenID Foundation](https://openid.net/)** (OIDF) implemented a specific subset named [OpenID Connect](https://openid.net/developers/how-connect-works/) (OICD). That's is used here.

## Certificates

Certificates (nothing new to Notes people, we had them in the `notes.id` for decades) in the internet world come in three flavours:

- Issued by a recognised certificate authority ([CA](https://en.wikipedia.org/wiki/Certificate_authority)) like [LetsEncypt](https://letsencrypt.org)
- Issued by a private or unrecognized CA
- [Self signed](https://en.wikipedia.org/wiki/Self-signed_certificate)

!!! tip "Don't self sign"

    Sounds like easy for test system, not worth the headache, go for your own [private CA](https://www.wissel.net/blog/2019/10/create-your-own-ca.html)

The important term here is "recognised". All browsers ship with a list of recognized CA, by having a copy of their [Public keys](https://en.wikipedia.org/wiki/Public_key_certificate). One can ammend this list by adding or removing public keys, somthing one better leaves to [automated tooling](https://www.hcl-software.com/bigfix)

When dealing with other clients (e.g. your venerable Tomcat), the known CA list in the browser doesn't help, you need to add the cert where the application can find it. E.g. for Java that's the [Java keystore](https://jenkov.com/tutorials/java-cryptography/keystore.html) (remember [keytool](https://docs.oracle.com/javase/8/docs/technotes/tools/unix/keytool.html)).

If you use self-signed (please don't), you have to add each and every cert to all the clients, using a private CA, only the CA's public keys.

There is [much to learn](https://www.cloudflare.com/learning/ssl/how-does-public-key-encryption-work/), worth your time.

## TLS, SSL & HTTP/2

Any application avaiable on the intranet or internet needs secure communication. The standard means for that is [TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security) - Transport-Layer-Security. Colloquially the term [SSL](https://www.rfc-editor.org/rfc/rfc6101) is used (especially with [cert vendors](https://www.digicert.com/what-is-an-ssl-certificate)), but implementation is almost always TLS - and should be, SSL is considered compromizable.

Obtaining a valid certificate used to be a huge headache, but with the availability of [LetsEncypt](https://letsencrypt.org) it is now easy for internet facing systems. Domino has [build in support](https://help.hcltechsw.com/domino/12.0.2/admin/secu_le_managing-certs_from_LE.html) to use LetsEncypt

!!! tip "Use a wildcard cert for internal systems"

    Obtain a wildcard cert (*.yourdomain.net) using an internet facing system and use it for the internsl systems too. Does require proper local DNS setup

The current prevalent version of HTTP is [HTTP1.1](https://www.rfc-editor.org/rfc/rfc9110.html), a standard introduced **last century** (1995). Modern browsers (read: no IE) and contemporary web servers support [HTTP/2](https://en.wikipedia.org/wiki/HTTP/2). HTTP/2 requires a TLS connection, so you can't try it out using `http://localhost`. The Domino REST API uses HTTP/2 if a client supports it. All browsers do, but e.g. at time of writing [Postman](https://www.postman.com/) didn't.

HTTP/2 offers better security and shorter response times.

## OpenAPI

The [OpenAPI specification](https://www.openapis.org/) destribes in a standardised way what to expect from an API. The specification, expressed in [JSON](https://www.json.org/) or [YAML](https://en.wikipedia.org/wiki/YAML), is both machine readable and human readable (using a UI). It defines:

- The available endpoint URLs and supported methods
- Authetication required if any
- mandatory and optional parameters
- data formats to expect or provide
- external meta data

There is a rich eco system of tooling that allows to produce or consume OpenAPI specifications, here's just a small selection:

- UI to read and try the specs: [Swagger UI](https://swagger.io/tools/swagger-ui/) and [ReDoc](https://redocly.com/reference/)
- UI to create and edit: [Apicurio Studio](https://www.apicur.io/studio/) and [Swagger Editor](https://swagger.io/tools/swagger-editor/)
- Tools to [generate code](https://swagger.io/tools/swagger-codegen/) from a spec
- Libraries that consume a spec, create routes and enforce the definded constrains. For example [Java](https://vertx.io/docs/vertx-openapi/java/), [NodeJS](https://www.npmjs.com/package/express-openapi-validator), [Python](https://pypi.org/project/openapi-core/). There are many more.
