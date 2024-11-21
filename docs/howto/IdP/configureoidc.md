# Configure Domino REST API to use an OIDC provider

## About this task

The procedure guides you on how to configure Domino REST API to use an **OpenID Connect (OIDC)** provider for authentication.

## Procedure

1.	Create a JSON file using a text editor.
2.	Copy the JSON object to the JSON file.

    ``` json
    {
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
    }
    ```

3.	Set the values of the `providerUrl`, `clientId`, and `clientSecret` parameters to the values from your identity provider (e.g. Keycloak).

    ``` json
    {
        "oidc": {
            "any-name": {
                "active": true,
                "providerUrl": "https://some.keycloak.server/auth/realms/some-realm",
                "clientId": "a3fe24-88dd-a003d3",
                "clientSecret": "16072d-cf96-1ea8d9",
                "userIdentifier": "dn",
                "userIdentifierInLdapFormat": true
            }
        }
    }
    ```


4.	Save the JSON file in the `keepconfig.d` directory.

    !!!tip
        Use a filename for the JSON file that reveals its purpose. To learn more on how JSON files in `keepconfig.d` are processed, see [Understanding configuration](../production/configparam.md#understanding-configuration).

5.	Restart Domino REST API on all servers.