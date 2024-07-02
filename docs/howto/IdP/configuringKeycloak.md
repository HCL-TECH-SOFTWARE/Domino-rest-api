# Configure Keycloak

[Keycloak](https://www.keycloak.org/) is an Open Source Identity and Access Management solution sponsored by [RedHat](https://www.redhat.com/en).

Keycloak can be used to produce JWT Access Token for Domino REST API. Keycloak has many features like default configuration, user federation, identity brokering and social login. Those are topics not covered here, you want to consult a [Keycloak Tutorial](https://duckduckgo.com/?q=keycloak+tutorial&ia=web) or the [Keycloak documentation](https://www.keycloak.org/documentation) to learn more. This page focuses on the settings required for Domino REST API.

## About this task

This section describes key concepts and provides the steps required to configure Keycloak successfully for Domino REST API.

## Keycloak concepts

Only concepts relevant to Domino REST API are listed:

![Keycloak concepts](../../assets/images/KeycloakConcepts.png)

- **Realm**: The starting point for Keycloak identity management, contains all other elements.
- **Client**: Each accessing application, client app, Single Page App or server app will have a client entry. The client entry contains application Id and, if required, the application secret.
- **Client Scopes**: Attributes and properties available and/or assigned to client entries.
- **Mapper**: Configuration entry to determine what information is available in a client scope.

## Procedure

In this example, you will learn and create a realm, a user, client scopes, client and client scope mappers inside the Keycloak app.

Note: The screenshots were captured using the Keycloak version 25.0.

1. Login to Keycloak. 
2. Click the **Keycloak** dropdown menu at the top left corner, then click **Create Realm**. 

      ![alt text](../../assets/images/keyrealm.png)
  
    a. Fill in the **Realm Name**. For example **Ameca**.

    b. Click **Create**.
 

      ![alt text](../../assets/images/keyrealmname.png)
    
3. Click **Realm settings**. 

    a. Fill in the fields applicable to your project. Mandatory fields are those fields with red asterisk (<span style="color: red;">*</span>).

      For example:

       Display name: Humanoid Robots
       
       HTML Display name: < h1 >Humanoid Robots < /h >

    b. Click **Save**.
    
      ![alt text](../../assets/images/keyrealmgen.png)

    c. Click **User Profile** tab.

    d. Click **Create Attribute**.

      1. Fill in the fields applicable to your project. Mandatory fields are those fields with red asterisk (<span style="color: red;">*</span>).
      2. Fill in the *Attribute name*. For example `CN`    
      2. Set *Required field* toggle to `on` position.
      3. Under **Permission** section, select the *User* checkbox for the *Who can view?* option.
      4. Click **Create**. 

      ![alt text](../../assets/images/keyattr.png)

4. Click **Users**.
    
    1. Click **Create new user**, if there are no existing users. Otherwise, click **Add user**, if there are existing users.
    
        ![alt text](../../assets/images/keyusers.png)

    2. Fill in the mandatory fields with red asterisk(`*`), as minimum requirements to save. You can see here the user profile **attribute** you created on the **Realm Settings**. For example, *Domino common name*.

    3. Click **Create**. The user has been created.
    
        ![alt text](../../assets/images/keyuserdetail.png)

5. Create client scopes.

    Create a client scope named `demo` which contains the settings that are common to all clients (a.k.a apps) accessing Domino Rest API.

    ![alt text](../../assets/images/keynewscope1.png)
    
    1. Fill in the client scope name. Named it as `demo`.         
    2. Fill in *Description*. For example *demo for all demo*.          
    3. Set *Display on consent screen* toggle to `on` position.
    4. Set *Include in token scope* toggle to `on` position.
    5. Click **Save**.
    
        ![alt text](../../assets/images/keyscopename1.png)

    The configuration so far will identify a user presenting the access token to Domino REST API, but not yet provide any access. You need to specify what scopes this application will be allowed to access. You can use one or more (lowercase) scopes or some of the special scopes MAIL, $DATA or $DECRYPT.  Multiple scopes are separated using a space.

    Create another specific client scope, like **$DATA**.

    ![alt text](../../assets/images/keynewscope2.png)

    1. Fill in the client scope name. Named it as `$DATA`.
    2. Fill in *Description*.
    3. Set *Display on consent screen* toggle to `on` position.
    4. Set *Include in token scope* toggle to `on` position.
    5. Click **Save**.
    
        ![alt text](../../assets/images/keyscopename2.png) 

6. Go to **Client**, then click **Create client**.    

    ![alt text](../../assets/images/keycreateclient.png)

    1. Fill in *Client type* and *Client ID*, for example, **thespian** and Click **Next**. 

          ![alt text](../../assets/images/keyclientid.png)

    2. On the **Capability config**, turn `off` the *Client Authentication* and click **Next**. When it's ON, the OIDC type is set to confidential access type. When it's OFF, it's set to public access type. 
    
          ![alt text](../../assets/images/keyconfig.png)

    3. On **Login Settings**, click **Save**.
    
          ![alt text](../../assets/images/keyURI.png)

7. On the saved client's ID, for example **thespian**, click **Clients scopes** tab.

    1. Click the **thespian-dedicated**. This is the client's dedicated scope once the client is created.

        ![alt text](../../assets/images/keydedicated.png)

    2. Click **Configure new mapper** or if there are existing mapper, click **Add mappers** &rarr; **by Configuration**. You need to add few mappers on your dedicated scope.
    
        In this example, you need to have 2 **Audience** mappers and 1 **User Atrribute**.
        
        ![alt text](../../assets/images/keynewmapper.png)

        Mapper-1 as **Audience** mapper
        
        1. Click **Audience** mapping in the list.
        2. Fill in the name, for example `Domino`.
        3. Fill in the *Included Custom Audience*, for example `Domino`.
        4. Set *Add to access token* toggle to `on` position. 
        5. Click **Save**.
        
        ![alt text](../../assets/images/keymapper1.png)
        
        Mapper-2 as **Audience** mapper

        1. Click **Audience** mapping in the list.
        2. Fill in the name, for example `dummy`.
        3. Fill in the *Included Custom Audience*, for example `https://dummy.restapiexample.com/`.
        4. Set *Add to access token* toggle to `on` position. 
        5. Click **Save**.
          
        ![alt text](../../assets/images/keymapper2.png)  
        
        Mapper-3 as **User Attribute** mapper
        
        1. Click the **User Attribute** mapping in the list.
        2. Fill in the mapper name, for example `DominoNameAttr`.
        3. Fill in the *User Attribute*, as `CN`.
        4. Fill in the *Token Claim Name* as `CN`.
        5. Choose `String`from the dropdown menu of *Claim JSON Type*.
        6. Set *Add to access token* toggle to `on` position. 
        7. Click **Save**.
        
        ![alt text](../../assets/images/keymapper3.png)         

8. Click the **Client details**.

    ![alt text](../../assets/images/keycdetails.png)
    
    The **Assign Type** of all scopes must be **Optional** except your `email` scope.
          
    1. Click the **Add client scope**. 
    
        ![alt text](../../assets/images/keyaddscopes.png)   
    
    2. Check the name of the client scopes you would like to add on your **thespian** client scope, for example `demo` and `$DATA`, and click **Add** and choose **Default** option.
    
        ![alt text](../../assets/images/keycommon.png)

    3. Click **Client Scope** &rarr; **Evaluate** tab.
    4. Fill in *Users*.
    5. Click **Generated access token**.
    
        ![alt text](../../assets/images/keyevaluate.png)


      
## SPA applications

An SPA (Single Page App) or a mobile client can't keep a client secret. For those, the use of Proof Key for Code Exchange (PKCE) (defined in [RFC 7636](https://tools.ietf.org/html/rfc7636)) is recommended (read [this intro](https://auth0.com/docs/flows/authorization-code-flow-with-proof-key-for-code-exchange-pkce) for details). The only difference in Keycloak is to toggle `off` the **Client Authentication**.

![alt text](../../assets/images/keypkce.png)

!!!warning "Important"
    It's **SECURITY**, so learn about [Keycloak](https://www.keycloak.org/guides#getting-started/)!

## Configure the Domino REST API

You can find the full explanation [here](./configuringIdentityProvider.md). For the short version:

- Create a JSON file in `keepconfig.d` to contain the Keycloak related information
- Restart the REST API

```json
{
  "jwt": {
    "Ameca": {
      "providerUrl": "https://ameca.keycloak.yours/auth/realms/Ameca"    
    }
  }
}
```

where:

| key         | explanation                                                                                                                   |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------- |
| jwt         | Indicates that the config belongs to JWT                                                                                      |
| Ameca     | The sample Keycloak realm name. It must be unique in the jwt key. Replace it with your chosen realm                          |
| providerUrl | Points to Keycloak's endpoint with the public key. Note that the last segment is the realm name. The string is case sensitive |

!!! note

    Keycloak's `providerUrl` is different from the general IdP practise to use `/.well-known/openid-configuration`, mainly since Keycloak can handle multiple realms, the well-known approach can't handle. Hence you need ro use `/auth/realms/[RealmName]`


## Expected result

### Test Application specific scopes result in Postman

#### Prerequisite

- Configured Postman
- configured Keycloak

#### Procedure

1. Modify the token endpoint of via POST with this `{{server}}/realms/{{realm}}/protocol/openid-connect/token`
      
      - server: Your Keycloak server.
      - realm: Your realm name, for example Ameca.

2. In the `Body`, provide the `client_id`, `client_secret`, `grant_type`, `user_name` and `password` from your Keycloak.
3. Click **Send**.

The result must have an access token, which must be tested int [jwt](https://jwt.io/) to return the same result in Keycloak.

![alt text](../../assets/images/keyacctoken.png)

**JWT**

You can use the [official JWT site](https://jwt.io/) to decode and inspect the encoded token. Copy the access token from Postman and paste it inside the **Encoded** box.

When decoded, this translates to:

HEADER: ALGORITHM & TOKEN TYPE

```json
{
  "alg": "RS256",
  "typ": "JWT",
  "kid": "dtzYxf0a22BPo_M4A72PAJS8cAHUjFDFGKVqmzpu3po"
}
```

PAYLOAD: DATA
```json
{
  "exp": 1719281929,
  "iat": 1719281629,
  "jti": "e708dfd3-8218-450b-a98e-00e23af649ff",
  "iss": "http://localhost:8080/realms/Ameca",
  "aud": [
    "Domino",
    "https://dummy.restapiexample.com/"
  ],
  "typ": "Bearer",
  "azp": "thespian",
  "sid": "1dbc900a-c490-47ef-a242-67be3a1aa250",
  "scope": "$DATA email demo",
  "email_verified": true,
  "CN": "CN=Harry Chen/O=Ameca",
  "email": "harrychen@ameca.org"
}
```

which has the same result in the Keycloak **generated access token**.

![alt text](../../assets/images/keyresult.png)

