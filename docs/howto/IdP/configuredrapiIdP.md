# Configure Domino Rest API IdP

--8<-- "keepmngtURLcaution1.md"

## About this task

Domino REST API implements what essentially amounts to an OAuth2 Provider. The following is a guide for setting up Domino REST API's OAuth2 provider.

## Procedure

<!-- prettier-ignore -->
!!! warning "Caution"
     This is subject to change. Consult Domino REST API documentation (or code, or experts) for the latest steps. Currently, these general steps must be performed:

1. Deploy `oauth.nsf` and configure Domino REST API to recognize that file.
2. Add `OAuthAdmin` role for the ACL entry that gives your server manager access to the `oauth.nsf`.

To deploy and configure the NSF, place the following in the domino data directory (you may need to create the `keepconfig.d` folder if it doesn't already exist):

- [data folder]/oauth.nsf
- [data folder]/keepconfig.d/oauth.json

An example of `oauth.json` is shown below. Expiration times can be adjusted. Make sure to replace the Domino REST API URL to match your Domino REST API host (a fictitious Quickstart Domino REST API url is shown in this example.).

```json
{
  "oauth": {
    "active": true,
    "database": "oauth.nsf",
    "url": "http://https://sample.keep.io:8880",
    "authCodeExpiresIn": 120,
    "accessTokenExpiresIn": 3600,
    "refreshTokenExpiresIn": 525600
  }
}
```
| Property         | Values Description                                                              |
| :----------------| :------------------------------------------------------------------------ |
| `active`         | Required. This is a boolean value indicating if the provided token is now active. If the token was issued by this authorization server, it was not revoked by the user, and it had not expired, the value should be "true". |
|  `database`      | The `nsf` file where the authorization details is stored.|
|  `url`                | Server URL|
|  `authCodeExpiresIn`  | The code expiration timestamp, in seconds. |
|  `accessTokenExpiresIn` | The access_token expiration timestamp, in seconds.|
|  `refreshTokenExpiresIn`|The refresh_token expiration timestamp, in seconds. |

!!! note
      If you are using Domino+Domino REST API docker image, the `oauth.nsf` should already be "deployed" in the image but may not be fully configured. If for some reason you need to create `oauth.nsf`, see [Set up oauth.nsf](../VoltMX/setupoauthnsf.md).


