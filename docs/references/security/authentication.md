# Auth\*

--8<-- "keepmngtURLcaution1.md"

Domino REST API offers a built-in endpoint to exchange your Domino credentials for a valid JSON Web Token (JWT). This page describes the setup of **external JWT identity providers** (IdP).

## JWT Authorization

All actions in Domino REST API are secured with JWT. For starters, Domino provides a login endpoint that issues a valid JWT token to access Domino REST API in exchange for Domino credentials (user name and http password).

The Domino generated JWT:

- Uses a random symmetric key that changes on every Domino REST API restart and is stored only in memory.
- Works with one Domino server.
- Can be disabled in Domino REST API configuration with `"disableDominoLogin" :true` .

Should Domino use a permanent JWT Key, we can use a public/private key pair and add it to the Domino REST API configuration:

```json
{
  "JwtUsePubPrivKey": true,
  "JwtUsePemFile": true,
  "JwtIssuer": "DominoKeep",
  "JwtPrivateKeyFile": "path-to-private.key.pem",
  "JwtPublicKeyFile": "path-to-.public.key.pem",
  "JwtAlgorithm": "RSA"
}
```

!!!tip "Pro tip"
    The management UI (Port 8889) provides a one click option to create such key pairs and configuration entry stored in `keepconfig.d`

These keys can be shared between Domino servers, allowing, for example, redirects to a different mail server.

### External JWT provider

This is the configuration we would strongly suggest for outward facing Domino servers. Domino REST API can accept JWT tokens from multiple external providers.

To enable an external provider, Domino REST API requires access to the provider’s public key, which can be configured in two ways.

If your provider supports the [`/.well-known/openid-configuration` endpoint](https://ldapwiki.com/wiki/Wiki.jsp?page=Openid-configuration){: target="_blank"}, you can provide the base URI or the full URI to that endpoint in the configuration:

```json
{
  "jwt": {
    "some-name": {
      "active": true,
      "providerUrl": "https://auth.example.com/auth/realms/master"
    }
  }
}
```

During initialization, Domino REST API will query this endpoint for issuer and key information to trust public keys from that service.

Some IdP, such as [Azure](../../howto/IdP/configuringAD.md), don't provide full information, missing algorithm or accurate issuer info. For them, additional parameters `aud`, `iss` and `algoritm` can be specified.

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

Alternatively, the public key and issuer information can be added to the configuration directly:

```json
{
  "jwt": {
    "some-name": {
      "active": true,
      "algorithm": "RS256",
      "iss": "https://auth.example.com/auth/realms/master",
      "kid": "id-matching-expected-key",
      "keyFile": "path-to-jwt.pubkey"
    }
  }
}
```

It's the responsibility of the administrator to save key files in secure locations.

**Note**: We have a ticket in our backlog to support the R12 certmanager feature for enhanced security and ease of cert distribution.
{: .alert .alert-info}

### JWT Payload

The JWT requires the following format (Additional entries get ignored):

```json
{
  "iss": "Issuer Name",
  "sub": "CN=Common Name/O=Org",
  "scopes": "MAIL $DATA",
  "iat": 1618506339,
  "exp": 1618509939,
  "aud": "Domino"
}
```

All elements need to be present. “Audience” must be set to “Domino” and “scope” must be a space-separated list of database aliases, MAIL, and/or $DATA.

- MAIL allows a request to attempt to access the mail file of a given user. Access is limited by Domino’s ACL entries.
- $DATA allows a request to attempt to access any database configured for Domino REST API access. Access is limited by Domino’s ACL entries. Users can only access databases that grant them access in the ACL.
<!-- - $DECRYPT (WIP) Allow to decrypt documents secured with encryption. Without that parameter no access to an ID in the ID vault is attempted. -->
- [KeepDBAliasName] allows a request to attempt to access a database configured under that alias name. Access is limited by Domino’s ACL.

### Distinguished Names

By default, Domino REST API will expect that incoming tokens contain a Domino-format distinguished name, for example `CN=John Doe/O=SomeOrg`, in either the `CN` or `sub` claims of the token payload. This can be configured in Domino REST API's JWT configuration to use an alternative property and to accept LDAP-format, for example `cn=John Doe,o=SomeOrg` names:

```json
{
  "jwt": {
    "some-name": {
      "active": true,
      "providerUrl": "https://auth.example.com/auth/realms/master",
      "userIdentifier": "dn",
      "userIdentifierInLdapFormat": true
    }
  }
}
```


### Name resolution

The Domino REST API probes for the existence of various claims in the JWT token to determine the user name. The claims are probed in the following sequence. On the first available claim, the probing stops.

1. keep.user.attr.dominoDn
2. CN
3. upn
4. preferred_username
5. email
6. sub

## OIDC

OIDC (OpenID Connect) support lets you point at a standard OIDC provider like [Azure AD](../../howto/IdP/configuringAD.md) or [Keycloak](../../howto/IdP/configuringKeycloak.md ). It's similar to the [External JWT Provider configuration](../../references/security/authentication.md#external-jwt-provider) when using `providerUrl`, but follows OIDC semantics a bit more internally - namely, it needs a client ID and client secret.


It can be configured like:

``` json
    "oidc": {
        "any-name": {
            "active": true,
            "providerUrl": "https://some.keycloak.server/auth/realms/some-realm",
            "clientId": "some-clientid",
            "clientSecret": "some-clientsecret",
            "userIdentifier": "dn",
            "userIdentifierInLdapFormat": true
        }
    }
```


The "oidc" is similar to "oidc-idpcat" or "jwt," are main configuration block. Inside, the keys can be anything, like "any-name". This is the same idea as documented in [External JWT Provider configuration](../../references/security/authentication.md#external-jwt-provider).


| Items           | Description     |
| :-------------- | :-----------------------------------|
|`active`|**Optional**, and can be useful for setting to false to temporarily disable something without deleting the config entirely. |
| `providerURL`| It's the OIDC-provider-specific URL. It's in a form common for Keycloak, but Azure and others look different.|
| `clientId`| It's the configured client ID from the OIDC provider, generally created as part of setting up Domino/DRAPI as a legal client in the config. |
|`clientSecret`| It's the generated client secret from the OIDC provider, usually a randomly-generated hex string. | 
|`userIdentifier` and `userIdentifierInLdapFormat`| **Optional**| 


### OIDC with idpcat authentication

The `OIDC idpcat` support lets you use providers configured in `idpcat.nsf` ("IdP Catalog") starting with Domino 14.

- To know more about creating `idpcat.nsf`, see [Configuring trusted OIDC providers](https://help.hcltechsw.com/domino/14.0.0/admin/secu_config_http_bearer_auth_t.html?hl=idp%2Ccatalog)

- [Configuring trusted OIDC providers](https://help.hcltechsw.com/domino/14.0.0/admin/secu_config_http_bearer_auth_t.html?hl=idp%2Ccatalog)

The configuration is as follows in Domino REST API:

```json
{
    "oidc-idpcat": {
        "any-name": {
            "active": true,
            "providerUrl": "https://some.keycloak.server/auth/realms/some-realm",
            "scope": "$DATA",
            "aud": "account",
            "additionalClientIds": ["keep-local"],
            "userIdentifier": "dn",
            "userIdentifierInLdapFormat": true,
            "microsoft": false,
            "allowExpired": false
        }
    }
}
```

| Items           | Description                          |
| :-------------- | :-----------------------------------|
| `active`   | **Optional** - Can be useful for setting to `false` to temporarily disable something without deleting the config entirely. |
| `providerURL`| It's the OIDC-provider-specific URL. It's in a form common for Keycloak, but Azure and others look different.|
| `scope`| It's the configured client ID from the OIDC provider, generally created as part of setting up Domino/DRAPI as a legal client in the config. |
|`aud`| It's the generated client secret from the OIDC provider, usually a randomly-generated hex string. | 
|`additionalClientIds`| **Optional** - Can be a string or array of strings of client IDs beyond the one configured in `idpcat.nsf` that will be considered valid.| 
|`userIdentifier` and `userIdentifierInLdapFormat`| **Optional**| 
|`microsoft`| **Optional** - Can be used to enable MS-Azure-specific workarounds internally| 
|`allowExpired`| **Optional**- Can be used to consider even expired tokens valid. This should generally only be used during development.| 

!!!note
    - You can use `oidc-idpcat` authentication in the same places that "JWT" config blocks were used previously, just with some coordination with core Domino.
    - "JWT" will work the same on Domino 14. There's no conflict if Domino REST API and Domino have completely distinct authentication providers.
    - "oidc-idpcat" comes into play if you:
        
        - Want both Domino REST API and core Domino to use the same provider.
        - You're on Domino 14 or greater. There's no harm if you use "jwt" or "oidc" without configuring Domino, or even if they happen to point to the same location.

### Differences between `oidc` and `oidc-idpcat`

In general, `oidc` and `oidc-idpcat` achieve the same goal, which is to use a complete OIDC provider. The advantages of using the "oidc-idpcat" variation are as follows:

- If you've previously configured OIDC for standard Domino, you may reuse parts of the configuration, such as putting the client ID and client secret in a single location.
- Since Domino handles contacting the OIDC provider and caching keys, you benefit from that shared cache as well as shared diagnostics (for example, using notes.ini options for extra logging on the console).

!!!note
    In general, you'd use any of these ("jwt", "oidc", "oidc-idpcat") when you either want to or have to have an external identity provider like Keycloak or Azure AD and have those tokens be usable for Domino REST API calls. Using either "jwt"-with-providerUrl or either of the "oidc" ones will let Domino REST API use standard OIDC endpoints to handle key lookup, avoiding the need to copy and paste signer keys into the Domino REST API config.

Check [Configuring `oidc-idpcat` with Domino 14](../../howto/IdP/configureidpcat.md).

## Domino REST API and OAuth

Domino REST API is designed to consume an access token. This token can be the result of an OAuth dance or simply the result of an exchange of Domino credentials. The Domino REST API provides an IdP that does the OAuth dance.

![Flow Diagram](../../assets/images/WebAuth.png)

![Flow Diagram2](../../assets/images/FlowDiagramKeep.png)
