# Configure Keycloak

--8<-- "keepmngtURLcaution1.md"

[Keycloak](https://www.keycloak.org/) is an Open Source Identity and Access Management sponsored by [RedHat](https://www.redhat.com/en).

Keycloak can be used to produce JWT Access Token for Domino REST API. Keycloak has many features like in its default configuration, Use Federation, Identity Brokering or Social Login. Those are topics not covered here, you want to consult a [Keycloak Tutorial](https://duckduckgo.com/?q=keycloak+tutorial&ia=web) or the [Keycloak documentation](https://www.keycloak.org/documentation) to learn more. This page focuses on the settings required for Domino REST API.

## About this task

This section describes key concepts and provides the steps required to configure Keycloak successfully for Domino REST API (it can be used for classic Domino SAML as well).

## Keycloak concepts

Listing only relevant concepts:

![Keycloak concepts](../../assets/images/KeycloakConcepts.png)

- **Realm**: The starting point for Keycloak identity management, contains all other elements.
- **Client**: Each accessing application, client app, Single Page App or server app will have a client entry. The client entry contains application Id and, if required, the application secret.
- **Client Scopes**: Attributes and properties available and/or assigned to client entries.
- **Mapper**: Configuration entry to determine what information is available in a client scope.

Not listed: Users

We will create a realm, an user, two clients (one for a SPA, one for a server based app), a client scope for shared settings and a few mappers.

## Procedure

1. Login to Keycloak. 
2. Click the `Master` dropdown and click **Creater Realm**. 

    ![alt text](../../assets/images/keycloak1.png)
  
    a. Fill in the **Realm Name**. For example **Ameca**.

      ![alt text](../../assets/images/keyname.png)
    
    b. Click **Create**.

3. Click **Realm settings**. 

    a. Fill in the minimum information. Always check your **Realm name**.

      ![alt text](../../assets/images/keyrealmset.png)

    b. Click **Save**.

4. Click **Users**.

    ![alt text](../../assets/images/keyusers.png)
    
    1. Click **Create a new user**. In a production environment you probably would connect to an existing LDAP or Active Directory server. Check the documentation for details about that.

    2. Fill in the minimum information.

          ![alt text](../../assets/images/keyuser1.png)

    3. Click **Create**. The user has been created.

          ![alt text](../../assets/images/keyuserdetail.png)

    4. Click the **Attributes** tab.

        ![alt text](../../assets/images/keyuserdetail.png)
    
        **Note:** To make it compatible with Domino and Domino REST API, you need the X500 style **distinguished name** of the user. This name can be in either "LDAP" format (comma-delimited) or "Domino" format (slash-delimited).
              
          1. Fill in the `Key` field. For example,`dominoDN`. In your environment it might have a different name, which you later need to use in the mapper.

          2. Fill in the `value` field.

             ![alt text](../../assets/images/keyuserattr.png)  

5. Create client scope. Named it as `keepcommon`, which will contain the settings that are common to all clients (a.k.a apps) accessing Domino REST API.

    ![alt text](../../assets/images/keyclientscope.png)

    1. Fill in the name. Named it as `keepcommon`, which will contain the settings that are common to all clients (a.k.a apps) accessing Domino REST API. 

    2. Enter *Description*.

    3. Change the *Type* field into `Default`.

    4. Turn `On` the toggle on *Display on Consent screen*. 
    5. Turn `Off` toggle on *Include in token scope*.
    6. Click *Save*. Once you save, there are two additonal tab that's been added.
    
      ![alt text](../../assets/images/keyclientscopename.png)

    7. Click the **Mappers** tab, and click **Configure a new mapper**.
        
      ![alt text](../../assets/images/keycmapper.png)

       Add two mappers for `aud` and for the distinguished name. Here, the name is mapped to the standard claim `sub`, but it can be mapped to a different name if desired.

       Mapper-1

          1. Click the **Audience** mapping in the list.
          2. Fill in the name, for example `keep-audience`.
          3. Fill in the *Included Custom Audience* with `Domino`.
          4. Turn `off` the toggle on *Add to ID token*. 
          5. Turn `on` toggle on *Add to access token*.
          6. Click **Save**.

             ![alt text](../../assets/images/keymapper1.png)

       Mapper-1

          1. Click the **User Attribute** mapping in the list.
          2. Fill in the name, for example `keep-subject`.
          3. Fill in the *User Attribute*
          3. Fill in the *Token Claim Name* with `sub`.
          4. Choose `string`from the dropdown menu of *Claim JSON Type*
          5. Turn `on` toggle on *Add to access token*.
          6. Click **Save**.

             ![alt text](../../assets/images/keymapper2.png)    

6. Click **Client** and click **Create client**.    

    ![alt text](../../assets/images/keycreateclient.png)

    The example below is for an application server that can present a client id and a client secret. An example for a SPA (that can't keep a secret) follows further down.

    1. Fill in *Client type* and *Client ID*, and click **Next**. 

       ![alt text](../../assets/images/keyclientid.png)

    2. Turn `on` toggle for *Client authentication*.

      ![alt text](../../assets/images/keycauthen.png)       
    
    3. Click **Save**. This save hav

    4. On *Access setting* tab, fill in the *Valid redirect URIs* with URI of your current application and click *Save*.

       ![alt text](../../assets/images/keyURI.png)



Next step is to assign the client the common client scopes `keep-common` and `offline_access` (this one for the refresh token). Remove the **Assigned Optional Client Scopes** first, so they become available in **Available Client Scopes**.

![Keycloak Client 3/3](../../assets/images/Keycloak-08a.png)

## Application specific scopes

The configuration so far will identify a user presenting the access token to Domino REST API, but not yet provide any access. We need to specify what scopes this application will be allowed to access. We can use any of the global scopes `MAIL`, `$DATA` or `$DECRYPT` or, preferably, a lowercase database alias. Multiple scopes are separated using a space.

<!-- prettier-ignore -->
!!! note
    It's best practice to give an external application as little as possible access so it can function. So think twice before allowing any of the uppercase general scopes.

The Mapper for the client is individual per application (client):

![Keycloak Application scope](../../assets/images/Keycloak-08b.png){: style="height:80%;width:80%"}

Finally we can verify that an access token has all the required attributes:

![Keycloak Application scope](../../assets/images/Keycloak-08c.png){: style="height:80%;width:80%"}

## SPA applications

An SPA (Single Page App) or a mobile client can't keep a client secret. For those, the use of Proof Key for Code Exchange (PKCE) (defined in [RFC 7636](https://tools.ietf.org/html/rfc7636)) is recommended (read [this intro](https://auth0.com/docs/flows/authorization-code-flow-with-proof-key-for-code-exchange-pkce) for details). The only difference in Keycloak is to specify the client `Access Type` as public.

![Keycloak Application scope](../../assets/images/Keycloak-08d.png){: style="height:60%;width:60%"}

!!!warning "Important"
    It's **SECURITY**, so learn about [Keycloak](https://www.keycloak.org/guides#getting-started/)!

## Configure the Domino REST API

You can find the full explanation [here](./configuringIdentityProvider.md). For the short version:

- Create a JSON file in `keepconfig.d` to contain the Keycloak related information
- Restart the REST API

```json
{
  "jwt": {
    "Trantor": {
      "providerUrl": "https://trantor.keycloak.yours/auth/realms/Trantor"
    }
  }
}
```

where:

| key         | explanation                                                                                                                   |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------- |
| jwt         | Indicates that the config belongs to JWT                                                                                      |
| Trantor     | The sample Keycloak realm name. It must be unique in the jwt key. Replace it with your choosen realm                          |
| providerUrl | Points to Keycloak's endpoint with the public key. Note that the last segment is the realm name. The string is case sensitive |

!!! note

    Keycloak's `providerUrl` is different from the general IdP practise to use `/.well-known/openid-configuration`, mainly since Keycloak can handle multiple realms, the well-known approach can't handle. Hence you need ro use `/auth/realms/[RealmName]`
