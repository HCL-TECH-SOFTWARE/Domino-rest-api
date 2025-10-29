# JSON Web Token specification

Domino REST API can issue a valid JSON Web Token using a user’s Domino credentials via the `POST/auth` endpoint in OpenAPI. Domino REST API can also process and use an incoming JWT from an external Identity Provider (IdP).

When issuing a valid JWT, the payload of the JWT may include the following parameters or claims:

|Parameter/Claim|Type|Description|
|:---|:---|:---|
|iss|String|Stands for *Issuer* and refers to the name of the IdP.</br></br>The iss uses the value of the `JwtIssuer` if present. If not, the value is the URL of the server.|
|sub|String|Stands for *Subject* and refers to the full qualified X.500 expended Notes name.</br></br>The value of the sub includes a series of Domino-format distinguished names, each of which contains an attribute type and value pair. The attribute types are:</br></br>- CN for common name of the user who generated the JWT.</br>- O for organization name of the user.</br></br>Example: `CN=My Name/O=MyOrganization`|
|iat|Integer|Stands for *Issued At* and identifies the time at which the JWT was issued. Its value is a NumericDate value.|
|exp|Integer|Stands for *Expiry Time* and identifies the expiration time on or after which the JWT must not be accepted for processing. The expiration time must coincide with the defined value of the `maxJwtDuration` parameter. Its value is a NumericDate value.|
|aud|Array|Stands for *Audience* and identifies the recipient that the JWT is intended for. Its only value is `Domino` (case-sensitive).|
|CN|String|Stands for *Common Name* and has the same definition and values as the `sub` claim.|
|scope|String|Refers to the databases and services that the user accesses. The values must be a space-separated list of database aliases, `Mail`, `$SETUP`, and/or `$DATA`.</br></br> For more information, see [Scopes](../schemacomponents/scopes.md)|
|email|String|Email address of the user whose Domino credentials were used to issue the JWT.|

When processing and using an incoming JWT from an external IdP, you need to configure Domino REST API by creating a JSON file in `keepconfig.d`. The JSON file may include the following keys:

|Key|Description|
|:---|:---|
|jwt|Indicates that the configuration is related to JWT.|
|IdP name|The name you give your IdP. It's not a fixed value but should be unique on your server.|
|active|Identifies whether to load the JWT configuration. Value is either true or false|
|algorithm|Indicates the supported algorithm, which is currently `RS256`.|
|providerUrl|Points to the external IdP’s endpoint URI to obtain the public key for JWT verification from the key server.</br></br>Domino REST API extends this URL by adding `/.well-known/openid-configuration` and check for the JSON return containing the `jwks_uri` key.</br></br>If your IdP doesn’t use the `.well-known` approach, such as Keycloak, you need to directly point to the key URL.|
|keyFile|Indicates the path to the public key file relative to `keepconfig.d` or an absolute path. It's used when the administrator saves the key files locally in a secure location.|
|kid|Stands for *key ID* and indicates which key was used to secure JWS. It's used when the administrator saves the key files locally in a secure location.|
|iss|Stands for *Issuer* and points to the external IdP’s endpoint URL with the public key in case the URL changed during IdP configuration.</br></br>It can also point to the external IdP’s endpoint URL if the administrator saves the key files locally in a secure location.|
|aud|When using [Microsoft Entra ID as IdP](../../howto/IdP/configuringAD.md), set its value to the configured *Application ID URI*.|
|userIdentifier|Use to configure Domino REST API to accept LDAP-format name. Must be configured with `userIdentifierinLdapFormat`. Set the value to `dn`.|
|userIdentifierInLdapFormat|Use to configure Domino REST API to accept LDAP-format name. Must be configured with `userIdentifier`. Set the value to `true`.|

!!!note
    When processing and using an incoming JWT from an external IdP, there are 2 configuration modes that you can use to configure Domino REST API. One configuration mode uses the `providerUrl`, while the other uses `keyFile` and `kid`. To learn more, see [External JWT/OIDC provider](../security/authentication.md#external-jwtoidc-providers).

Example configuration:

```json
    {
    "jwt": {
        "AzureAD01": {
            "active": true,
            "providerUrl": "https://login.microsoftonline.com/[your-tennantid-here]/v2.0/.well-known/openid-configuration",
            "aud": "api://dominorest",
            "iss": "https://sts.windows.net/[your-tennantid-here]/",
            "algorithm": "RS256"
        }
        }
    }
```

In the example configuration, **AzureAD01** is the `IdP name`. 




