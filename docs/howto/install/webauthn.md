# Configure Webauthn with KEEP and Domino 14

The webAuthn by default is configured in `config.json` located in the `keeponfig.d`. 

## About this task

The procedure guides you to log in to both KEEP and Domino 14 using the same passkey.

## Prerequisites

- You must be an administrator in KEEP WebUI.

- The passkey had been created by the administrator of Domino and saved as a passkey.nsf

## Procedure
    

1. Login into the Management console (Port 8889).

    Make sure that the administration location can only be accessed from a network that can be accessed by your system administrator.

2. Click the `Config` button. The actual configuration settings open. The default configuration is this: [config.json](/docs/references/parameters.md).

    Only copy the KEEP configuration where you need to change your `config.json` values in any text/code app such as VSCode, notepad, notepad++, etc.

3. Look for `webAuthnActive` and modify it. "webAuthnActive" defaults to true.

    ```json
        {
        "webAuthnActive": true,
        "webauthn": {
            "attestation": "direct",
            "rpName": "Keep RP",
            "rpId": "domino.somecompany.com"
        }
    }
    ```

    | Items           | Description                          |
    | :-------------- | :-----------------------------------|
    | `attestation`   |Can be one of "none", "indirect", "direct", or "enterprise"  |
    | `rpName`| It is a name that the user might see when logging in, depending on their user interface. The default setting is "Domino REST API IdP", whereas the core Domino HTTP stack uses the name of the website document, which could be viewed as "Production Servers" or any other chosen name.  |
    | `rpId`| It is important to connect it with Domino. Given the scenario where there is a single value present and multiple websites hosted by Domino, the usefulness of this will vary depending on the user's requirements. In the default case, if the user has "domino.somecompany.com" as their server and DRAPI is listening on the same hostname (although ports may differ), they can sign in with Passkey in DRAPI and apply the same stored key on Domino HTTP, and vice versa. |

4. Save the file in `.json` format inside the `keepconfig.d` directory.

5. Restart Domino REST API on all servers with this new configuration.

!!!note
    - The `rpId` is a single value only. 
    - If you disable the `webAuthn` in the settings you won't be able to use the passkey.
    - The actual keys in the webAuthn are stored in each user's device and Domino and KEEP store the public-key part to verify it. 