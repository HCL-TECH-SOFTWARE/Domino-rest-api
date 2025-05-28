# Configure Domino Rest API IdP

## About this task

Domino REST API implements an OAuth2 provider. The following is a guide for setting up and configuring Domino REST API's OAuth2 provider.

## Before you begin

The `oauth.nsf` database exists in your Domino data directory. The Domino IdP uses the `oauth.nsf` to store content and refresh information.

!!! note - If you are using Domino+Domino REST API docker image, the `oauth.nsf` should already be in the image but may not be fully configured.

      - If for some reason you need to create the `oauth.nsf`, see [Set up oauth.nsf](../../howto/VoltMX/setupoauthnsf.md), and save it in your Domino data directory.

## Procedure

1. Configure Domino REST API to access the `oauth.nsf`.

   1. Create an `oauth.json` file using a text editor.
   2. Copy the following JSON object to the JSON file.

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

      For more information, see the following table:

      | Property                | Description                                                                                                                                                                                                                     |
      | :---------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
      | `active`                | **Required** <br><br>Has a boolean value indicating if the provided token is now active. If the token is issued by this authorization server, it isn't revoked by the user, and is not yet expired, the value should be `true`. |
      | `database`              | The `nsf` file where the authorization details are stored.                                                                                                                                                                      |
      | `url`                   | Server URL                                                                                                                                                                                                                      |
      | `authCodeExpiresIn`     | The code expiration time in seconds                                                                                                                                                                                             |
      | `accessTokenExpiresIn`  | The access token expiration time in seconds                                                                                                                                                                                     |
      | `refreshTokenExpiresIn` | The refresh token expiration time in seconds                                                                                                                                                                                    |

   3. Change the value of the `url` parameter to match your Domino REST API host.

      !!!note
      The indicated `url` value in the JSON object above is just an example value.

   4. **(Optional)** Adjust the expiration time values as needed.
   5. Save the JSON file in the `keepconfig.d` directory located in your Domino data directory.

      !!!note
      You need to create the `keepconfig.d` directory if not yet existing.

   6. Restart Domino REST API.

2. Add the `OAuthAdmin` role for the ACL entry.

   Be sure to thoroughly examine the ACL:

   - By default, the configured access level is `Author` with the capability to create information but unable to remove it.
   - All servers involved must have at least an `Editor` access level and the `OAuthAdmin` role assigned. If you **DON'T** have this role, you'll only see your documents or records.
   - Administrators requiring troubleshooting capabilities should have `Editor` access level and the `OAuthAdmin` role assigned.

   - [Enforce a consistent ACL](https://help.hcltechsw.com/domino/14.0.0/admin/conf_enforcingaconsistentaccesscontrollist_t.html?hl=consistent%2Cacl).
   - Ensure the database is copied to all servers involved.
