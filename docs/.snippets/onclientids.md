## Client Ids

When configuring an external identity provider using OpenID Connect (OIDC) or OIDC-idpcat with HCL Domino and the Domino REST API, you must specify a client ID. The default recommendation is to use `Domino` as the client ID for the Domino REST API server. However, your identity provider administrator might require a different value depending on your organization’s configuration.

Separate client IDs (application registrations) are required to support the Admin UI and Office Forms Based Authentication (OFBA). To support these features, configure at least the following clients in your identity provider:

- A client used by the Domino REST API server. You can name the client `Domino` or any descriptive name. The client secret might be managed through `idpcat.nsf`.
- A client used by the Domino REST API Admin UI. You can name the client `keepadminui` or any descriptive name. Configure this client if you want administrators to authenticate through the external identity provider.
- A client used for OFBA round-trip editing of Office documents. You can name the client `keepofba` or any descriptive name.

You should also create separate clients for each custom application that connects to the Domino REST API.
<!--
- Use a client secret for server-side applications.
- Use PKCE for public or browser-based clients.
-->
<!--
When configuring an external IdP using OIDC or OIDC-idpcat, you need to provide a clientId. It's recommended to use `Domino`, but the admins of your IdP might have other ideas. In any case, that's the clientId for the REST server. It's _NOT_ the one for the Admin UI or the Office Forms Based Authentication (OFBA) for attachment editing. To be fully operational, you need to configure at least three clients on your IdP:

- `Domino` for the server (client secret might be handeled by `idpcat.nsf`).
- `keepadminui` for the Domino REST API admin client. If you also want to use your IdP for Domino REST API Admin UI login.
- `keepofba` for the Office document round trip experience. If you also want to use your IdP for Domino REST API OFBA round trip editing authentication.
- One each for your custom client applications (with clientSecret for servers or PKCE for clients).

!!! tip "Use the internal IdP as learning resource"

    The application configuration provided by the internal IdP makes it easy to configure and retrieve client-specific JWT that have all the required fields. Test your application with that and use the defined properties, scopes foremost, to requests the external
    IdP client configurations.
-->