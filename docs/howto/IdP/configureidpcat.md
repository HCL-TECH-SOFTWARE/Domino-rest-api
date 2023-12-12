# Configure Domino REST API to use Domino's IdP Provider in Domino 14 or greater

## About this task

The procedure guides you on how to configure Domino REST API to use the same IdP Provider as Domino.

## Prerequisite

- You have created an `idpcat.nsf` on your Domino Server. For more information, see [Creating and replicating the IdP Catalog](https://help.hcltechsw.com/domino/14.0.0/admin/secu_creating_the_idp_catalog.html?hl=idp%2Ccatalog){: target="_blank" rel="noopener noreferrer"}.
- You have [configured a trusted OIDC provider](https://help.hcltechsw.com/domino/14.0.0/admin/secu_config_http_bearer_auth_t.html?hl=idp%2Ccatalog){: target="_blank" rel="noopener noreferrer"}.
- You must be using Domino 14 or greater.

## Procedure

1.	Create a JSON file using a text editor.
2.	Copy the JSON object to the JSON file.

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

3.	Change the value of the `providerUrl` parameter the same url when you configured  in `idpcat.nsf` ("IdP Catalog") Domino 14.

    ``` json
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
    ```


4.	Save the JSON file in the `keepconfig.d` directory.

    !!!tip
        Use a filename for the JSON file that reveals its purpose. To learn more on how JSON files in `keepconfig.d` are processed, see [Understanding configuration](../production/configparam.md#understanding-configuration).

5.	Restart Domino REST API on all servers.