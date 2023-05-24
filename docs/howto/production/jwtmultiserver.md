# JWT Multi-Server
   The API uses JWT Bearer tokens for verification, but because the access tokens come from different token servers, the validation of the tokens needs to be changed. 


## Procedure:


1. Login into the Management console (Port 8889).

2. Type a name you want to call this certificate into the **Certificate Name**. No spaces or special characters.

    - for example: MultiDomain

3. Click **Create IdP certificate**.
4.  Domino REST API generates 4 files in this server's `[notesdata]/keepconfig.d` directory:

    - MultiDomain.cert.pem
    - MultiDomain.json
    - MultiDomain.private.key.pem
    - MultiDomain.public.key.pem

5. Copy these 4 files to your other Domino servers into the `[notesdata]/keepconfig.d` directory.
6. Restart Domino REST API on all servers with this new configuration and now share the same JWT keys.


