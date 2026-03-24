# Configure Microsoft Entra ID as IdP

## About this task

The procedures guide you on configuring Microsoft Entra ID, formerly Azure Active Directory, as an IdP.

## Client Ids

When configuring Microsoft Entra ID as your external identity provider (IdP), you must specify a client ID. This value must match the application (client) ID of the client application you configure in Microsoft Entra ID.

The client ID described here applies only to the Domino REST API server. Separate client IDs (application registrations) are required to support the Admin UI and Office Forms Based Authentication (OFBA).

To learn more about configuring Microsoft Entra ID for the Admin UI or Office Forms Based Authentication (OFBA), see the related topics:

- [Set up External IdP for Office Round Trip Experience](roundtripidp.md)

- [Set up External IdP for Admin UI login](adminuiidp.md)

<!--8<-- "onclientids.md"-->

## Configuration in Azure Portal

### Register an application

1. Go to the [Azure portal](https://portal.azure.com){: target="\_blank"} and sign in.

    !!! tip

        Make sure you’re in the correct directory. Select your profile icon in the upper-right corner of the Azure portal, then select **Switch directory**. Use an account in the same directory where you plan to register the application.

2. In **Microsoft Entra ID**, select **App registrations**, then select **New registration**.
3. On the **App registrations** page, enter the application registration details described in the following table.

      |Form input name|Description|
      |:---|:---|
      |Name|Enter a descriptive name for the application.|
      |Supported account types|Choose who can sign in.|
      |Redirect URI|Specify where authentication responses should be sent.<br/><br/>Select **Web** as the platform and use `{{origin}}/redirect/` as the Redirect URI.<br/>where: `{{origin}}` is a template placeholder for the base URL where the Domino REST API server is hosted.<br/><br/>If you aren't sure about the value to use, use `http://localhost:8080/redirect/`. You can change this later on the **Authentication** page.|

      ![Azure app registration](../../assets/images/entraID1.png){: style="height:70%;width:70%"}

4. Click **Register**.

After the registration, you will see the **Overview** page. It is recommended to take note of the displayed values as they might be required for the application configuration.

![Overview page](../../assets/images/entraID2.png){: style="height:70%;width:70%"}

### Add client credentials

1. Under **Manage**, select **Certificates &amp; secrets** &rarr; **Client secrets** &rarr; **New client secret**.
2. Add a description for your client secret, and select an expiration for the secret or specify a custom lifetime.

      ![Azure app registration](../../assets/images/entraID4.png){: style="height:70%;width:70%"}

3. Click **Add**.
4. Record the client secret Value. This secret value is never displayed again after you leave the page.

      ![Azure app registration](../../assets/images/entraID5.png){: style="height:70%;width:70%"}

### Add a scope

1. Under **Manage**, select **Expose an API**.
2. At the top of the page, select **Add** next to **Application ID URI**.

      This defaults to `api://<application-client-id>`. The App ID URI acts as the prefix for the scopes you'll reference in your API's code, and it must be globally unique.

      ![Azure app registration](../../assets/images/entraID3.png){: style="height:70%;width:70%"}

3. Click **Save**.

    !!! note

        If your application already has an **Application ID URI** and you want to add a scope, skip the preceding step and click **Add a scope** to open the **Add a scope** pane.  

4. Click **Add a scope** and specify the scope's attributes in the **Add a scope** pane, and then click **Add scope**.

      Ensure admins and users can consent and that the scope is set to **Enabled**. For more information about scopes in Domino REST API, see [scopes reference](../../references/schemacomponents/scopes.md) and [scope topic guide](../../topicguides/understanding.md#databases-schemas-and-scopes).

      ![Azure app registration](../../assets/images/entraID6.png){: style="height:70%;width:70%"}

5. Repeat the steps to add necessary scopes.

    !!! tip

        If you plan to use Microsoft Entra ID as your IdP to log in to the **Admin UI**, you must add the `$SETUP` scope.

The following example image shows how it would look after adding the scopes.

![Azure app registration](../../assets/images/entraID7.png){: style="height:70%;width:70%"}

### Configure API permissions

1. Under **Manage**, select **API permissions**. The **API permissions** page opens with the `User.Read` permission already configured.

      ![Azure app registration](../../assets/images/entraID20.png){: style="height:70%;width:70%"}

2. Click **Add a permission**. The **Request API permissions** pane opens.
3. Select the **APIs my organization uses** tab, and then select the application from the list.

      ![Azure app registration](../../assets/images/entraID8.png){: style="height:70%;width:70%"}

4. Under **Select permissions**, select the required scopes and click **Add permissions**.

      ![Azure app registration](../../assets/images/entraID9.png){: style="height:70%;width:70%"}

      After adding permissions, you should see the selected permissions under **Configured permissions** on the **API permissions** page.

5. Click **Grant admin consent for {your tenant}** to grant admin consent to the permissions configured for the application.
6. In the **Grant admin consent confirmation** dialog, click **Yes**.

      After granting consent, the permissions that required admin consent are shown as having consent granted.

      ![Azure app registration](../../assets/images/entraID10.png){: style="height:70%;width:70%"}

### Assign an owner

1. Under **Manage**, select **Owners**, and then select **Add owners**. The **Owners** pane opens.
2. Search for and select the user account that you want to be an owner of the application.

      ![Azure app registration](../../assets/images/entraID11.png){: style="height:70%;width:70%"}

3. Click **Select** to add the user account that you chose as an owner of the application.

### Check authentication

1. Under **Manage**, select **Authentication**.
2. On the **Redirect URI configuration** tab:

      - Make sure you have localhost for local development and https-based URLs for your test, staging, and/or production systems specified.
      - Use `{{origin}}/redirect/` as the Redirect URI. `{{origin}}` is a template placeholder for the base URL where the Domino REST API server is hosted.

      ![Azure app registration](../../assets/images/entraID12.png){: style="height:70%;width:70%"}

3. On the **Supported accounts** tab, make sure the correct supported account type is selected.
4. On the **Settings** tab, make sure **Access token** is selected.

      ![Azure app registration](../../assets/images/entraID13.png){: style="height:70%;width:70%"}

5. Click **Save** if you made any changes.

### Adjust app manifest

1. Under **Manage**, select **Manifest**. A web-based manifest editor opens, allowing you to edit the manifest.
2. Change the value of `accessTokenAcceptedVersion` from `null` to `2`, and then click **Save**.

=== "Before changing"

      ![Azure app registration](../../assets/images/configuringAD-16.png){: style="height:50%;width:50%"}

=== "After changing"

      ![Azure app registration](../../assets/images/configuringAD-17.png){: style="height:50%;width:50%"}

### Check application endpoints

1. Under **Manage**, select **Overview**.
2. Select **Endpoints** in the top menu to open the **Endpoints** page, which shows the authentication endpoints for the application. Take note of the following endpoints:

      - `OpenID Connect metadata document`
      - `OAuth 2.0 authorization endpoint (v2)`
      - `OAuth 2.0 token endpoint (v2)`

![Azure app registration](../../assets/images/entraID14.png){: style="height:70%;width:70%"}

<!--
## Configuration in Azure

### Register an application

1. Navigate to the [Microsoft Azure Portal)](https://portal.azure.com){: target="\_blank"} to login, and then select **App registrations**.

      ![Azure landing page](../../assets/images/configuringAD-01.png)

2. Select **New registration**.

      ![Azure app registration](../../assets/images/configuringAD-02.png)

3. Enter a **Name**, select a supported account type (in most cases **Single tenant** will do), enter local redirect URL (so you can develop your app), and then click **Register**.

      ![Azure app registration](../../assets/images/configuringAD-03.png){: style="height:90%;width:90%"}

!!! tip

    If you aren't sure about the redirect URL, use `http://localhost:8080/redirect/`. You can change this later on the **Authentication** page.

### Add credentials

The next step is to add the client credentials. Your application will need the **Application (client) ID** and **Client credentials**.

![Azure app registration](../../assets/images/configuringAD-04.png){: style="height:90%;width:90%"}

1. Select **Certificates & secrets** &rarr; **Client secrets** &rarr; **New client secret**.

      ![Azure app registration](../../assets/images/configuringAD-05.png){: style="height:90%;width:90%"}

2. Add a description, select an expiration for your client secret, and then click **Add**.

      ![Azure app registration](../../assets/images/configuringAD-06.png){: style="height:90%;width:90%"}

3. Copy the secret's value for use in your client application code.

      ![Azure app registration](../../assets/images/configuringAD-07.png){: style="height:90%;width:90%"}

!!! note

    The secret value is only shown once and never displayed again after you leave this page.

### API definition

1. Select **Expose an API**.
2. Select **Add** next to the **Application ID URI**. The URI must start with `api://`. You can overwrite the UUID with some clear text name.

      ![Azure app registration](../../assets/images/configuringAD-08.png){: style="height:90%;width:90%"}

3. Select **Add a scope**.
4. Specify the scope's attributes in the **Add a scope** pane.

      Ensure admins and users can consent and that the scope is set to **Enabled**. For more information about scopes in Domino REST API, see [scopes reference](../../references/schemacomponents/scopes.md) and [scope topic guide](../../topicguides/understanding.md#databases-schemas-and-scopes).

      ![Azure app registration](../../assets/images/configuringAD-09.png){: style="height:70%;width:70%"}

5. Click **Add scope**.
6. Repeat the steps for adding a scope for each scope that your need to add.

      ![Azure app registration](../../assets/images/configuringAD-10.png){: style="height:90%;width:90%"}

### Configure API permissions

1. Select **API permissions**. The **API permissions** screen, which has `User.Read` preconfigured, opens.
2. Click **Add a permission**.

      ![Azure app registration](../../assets/images/configuringAD-11.png){: style="height:90%;width:90%"}

3. Select **APIs my organization uses**.
4. Start typing the name of your application, and then select it.

      ![Azure app registration](../../assets/images/configuringAD-12.png){: style="height:90%;width:90%"}

5. Under **Select permissions**, select the scopes you have created earlier and the click **Add permissions**.

      ![Azure app registration](../../assets/images/configuringAD-13.png){: style="height:90%;width:90%"}

After adding permissions, you should see the selected permissions under **Configured permissions**.

![Azure app registration](../../assets/images/configuringAD-14.png){: style="height:90%;width:90%"}

### Update the application owners

1. Under **Manage**, select **Owners** and then select **Add owners**.

      ![Azure app registration](../../assets/images/configuringAD-15.png){: style="width:90%"}

2. Search for and select the user account that you want to be an owner of the application, and then click **Select**.

### Adjust authentication

In **Authentication**, make sure you have localhost for local development and https-based URLs for your test, staging, and/or production systems specified. Select only **Access token** and make sure redirect ends with `/`.

![Azure app registration](../../assets/images/configuringAD-15a.png){: style="height:90%;width:90%"}

### Adjust app manifest

1. Under **Manage** page, select **Manifest**. A web-based manifest editor opens, allowing you to edit the manifest within the portal.
2. Change the value of `accessTokenAcceptedVersion` from `null` to `2`.

Before change:

![Azure app registration](../../assets/images/configuringAD-16.png){: style="height:80%;width:80%"}

After change:

![Azure app registration](../../assets/images/configuringAD-17.png){: style="height:80%;width:80%"}

### URLs to note

1. From the app's **Overview** page, select **Endpoints**.

      ![Azure app registration](../../assets/images/configuringAD-18.png){: style="height:90%;width:90%"}

2. Take note of the following URLs.

      ![Azure app registration](../../assets/images/configuringAD-19.png){: style="height:90%;width:90%"}

All URLs are retrievable by accessing the _OpenID Connect_ metadata document, colloquially referred to as `.well-known`. These are the ones involved:

- OpenID Connect metadata document
- OAuth 2.0 authorization endpoint (v2)
- OAuth 2.0 token endpoint (v2)

-->

## Configuration in Domino REST API

1. Create a [JSON](https://www.json.org/json-en.html) file in the directory `[notesdata]/keepconfig.d`.

      Use a filename for the JSON file that reveals its purpose. Make sure the filename only includes numbers and ASCII letters (`[0-9a-zA-Z]+`).

2. Add the following content to the JSON file.

      ```json
      {
            "jwt": {
                  "AzureIdP": {
                        "active": true,
                        "providerUrl": "[value of the OpenID Connect metadata document endpoint]",
                        "aud": "[value of the Application (client) ID]",
                        "iss": "[iss value]",
                        "algorithm": "RS256"
                  }
            }
      }
      ```

      Remarks:

      - The `AzureIdP` isn't a fixed value. Pick anything that makes it clear for you. You can use it as the filename too.
      - The `providerUrl` parameter should have the value of the `OpenID Connect metadata document` endpoint.
      - The `aud` parameter should have the value of the **Application (client) ID** that can be checked on the **Overview** page of the application in the Azure portal.
      - The `iss` parameter should have a value of the `OpenID Connect metadata document` endpoint without the `/.well-known/openid-configuration` suffix.

           You can also check the value of the `iss` parameter by pasting the `OpenID Connect metadata document` endpoint value on a browser and check the `issuer` key. The value of the issuer key is the value to be used for the `iss` parameter.

           ![Azure app registration](../../assets/images/entraID15.png){: style="height:70%;width:70%"}

      - Currently, Azure AD doesn't return the `alg` claim in the `jwks_uri`. You have to specify it here.

3. Save the changes and restart Domino REST API.

!!! danger "Azure AD / Entra ID is a moving target"

    Depending on your configuration, you will need to adjust the `aud` and `iss` values in the configuration file. To determine the correct values, use the test application below to inspect what values are actually sent with the Azure access token. For `aud`, you might get the application ID and something different for `iss`. Also, the algorithm might be included somewhere. Use the test application below!

## Test the application

1. Go to [Downloads](../../references/downloads.md#microsoft-entra-id-formerly-azure-active-directory), and then download the `AzureTester.zip` file.

    The file contains an [expressJS](https://expressjs.com/) application and related static files (HTML/CSS/JS).

2. Extract the zip file.
3. Navigate to the directory and run the web server using the following command:

    !!! note

        You need a current [NodeJS](https://nodejs.org/en) version installed.

    ```bash
    npm install
    node server.js
    ```

    !!! warning

        Do **NOT** use this code in production.

4. Open the URL [http://localhost:8080/](http://localhost:8080/) and fill in the form details. You will find most of the values in the overview page of the Azure application registration. You should see a page like this:

    ![Azure app registration](../../assets/images/configuringAD-20.png){: style="height:70%;width:70%"}

!!! note

    When specifying scopes, include the **Include the Application ID URI** in the test form. The URI gets stripped from the resulting JWT token.

    So to get `scp : "$DATA MAIL demo"` in the JWT, specify `api://dominorest/$DATA api://dominorest/MAIL api://dominorest/demo` where `api://dominorest` is whatever you specified as **Application ID URI**.

Azure redirects you to the `/redirect` URL. Typically, this page would auto process, but you want to marvel at the authorization code. When you click **Exchange token**, the ExpressJS server exchanges the code for a JWT and returns the list of configured endpoints as example. You can't do this with the browser alone, [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) prevents it.

![Azure app registration](../../assets/images/configuringAD-21.png){: style="height:70%;width:70%"}

Check the results:

![Azure app registration](../../assets/images/configuringAD-22.png){: style="height:70%;width:70%"}

## Troubleshooting

A few tips to troubleshoot the setup when the goalpost has been moved:

- Grab the JWT token and paste it at the [JWT.io](https://jwt.io) website to decode the JSON payload.

- If your corporate policy prohibits that, then extract the string between the two `.` from your JWT token and send it through a Base64 decoder: `echo [the string] | base64 --decode | jq`. Kindly note that `| jq` is optional.
- Compare the `iss` value from the JWT token with the `issuer` value from the `openid-configuration` endpoint. If they don't match, you need to add the `iss` to the JSON configuration file you created or edited in `keepconfig.d`.
- Compare the `aud` value from the JWT token with the `aud` value of the configuration file. Adjust the configuration file if different.
- Check the `scp`, which is Microsoft's "alternative" to `scope`, and make sure it has the expected values matching the settings in the application configuration in the Admin UI. Adjust the scope in the DRAPI application (Admin UI) or your AzureAD IdP settings.

## Additional information

Microsoft Entra ID follows OAuth 2.0 and OpenID Connect standards, but uses some Microsoft-specific conventions for JWT claims:

- The `aud` claim identifies the target API and is typically set to the application ID, App ID URI (for example, `api://<client-id>`), or a resource URL.
- Instead of a `scope` claim, access tokens use the `scp` claim to represent delegated permissions.

<!--
Microsoft Entra ID has its own ideas about JWT compatibility:

- The `aud` property is fixed to the ID of the application, not as commonly, the URL of the target system.
- There is no `scope` property, but instead `scp` to describe the requested scopes.
-->
## Rinse and repeat

- [Set up External IdP for Office Round Trip Experience](roundtripidp.md)

- [Set up External IdP for Admin UI login](adminuiidp.md)

<!--
## Let's connect

"feedback.md"
-->
