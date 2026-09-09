A few tips to troubleshoot setup issues when changing configuration endpoints:

- Decode the JWT payload.

    - Option 1: Paste your JWT token into [JWT.io](https://jwt.io) to inspect the payload.
    - Option 2: If your company policy restricts using external websites, extract the string between the two dots (`.`) in your JWT token and run:

        ```bash
        echo [the string] | base64 --decode | jq
        ```

        !!! note

            The `| jq` is optional and used only for formatted JSON output. 

- Compare the `iss` value in your JWT token with the `issuer` value from the `openid-configuration` endpoint. If they do not match, add the `iss` value to your configuration file in `keepconfig.d`.

- Compare the `aud` value in your JWT token with the `aud` value defined in your configuration file. Update the configuration file if there is any mismatch.

- Check the scope (`scp` or `scope`) claim to ensure it contains the expected values matching the settings in the application configuration in the **Admin UI**. If values are missing or incorrect, update the scope in either your Domino REST API application in the **Admin UI** or within your IdP's application settings.
