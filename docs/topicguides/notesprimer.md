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

It is a set of case-sentitive key-value pairs where the keys are strings and the values can be only a few datat types: string, number, boolean, null or JSON. Notably absent are integers and date/time formats or binary data.

These shortcomings are mitigated in [JSON Schema](https://json-schema.org/) that defines the missing data types (e.g. a date is defined as String in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) Date format)

JSON is both used for data exchange, popular in REST APIs, and configuration settings (replacing [ini](https://en.wikipedia.org/wiki/INI_file) and [properties](https://en.wikipedia.org/wiki/.properties) files).

The Domino REST API makes heavy use of the JSON based [OpenAPI specification](https://www.openapis.org/)

## JSON Web Token (JWT)

A JWT is a string with a fixed structure. It is composed of 3 strings in [Base64](https://en.wikipedia.org/wiki/Base64) encoding joined by `.` (dot). When decoded, the first patr is JSON decribing the signature slgorithm and token type, the second part is also JSON, providing the actual information, while the third part is a digital signature.

Notably:

- JWT are not encrypted, so they are not suitable to carry confidential information
- The signature "only" guarantees that the token hasn't been altered since signing
- For verification (see OAUth below) you need access to the public key of th signer
- the actual information could be anythin JSON, but has defined elements like issue date and expiry when used as access token

There is [more to learn about JWT](https://jwt.io/), including sn easy tool to check.

JWT are often used, including in the Domino REST API as [Access Tokens](https://www.oauth.com/oauth2-servers/access-tokens/) to gain authorized access to a server. To serve as an access token, it gets presenten with the [Authorization](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization) http(s) header as `Bearer [JWT Token]`.

A reasonable good anology: The JWT token is your concert ticket. At the entrance of the concert hall, security checks if the ticket is valid. They don't care how you did get it: ordered online, queued at the ticket booth, got it from an authorized reseller or won it from the local radio morning show. They only care if it is genuine.

The same principle applies to JWT as access token. As long as the token was signed by a trusted issuer (commonly refered to as Identity Provider or IdP) and is still valid, not expired, concert hall security will let you through. Of course a valid "Adele" ticket won't get you into the "Taylor Swift" concert, so the content of the ticket matters

## OAuth

[OAuth explained](https://oauth.net/2/)

## Certificates

- [Public key](https://en.wikipedia.org/wiki/Public_key_certificate)

## TLS / SSL / HTTP/2

- [HTTP/2](https://en.wikipedia.org/wiki/HTTP/2)
- [TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security)

## OpenAPI

[Offical spec](https://www.openapis.org/)
