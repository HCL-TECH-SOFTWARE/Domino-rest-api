# Setup External Idp for Office Round Trip Experience

Aside from the default Domino REST API login page, you can also use your configured external IdP for Office round trip experience log in.

## Configuration

### Set up External IdP

Configure your external IdP in the configuration file. Please refer to [configuring external IdP](../IdP/index.md) for more details in configuring an external IdP of your choice.

!!!note
    When configuring your external IdP, it is required to set the following as one of your redirect URIs: `{{origin}}/api/webdav-v1/login/callback`

### Set up OFBA configuration

To set this up, first you need to configure `ofba` property in your chosen external IdP. Please refer to [JWT parameters](../../references/parameters.md#jwt-parameters).

## OFBA log in

Once configured properly, the log in UI for OFBA should look like the following:

![OFBA external IdP log in UI](../../assets/images/OfbaExternalIdp.png)

Clicking `Sign in with {external_idp_name}` should commence the authorization code flow.

!!!note
    Office round trip experience external IdP login makes use of authorization code flow with PKCE.

## Examples

### Azure

The following is an example configuration for Azure IdP:

```json
{
  "jwt": {
    "AzureIdP": {
      "active": true,
      "providerUrl": "https://login.microsoftonline.com/{tenant_id}/v2.0/.well-known/openid-configuration",
      "aud": "{client_id}",
      "iss": "https://login.microsoftonline.com/{tenant_id}/v2.0",
      "algorithm": "RS256",
      "ofba": {
        "active": true,
        "client_id": "{client_id}",
        "application_id_uri": "api://dominorest/",
        "scope": ["$DATA"]
      }
    }
  }
}
```

### Keycloak

The following is an example configuration for Keycloak IdP:

```json
{
  "jwt": {
    "KeycloakIdP": {
      "active": true,
      "providerUrl": "https://{keycloak_host}/realms/{realm_name}",
      "ofba": {
        "active": true,
        "client_id": "{client_id}",
        "scope": ["$DATA"]
      }
    }
  }
}
```
