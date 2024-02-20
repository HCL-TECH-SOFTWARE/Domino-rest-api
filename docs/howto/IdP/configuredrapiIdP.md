# Configure Domino Rest API IdP

--8<-- "keepmngtURLcaution1.md"

## About this task

Domino REST API implements an OAuth2 Provider. The following is a guide for setting up and configure Domino REST API's OAuth2 provider.

## Procedure

1. Configure Domino REST API to access that `oauth.nsf`. The DominoIDP uses the database `oauth.nsf` to store consent and refresh information. Ensure that it exists and create it if missing based on the template `oauth.nsf.` See [Set up `oauth.nsf`.](../../howto/VoltMX/setupoauthnsf.md)

2. Add `OAuthAdmin` role for the ACL entry.

    Be sure to thoroughly examine the ACL:

      - By default, the setting should be configured as `Author` with the capability to create information but unable to remove it. 
      - All servers involved must have at least `Editor` access and the `OAuthAdmin` role assigned. If you **DON'T** have this role, all you can see is your documents  or records only.
      - Administrators requiring troubleshooting capabilities should have `Editor` access and the `OAuthAdmin` role assigned. 
      - [Enforce a consistent ACL](https://help.hcltechsw.com/domino/14.0.0/admin/conf_enforcingaconsistentaccesscontrollist_t.html?hl=consistent%2Cacl)
      - Ensure the database is copied to all servers involved.



In the domino data directory, add the following files to configure the `oauth.nsf`, (if the `keepconfig.d` folder doesn't already exist, you may need to create it):

- [data folder]/oauth.nsf
- [data folder]/keepconfig.d/oauth.json

An example of `oauth.json` is shown below. Expiration times can be adjusted. Make sure to replace the Domino REST API URL to match your Domino REST API host (a sample URL is shown below).

```json
{
  "oauth": {
    "active": true,
    "database": "oauth.nsf",
    "url": "https://sample.keep.io:8880",
    "authCodeExpiresIn": 120,
    "accessTokenExpiresIn": 3600,
    "refreshTokenExpiresIn": 525600
  }
}
```


| Property        | Values Description |
| :----------------| :------------------|
| `active`         | Required. This is a boolean value indicating if the provided token is now active. If the token was issued by this authorization server, it was not revoked by the user, and it had not expired, the value should be "true". |
|  `database`      | The `nsf` file where the authorization details is stored.|
|  `url`                | Server URL|
|  `authCodeExpiresIn`  | The code expiration timestamp, in seconds. |
|  `accessTokenExpiresIn` | The access_token expiration timestamp, in seconds.|
|  `refreshTokenExpiresIn`|The refresh_token expiration timestamp, in seconds. |

!!! note
      If you are using Domino+Domino REST API docker image, the `oauth.nsf` should already be added in the image but may not be fully configured. If for some reason you need to create `oauth.nsf`, see [Set up oauth.nsf](../../howto/VoltMX/setupoauthnsf.md).






