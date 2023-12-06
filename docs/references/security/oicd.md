# OIDC - OpenID Connect
OIDC support lets you point at a standard OIDC provider like Keycloak or Azure AD. It's similar to the [External JWT Provider configuration](../../references/security/authentication.md#external-jwt-provider) when using `providerUrl`, but follows OIDC semantics a bit more internally - namely, it needs a client ID and secret.

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


The "oidc" is similar to "oidc-idpcat" or "jwt," which the the main configuration block. Inside, the keys can be anything, like "any-name". The keys inside, like "any-name" here, can be anything, this is the same idea as documented in [External JWT Provider configuration](../../references/security/authentication.md#external-jwt-provider).



