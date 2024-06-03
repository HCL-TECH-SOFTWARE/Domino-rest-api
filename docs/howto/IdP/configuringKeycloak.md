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

You will create a realm, an user, two clients (one for a SPA, one for a server based app), a client scope for shared settings and a few mappers.

## Procedure

1. Login to Keycloak. 
2. Click the `Master` dropdown and click **Create Realm**. 

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
    
    1. Click **Create a new user**. In a production environment you probably would connect to an existing LDAP or Active Directory server. 

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

5. Create client scope. 

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

          Mapper-2
          
          1. Click the **User Attribute** mapping in the list.
          2. Fill in the name, for example `keep-subject`.
          3. Fill in the *User Attribute*.
          4. Fill in the *Token Claim Name* with `sub`.
          5. Choose `string`from the dropdown menu of *Claim JSON Type*.
          6. Turn `on` toggle on *Add to access token*.
          7. Click **Save**.
          
          ![alt text](../../assets/images/keymapper2.png)    

6. Click **Client** and click **Create client**.    

    ![alt text](../../assets/images/keycreateclient.png)

    The example below is for an application server that can present a client id and a client secret. An example for a SPA (that can't keep a secret) follows further down.

    1. Fill in *Client type* and *Client ID*, and click **Next**. 
    
          ![alt text](../../assets/images/keyclientid.png)

    2. Turn `on` toggle for *Client authentication*.
    
          ![alt text](../../assets/images/keycauthen.png)       
    
    3. Click **Save**. When you save it, this produces more tabs about your **client**.

    4. On **Settings tab** &rarr; *Access setting* tab, fill in the *Valid redirect URIs* with URI of your current application and click *Save*.
    
          ![alt text](../../assets/images/keyURI.png)

## Application specific scopes

The configuration so far will identify a user presenting the access token to Domino REST API, but not yet provide any access. You need to specify what scopes this application will be allowed to access. You can use any of the global scopes `$MAIL`, `$DATA` or `$DECRYPT` or, preferably, a lowercase database alias. Multiple scopes are separated using a space.
<!-- prettier-ignore -->
!!! note
    It's best practice to give an external application as little as possible access so it can function. So think twice before allowing any of the global scopes.

1. Click the **Client Scopes** and click **Create client scope**. 

      ![alt text](../../assets/images/keyclientscopes1.png)
 
      1. Fill in the *Name* of the client scope. For example **App-Scope**.
      2. Choose the **Default** as *Type*.
      3. Click **Save**. You can create more global scopes on your realm's client scopes.
      
          ![alt text](../../assets/images/keyclientscopes2.png)

      4. Go to the **Mappers** tab of **Apps-Scope** client scope.

      5. Click **Add Mapper** &rarr; **by Configuration**.
      6. Select **Hardcoded Claim**.
      7. Fill in the *Name*.
      8. Fill in the *Token Claim Name*. For example, **ClaimName.value**.
      9. Fill in the *Claim value* with the scopes or global scopes. Multiple scopes are separated using a space.
      10. Click **Save**.

      ![alt text](../../assets/images/keymapper.png)

6. Go and click  **Clients**.
7. Select your *Client ID*. For example, **SpecialKeepDemo**.

      ![alt text](../../assets/images/keyclientsco.png)

8. Click the **Client scopes** tab and click **Add client scope**.

      ![alt text](../../assets/images/keyaddcscopes.png)

      1. Check **App-Scope** client scope.
      2. Click **Add** and choose **Default**.
      
          ![alt text](../../assets/images/keyappscope.png)
            
          The **App-scope** is now on the list of **SpecialKeepDemo** client scopes.
      
      3. Click **Client scopes** tab &rarr; **Evaluate** tab.
      4. . Fill in the username of the *User*. 
      5. Go and click **Generated access token**.

          ![alt text](../../assets/images/keyaccesstoken.png) 



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
    "Trantor": {
      "providerUrl": "https://ameca.keycloak.yours/auth/realms/Ameca"    
    }
  }
}
```

where:

| key         | explanation                                                                                                                   |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------- |
| jwt         | Indicates that the config belongs to JWT                                                                                      |
| Trantor     | The sample Keycloak realm name. It must be unique in the jwt key. Replace it with your chosen realm                          |
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

You can use the [official JWT site](https://jwt.io/) to decode and inspect the encoded token.

```bash
eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJkbVlLaWIzQnJodnJPVnVRc2ljcXdPVzcwX2N2MDJ1ekZFV091WC1uN3ZVIn0.eyJleHAiOjE3MTcxNzQ4MzQsImlhdCI6MTcxNzE3NDUzNCwianRpIjoiN2FmYTMxNmMtOGFjOC00ODMzLTkwN2YtMjUwNDM3MTY3ODNiIiwiaXNzIjoiaHR0cHM6Ly9kaWdpLXFzLWtleWNsb2FrLnFzLmhjbGxhYnMubmV0L3JlYWxtcy9BbWVjYSIsImF1ZCI6IkRvbWlubyIsInN1YiI6ImNkNGVhYTk4LTY3N2MtNGM2Mi1iZTU0LTdlOTBiZWUxMjQ0NyIsInR5cCI6IkJlYXJlciIsImF6cCI6IlNwZWNpYWxLZWVwRGVtbyIsInNlc3Npb25fc3RhdGUiOiI3MDA0Y2M2Yy1hMThkLTQ3YzUtODJiNC0wOGJlNjhiNTdiM2MiLCJzY29wZSI6IkFwcC1TY29wZSBvZmZsaW5lX2FjY2VzcyIsInNpZCI6IjcwMDRjYzZjLWExOGQtNDdjNS04MmI0LTA4YmU2OGI1N2IzYyIsIkNsYWltTmFtZS52YWx1ZSI6ImRlbW8gJERBVEEifQ.hRjB9EzKXNrWI8h1rQS8_xkPfrl99BWTyE5xBf6V-wVUKNIBsCC8wP1aFlPHQefciuUVM13XKIE6shC9LIBRiAQE4crKgZlxWL8tVZ4I4wUr2SqYwbZ5z9okMn6FCuDdyNRDbC8HXpFas6fcfYd3JU6k-ea8YmhdndW-mQ98kJbOL98H30ATIbYJh6u1wqed989E4aSToghLNZmtMChMlNd921QNdpr5_r6ZSLk4A7nOfjtz9fl0lXpxZ83NBiM9Y5-TWgq1wvNbbP9hLq9_Rf5CDX_KLb6ocQMvcNvdh_w4cGQJ7q5wzu4OmiF_tllU8q5A4wGQOGGMuZjWUV-QOw
```

When decoded, this translates to:

HEADER: ALGORITHM & TOKEN TYPE

```json
{
  "alg": "RS256",
  "typ": "JWT",
  "kid": "dmYKib3BrhvrOVuQsicqwOW70_cv02uzFEWOuX-n7vU"
}
```

PAYLOAD: DATA
```json
{
  "exp": 1717174834,
  "iat": 1717174534,
  "jti": "7afa316c-8ac8-4833-907f-25043716783b",
  "iss": "https://digi-qs-keycloak.qs.hcllabs.net/realms/Ameca",
  "aud": "Domino",
  "sub": "cd4eaa98-677c-4c62-be54-7e90bee12447",
  "typ": "Bearer",
  "azp": "SpecialKeepDemo",
  "session_state": "7004cc6c-a18d-47c5-82b4-08be68b57b3c",
  "scope": "App-Scope offline_access",
  "sid": "7004cc6c-a18d-47c5-82b4-08be68b57b3c",
  "ClaimName.value": "demo $DATA"
}
```

which has the same result in the Keycloak **generated access token**.

![alt text](../../assets/images/keyresult.png)