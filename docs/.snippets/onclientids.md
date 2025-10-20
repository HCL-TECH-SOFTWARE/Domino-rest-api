## Client Ids

When configuring an external IdP using OIDC or OIDC-idpcat, you need to provide a clientId. It's recommended to use `Domino`, but the admins of your IdP might have other ideas. In any case, that's the clientId for the REST server. It's _NOT_ the one for the Admin UI or the Office Forms Based Authentication (OFBA) for attachment editing. To be fully operational, you need to configure at least three clients on your IdP:

- `Domino` for the server (client secret might be handeled by `idpcat.nsf`).
- `keepadminui` for the Domino REST API admin client. If you also want to use your IdP for Domino REST API Admin UI login.
- `keepofba` for the Office document round trip experience. If you also want to use your IdP for Domino REST API OFBA round trip editing authentication.
- One each for your custom client applications (with clientSecret for servers or PKCE for clients).

!!! tip "Use the internal IdP as learning resource"

    The application configuration provided by the internal IdP makes it easy to configure and retrieve client-specific JWT that have all the required fields. Test your application with that and use the defined properties, scopes foremost, to requests the external
    IdP client configurations.
