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

In the domino data directory, add the following files to configure the `NSF`, (if the `keepconfig.d` folder doesn't already exist, you may need to create it):

- [data folder]/oauth.nsf
- [data folder]/keepconfig.d/oauth.json

An example of `oauth.json` is shown below. Expiration times can be adjusted. Make sure to replace the Domino REST API URL to match your Domino REST API host (a sample URL is shown below).

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


