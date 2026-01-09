# JWT Multi-Server

## About this task

The API uses JWT Bearer Tokens for verification. However, because access tokens come from different token servers, the validation of tokens must be changed. 

This guide walks you through setting up Domino REST API across multiple Domino servers to use the same JWT keys.

## Before you begin

You must have access to the **Management console**.

!!! note

    - Make sure the **Management console** is secure. For more information, see [Functional Accounts](../../references/functionalUsers.md).
    - Credentials for the **Management console** aren't managed by the configured IdP, but are derived from the [configuration of functional accounts](../../references/functionalUsers.md).

## Procedure

1. Login into the Management console (Port 8889).

2. Type a name you want to call this certificate into the **Certificate Name**. No spaces or special characters.

    - for example: MultiDomain

3. Click **Create IdP certificate**.

    Domino REST API generates 4 files in this server's `[notesdata]/keepconfig.d` directory:

    - MultiDomain.cert.pem
    - MultiDomain.json
    - MultiDomain.private.key.pem
    - MultiDomain.public.key.pem

4. Copy these 4 files to your other Domino servers into the `[notesdata]/keepconfig.d` directory.

5. Restart Domino REST API on all servers with this new configuration, and they will now share the same JWT keys.
