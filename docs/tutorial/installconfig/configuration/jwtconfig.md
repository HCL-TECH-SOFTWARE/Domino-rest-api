# Configure JWT

All actions in Domino REST API are secured with JWT. For starters, Domino provides a login endpoint that issues a valid JWT token to access Domino REST API in exchange for Domino credentials (user name and http password).

The Domino generated JWT:

- uses a random symmetric key that changes on every Domino REST API restart and is stored only in memory.
- works with one Domino server.
- can be disabled in Domino REST API configuration with `"disableDominoLogin" :true`.

To use a permanent JWT Key, you can use a public/private key pair that can be added to the Domino REST API configuration.

## About this task

The procedure guides in configuring Domino REST API to provide a JWT after authentication with Domino credentials.

## Procedure

1. Log in to the **Management console**.
2. On the **Management console**, enter a name that you want to call the IdP certificate into the **Certificate Name** field. There should be no spaces or special characters.

    Example: MultiDomain

3. Select the **Algorithm**, either **RSA** or **Elliptic Curve**, and then click **Create IdP Certificate**.

    Domino REST API generates an IdP certificate, a public/private key pair, and a configuration file in the `keepconfig.d` directory. Using the provided example name above, the following are generated:

    - MultiDomain.cert.pem
    - MultiDomain.json
    - MultiDomain.private.key.pem
    - MultiDomain.public.key.pem

4. Restart Domino REST API.

## Additional information

### Sharing JWT between servers

You can copy the 4 generated files to your other Domino servers in the `keepconfig.d` directory to set up Domino REST API on multiple Domino servers to use the same JWT keys and achieve single login and decryption capabilities.

### For external facing Domino servers

The Domino REST API can accept JWT tokens from multiple external providers. If you have external facing Domino servers, it's recommended you configure Domino REST API to have access to the provider’s public key. For more information, see [External JWT Provider](../../../references/security/authentication.md#external-jwt-provider)

### References

To learn more, see [JWT Authorization](../../../references/security/authentication.md#jwt-authorization) and [Encryption Keys](../../../references/security/encryption.md).
