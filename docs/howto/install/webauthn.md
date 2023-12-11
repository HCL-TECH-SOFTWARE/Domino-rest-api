# Configure WebAuthn with Domino REST API and Domino 14 or greater

The WebAuthn by default is configured in `config.json` located in the `keeponfig.d`. 

## About this task

The procedure guides you to log in to both Domino REST API and Domino 14 using the same passkey.

## Prerequisites

- You must be an administrator in Domino REST API WebUI

- You must be using Domino 14 or greater

- The passkey had been created by the administrator of Domino and saved as a passkey.nsf

## Procedure
    
1. Create a JSON file using text/code app such as VSCode, notepad, notepad++, etc.
2. Copy the JSON object named `webAuthnActive` to the JSON file.

    ```json
    {
        "webAuthnActive": true,
        "webauthn": {
            "attestation": "direct",
            "rpName": "Keep RP",
            "rpId": "domino.URL.com"
        }
    }
    ```
3. Change the value of the `rpId` parameter with the same URL configured in the Domino directory. 

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
    | `rpId`| The `rpId` is a single value only. It is important to connect it with Domino. Given the scenario where there is a single value present and multiple websites hosted by Domino, the usefulness of this will vary depending on the user's requirements. In the default case, if the user has "domino.somecompany.com" as their server and DRAPI is listening on the same hostname (although ports may differ), they can sign in with Passkey in Domino REST API and apply the same stored key on Domino HTTP, and vice versa. See [Passkey authentication](https://help.hcltechsw.com/domino/14.0.0/admin/conf_dominopasskeyauth.html) of HCL Domino. |

4. Save the file in `.json` format inside the `keepconfig.d` directory.

    !!!tip
        Use a filename for the JSON file that reveals its purpose. To learn more on how JSON files in `keepconfig.d` are processed, see [Understanding configuration](../production/configparam.md#understanding-configuration).

5. Restart Domino REST API on all servers with this new configuration.

!!!note
    - If you disable the `webAuthnActive` in the settings you won't be able to use the passkey.
    - The actual WebAuthn keys are stored in each user's device. Domino and Domino REST API store only the public-key part to verify it. 