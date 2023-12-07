# OIDC - OpenID Connect

OIDC support lets you point at a standard OIDC provider like Keycloak or Azure AD. It's similar to the [External JWT Provider configuration](../../references/security/authentication.md#external-jwt-provider) when using `providerUrl`, but follows OIDC semantics a bit more internally - namely, it needs a client ID and client secret.


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


The "oidc" is similar to "oidc-idpcat" or "jwt," which the the main configuration block. Inside, the keys can be anything, like "any-name". This is the same idea as documented in [External JWT Provider configuration](../../references/security/authentication.md#external-jwt-provider).


| Items           | Description     |
| :-------------- | :-----------------------------------|
|`active`|**Optional**, and can be useful for setting to false to temporarily disable something without deleting the config entirely. |
| `providerURL`| It is the OIDC-provider-specific URL. It's in a form common for Keycloak, but Azure and others look different.|
| `clientId`| It is the configured client ID from the OIDC provider, generally created as part of setting up Domino/DRAPI as a legal client in the config. |
|`clientSecret`| It is the generated client secret from the OIDC provider, usually a randomly-generated hex string. | 
|`userIdentifier` and `userIdentifierInLdapFormat`| **Optional**| 


## OIDC with idpcat

The `OIDC idpcat` support lets you use providers configured in `idpcat.nsf` ("IdP Catalog") starting with Domino 14.

This is the configuration:

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
| `providerURL`| It is the OIDC-provider-specific URL. It's in a form common for Keycloak, but Azure and others look different.|
| `scope`| It is the configured client ID from the OIDC provider, generally created as part of setting up Domino/DRAPI as a legal client in the config. |
|`aud`| It is the generated client secret from the OIDC provider, usually a randomly-generated hex string. | 
|`additionalClientIds`| **Optional** - Can be a string or array of strings of client IDs beyond the one configured in `idpcat.nsf` that will be considered valid.| 
|`userIdentifier` and `userIdentifierInLdapFormat`| **Optional**| 
|`microsoft`| **Optional** - Can be used to enable MS-Azure-specific workarounds internally| 
|`allowExpired`| **Optional**- Can be used to consider even expired tokens valid. This should generally only be used during development.| 

!!!note
    - You can use `oidc-idpcat` authentication in the same places that "JWT" config blocks were used previously, just with some coordination with core Domino.
    - "JWT" will work the same on Domino 14. There's no conflict if DRAPI and Domino have completely-distinct authentication providers.
    - "oidc-idpcat" comes into play if you:
        
        - Want both DRAPI and core Domino to use the same provider.
        - You're on Domino 14+. There's no harm if you use "jwt" or "oidc" without configuring Domino, or even if they happen to point to the same location.

## Differences between `oidc` and `oidc-idpcat`

In general, `oidc` and `oidc-idpcat` achieve the same goal, which is to use a complete OIDC provider. The advantages of using the "oidc-idpcat" variation are as follows:

- If you've previously configured OIDC for standard Domino, you may reuse parts of the configuration, such as putting the client ID and client secret in a single location.
- Since Domino handles contacting the OIDC provider and caching keys, you benefit from that shared cache as well as shared diagnostics (for example, using notes.ini options for extra logging on the console).

!!!note
    In general, you'd use any of these ("jwt", "oidc", "oidc-idpcat") when you either want to or have to have an external identity provider like Keycloak or Azure AD and have those tokens be usable for DRAPI API calls. Using either "jwt"-with-providerUrl or either of the "oidc" ones will let Keep use standard OIDC endpoints to handle key lookup, avoiding the need to copy and paste signer keys into the DRAPI config.

To configure `oidc-idpcat` for Domino 14, please see the following link: [How to configure `oidc-idpcat` with Domino 14](../../howto/IdP/configureidpcat.md)