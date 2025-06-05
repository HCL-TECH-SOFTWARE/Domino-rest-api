# Configure JWT

All actions in Domino REST API are secured with JSON Web Token (JWT). Domino REST API offers a built-in endpoint to exchange your Domino credentials for a valid JWT.

The Domino generated JWT:

- uses a random symmetric key that changes on every Domino REST API restart and is stored only in memory.
- works with one Domino server.
- can be disabled in Domino REST API configuration with `"disableDominoLogin" :true`.

Domino REST API can also accept JWT tokens from multiple external providers.

## About this task

This task guides you in configuring Domino REST API to

- use a permanent JWT after authentication with Domino credentials

    OR

- accept and use JWT tokens from multiple external providers

## Procedures

### Use a permanent JWT key

This procedure enables you to use a public/private key pair and add it to the Domino REST API configuration to use a permanent JWT key.

1. Log in to the **Management console**.
2. On the **Management console**, enter a name that you want to call the IdP certificate into the **Certificate Name** field. There should be no spaces or special characters.

    Example: MultiDomain

3. Select the **Algorithm**, either **RSA** or **Elliptic Curve**, and then click **Create IdP Certificate**.

    Domino REST API generates an IdP certificate, a public/private key pair, and a configuration file in the `keepconfig.d` directory. Using the provided example name, the following files are generated:

    - MultiDomain.cert.pem
    - MultiDomain.json
    - MultiDomain.private.key.pem
    - MultiDomain.public.key.pem

4. Restart Domino REST API.

### Use JWT tokens from external providers

!!! note

    This configuration is strongly recommended for outward facing Domino servers.

To use JWT tokens from an external provider, Domino REST API requires access to the provider’s public key. This can be done in two ways:

- One way is to provide the base URI or the full URI to the [`/.well-known/openid-configuration` endpoint](https://ldapwiki.com/wiki/Wiki.jsp?page=Openid-configuration){: target="_blank"} in the configuration, if your external provider supports the [`/.well-known/openid-configuration` endpoint](https://ldapwiki.com/wiki/Wiki.jsp?page=Openid-configuration){: target="_blank"}.

    1. Create a JSON file using a text editor.
    2. Copy the JSON object to the JSON file and update it with the correct values to provide the base URI or the full URI to the endpoint.

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

    3. Save the JSON file in the `keepconfig.d` directory.
    4. Restart Domino REST API.

    During initialization, Domino REST API will query this endpoint for issuer and key information to trust public keys from that service.

    Some IdP, such as [Microsoft Entra ID formerly Azure Active Directory](../../../howto/IdP/configuringAD.md), don't provide full information, missing algorithm or accurate issuer info. For them, additional parameters `aud`, `iss` and `algoritm` can be specified as shown below:

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

- The other way is to directly add the public key and issuer information to the configuration.

    1. Create a JSON file using a text editor.
    2. Copy the JSON object to the JSON file and update it with the correct values to public key and issuer information.

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

    3. Save the JSON file in the `keepconfig.d` directory.
    4. Restart Domino REST API.

!!! tip

    It's the responsibility of the administrator to save key files in secure locations.

## Additional information

### Sharing JWT between servers

If you used [the permanent JWT key](#use-a-permanent-jwt-key), you can copy the 4 generated files to your other Domino servers in the `keepconfig.d` directory to set up Domino REST API on multiple Domino servers to use the same JWT keys and achieve single login and decryption capabilities.

### Related information

- To learn more about *JWT payload*, *distinguished names*, and *name resolution*, see [Auth*](../../../references/security/authentication.md).
- To learn more about areas in Domino REST APi that need encryption keys and how to generate those keys, see [Encryption Keys](../../../references/security/encryption.md).

## Next step

Proceed to [Manage databases](admingroup.md).
<!--
### JWT Payload

The JWT requires the following format. Additional entries get ignored.

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

All elements need to be present. *Audience* must be set to “Domino” and “scope” must be a space-separated list of database aliases, `MAIL`, and/or `$DATA`.

- `MAIL` allows a request to attempt to access the mail file of a given user. Access is limited by Domino’s ACL entries.
- `$DATA` allows a request to attempt to access any database configured for Domino REST API access. Access is limited by Domino’s ACL entries. Users can only access databases that grant them access in the ACL.
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

The Domino REST API probes for the existence of various claims in the JWT token to determine the username. The claims are probed in the following sequence. On the first available claim, the probing stops.

1. keep.user.attr.dominoDn
2. CN
3. upn
4. preferred_username
5. email
6. sub

### References

To learn more, see [JWT Authorization](../../../references/security/authentication.md#jwt-authorization) and [Encryption Keys](../../../references/security/encryption.md).
-->