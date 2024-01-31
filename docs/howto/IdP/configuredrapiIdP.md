# Configure Domino Rest API IdP

--8<-- "keepmngtURLcaution1.md"

## About this task

Domino REST API implements what essentially amounts to an OAuth2 Provider. The following is a guide for setting up Domino REST API's OAuth provider.

## Procedure

<!-- prettier-ignore -->
!!! warning "Caution"
     This is subject to change. Consult Domino REST API documentation (or code, or experts) for the latest steps. Currently, these general steps must be performed:

1. Deploy `oauth.nsf` and configure Domino REST API to recognize that file.
1. Add `OAuthAdmin` role for the ACL entry that gives your server manager access to the `oauth.nsf`.

To deploy and configure the NSF, place the following in the domino data directory (you may need to create the keepconfig.d folder if it doesn't already exist):

- [data folder]/oauth.nsf
- [data folder]/keepconfig.d/oauth.json

An example of `oauth.json` is shown below. Expiration times can be adjusted. Make sure to replace the Domino REST API URL to match your Domino REST API host (a fictitious Quickstart Domino REST API url is shown in this example.).

```json
{
  "oauth": {
    "active": true,
    "database": "oauth.nsf",
    "url": "http://yourquickstarthost-qs-keep-8880.qs.hcllabs.net",
    "authCodeExpiresIn": 120,
    "accessTokenExpiresIn": 3600,
    "refreshTokenExpiresIn": 525600
  }
}
```

<!-- prettier-ignore -->
!!! note
      If you are using Domino+Domino REST API docker image, the `oauth.nsf` should already be "deployed" in the image but may not be fully configured. If for some reason you need to create `oauth.nsf`, see [Set up oauth.nsf](../VoltMX/setupoauthnsf.md).


# Configure Domino Rest API IdP



## About this task

Domino REST API implements what essentially amounts to an OAuth2 Provider. The following is a guide for setting up Domino REST API's OAuth provider.

## Procedure

<!-- prettier-ignore -->
!!! warning "Caution"
     This is subject to change. Consult Domino REST API documentation (or code, or experts) for the latest steps. Currently, these general steps must be performed:

1. Deploy `oauth.nsf` and configure Domino REST API to recognize that file.
1. Add `OAuthAdmin` role for the ACL entry that gives your server manager access to the `oauth.nsf`.

To deploy and configure the NSF, place the following in the domino data directory (you may need to create the keepconfig.d folder if it doesn't already exist):

- [data folder]/oauth.nsf
- [data folder]/keepconfig.d/oauth.json

An example of `oauth.json` is shown below. Expiration times can be adjusted. Make sure to replace the Domino REST API URL to match your Domino REST API host (a fictitious Quickstart Domino REST API url is shown in this example.).

```json
{
  "oauth": {
    "active": true,
    "database": "oauth.nsf",
    "url": "http://yourquickstarthost-qs-keep-8880.qs.hcllabs.net",
    "authCodeExpiresIn": 120,
    "accessTokenExpiresIn": 3600,
    "refreshTokenExpiresIn": 525600
  }
}
```

<!-- prettier-ignore -->
!!! note
      If you are using Domino+Domino REST API docker image, the `oauth.nsf` should already be "deployed" in the image but may not be fully configured. If for some reason you need to create `oauth.nsf`, see [Set up oauth.nsf](../VoltMX/setupoauthnsf.md).