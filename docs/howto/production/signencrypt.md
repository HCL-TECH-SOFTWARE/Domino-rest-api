# Set up Domino REST API for encryption, decryption, and signing

!!!note
    This feature is only available starting from the Domino REST API v1.1.0 release. 

Domino REST API can encrypt or decrypt document fields and sign a document with keys stored in your Notes ID file using the setup described in this topic.

## About this task

The procedure guides you in making changes to the Domino ID vault configuration, the IdP Catalog, the Domino Server configuration, the OIDC provider configuration, and the Domino REST API configuration to enable Domino REST API to encrypt or decrypt document fields and sign a document.

## Before you begin

- You have Domino 14 or later.
- IDs are stored in an ID Vault.
- Domino is configured with an OIDC provider.

## Procedure
  
!!!note
    The steps require you to define your OIDC provider for Domino REST API. In this case, we'll be using an existing Keycloak installation. If you haven't yet set up Keycloak, see [Configure Keycloak](../IdP/configuringKeycloak.md) before proceeding.

### 1. Configure Keycloak.

You need to make some modifications in your Keycloack installation to allow access to the IDs in the ID Vault.

1. In Keycloack, choose the realm you created as part of the Keycloak setup and then go to **Client Scopes**.
1. Create a client scope.
    1. Click **Create client scope**.
    1. Set the **Name** to *Domino.user.all*.
    1. Click the **Include in token scope** toggle to the on position.
    1. Click **Save**.
1. Create another client scope.
    1. Go back to **Client Scopes** and click **Create client scope**.
    1. Set the **Name** to *Domino.vault.{DominoOrg}-O={VaultName}*.
    
        where: 
        - *DominoOrg* is the organization the members of your vault are part of.
        - *VaultName* is the name of the ID vault that contains those members IDs.  
    
    1. Click the **Include in token scope** toggle to the on position.
    1. Click **Save**.

1. Add a mapper.
    1. After saving, you will see the **Mappers** tab. Click it.
    1. Click **Add Mapper** and then **Configure a new mapper**.
    1. In the **Configure a new mapper** dialog, select **Audience**.
    1. Set the **Name** to *VaultAud*.
    1. Set **Included Custom Audience** to *{DominoOrg}-O={VaultName}*.
    1. Click the **Add to ID token** toggle to the on position.
    1. Click **Save**.

1. Add the scopes to the client.
    1. Click **Clients** in the left navigator.
	1. Select the client you created as part of the Keycloak setup.
	1. Click the **Client Scopes** tab.
	1. Click **Add client scope**.
	1. Select the 2 scopes you just created.
	1. Click **Add**, and then select **Default**.

1. Take note of needed information.
    - Get the Client name.
        1. Click **Clients** in the left navigator.
        1. Find the name of the client you created previously.
    - Get the Client Secret.
        1. Clicking **Clients** and then select your Client.
        1. Click the **Credentials** tab. 
        1. In the **Client Secret** field, click the **Copy to clipboard** icon to copy to clipboard the client secret.
    - Get the Base URL.
        1. Go to **Realm settings**.
        1. At the bottom of the **General** tab, click the `OpenID Endpoint Configuration` link. A JSON will display. 
        1. Find the key `"issuer"`, it's value is the value of the Base URL.  


### 2. Update `notes.ini`. 

- Add `$$TEST_JWTIDVAULT=1` to the Domino Administrator client's notes.ini and restart Domino Administrator. This is necessary for certain functionalities to be exposed.

### 3. Configure Domino.

1. Go to **People / Policies / Settings** and edit the **Security Settings** document for the vault.  
  
    1. Set `Allow Notes-based programs to use the Notes ID Vault` to `Yes`.
    2. Set `Bearer token (JWT)` to `Yes`
    3. Save and close.

2. Go to **Configuration / Web / Internet sites** and edit the website document for this host.
  
    !!!note
        You must have an Internet site document for this specific hostname and not use the `DEFAULT_SITE` configuration.
  
    1. Go to the `Security` tab and set `Bearer token (JWT)` to `Yes`.
    2. Save and close.

3. Open the IdP Catalog (idpcat.nsf) and click `OIDC Providers` in the navigator. 
    
    1. If you have an existing OIDC provider, edit that document; otherwise, create a new document.
    2. In `Host Name or addresses mapped to this site`, this should contain your site's host address that you should be able to select with the dropdown, but then add `; bearer.vault.{Same host address}`.
    
        **Example**: `my.site.com; bearer.vault.my.site.com`  
        
        !!!note
            Make sure to note the bearer.vault address as it will be used in the ID Vault.
  
    1. The Provider name can be anything. As an example, you can call it `keycloak`.
    1. The Base URL is the URL you took earlier from Keycloak, typically in the form https://keycloakserver/realms/yourrealm.
    1. The `Client ID` is the client name you took earlier from Keycloak.
    1. The `Client secret` is the client secret you took earlier from Keycloak.
    1. Set `Client authentication type` to `Private key JWT`.
    1. Save and close.

4. Open the ID Vault database itself.
    
    1. Click Configuration in the left hand navigator.
    2. Edit the Vault configuration document.
    3. Set the `Bearer token (JWT) approved OIDC provider configurations` with the same `bearer.vault` that you entered in the IdP catalog.
    
        **Example**: `bearer.vault.my.site.com`
    
    4. Save and close.
  
### 4. Configure Domino REST API.

When you configured Keycloak using the documentation, it had you set a configuration setting in the `keepconfig.d` directory. You'll be modifying this same file because it needs to change a little based on the following configuration. If you didn't create this configuration, create a new JSON file in `keepconfig.d` that contains the following configuration.

```json
{
  "oidc-idpcat": {
    "yourRealm": {
	  "active": true,
      "providerUrl": "https://keycloakserver/realms/yourRealm",
	  "scope" : "$DATA",
	  "aud" : "Domino",
	  "additionalClientIds" : [
		"yourClient"
	  ]
    }
  }
}
```

- The `jwt` object from the [Keycloak documentation](../IdP/configuringKeycloak.md) is changed to `oidc-idpcat`.
- The `providerUrl` is the Base URL you took earlier from Keycloak.
- The `additionalClientIds` array should contain the client name you took earlier from Keycloak.

### 5. Restart Domino. 

You need to restart Domino. 