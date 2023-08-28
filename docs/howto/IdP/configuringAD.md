# Configure Azure Active Directory as IdP

Azure Active Directory has its own ideas about JWT compatibility:

- The `aud` property is fixed to the ID of the application, not as commonly, the URL of the target system
- There is no `scope` property, but instead `scp` to describe the requested scopes

## Configuration in Azure

Navigate to the [Azure Portal](https://portal.azure.com) to login. Select "App registration"

![Azure landing page](../../assets/images/configuringAD-01.png)

### Application registration

Select "New Registration" on top of the page

![Azure app registration](../../assets/images/configuringAD-02.png)

Provide a name, the account type (in most cases "Single tenant" will do) and a local redirect URL (so you can develop your app). If not sure about the URL, use `http://localhost:8080/redirect`. You can change this later on in "Authentication" in the application page. Click on **Register**.

![Azure app registration](../../assets/images/configuringAD-03.png)

Next step is to add the client credentials. Your application will need the `Application (client) ID` and "Client credentials"

![Azure app registration](../../assets/images/configuringAD-04.png)

![Azure app registration](../../assets/images/configuringAD-05.png)

![Azure app registration](../../assets/images/configuringAD-06.png)

![Azure app registration](../../assets/images/configuringAD-07.png)

### API Definition

Select "Expose an API" and "Add" behind the Application ID URI. The URI must start with `api://`. You can overwrite the UUID with som cleartext name

![Azure app registration](../../assets/images/configuringAD-08.png)

Next step is to add the scopes, one by one. Ensure admins and users can consent and that the scope is set to active. RFor more information about the scopes in the DOmino REST API refer to the [scopes reference](../../references/usingdominorestapi/scopes.md) and the [scope topic guide](../../topicguides/understanding.md#databases-schemas-and-scopes)

![Azure app registration](../../assets/images/configuringAD-09.png)

![Azure app registration](../../assets/images/configuringAD-10.png)

### Configure API permissions

You start at the API permission screen, which has `User.Read` preconfigured. Click on `Add a permission` and select "APIs my organization uses", Start typing the name of your application and select it.

![Azure app registration](../../assets/images/configuringAD-11.png)

![Azure app registration](../../assets/images/configuringAD-12.png)

Select the scopes you have created earlier to get the following results.

![Azure app registration](../../assets/images/configuringAD-13.png)

![Azure app registration](../../assets/images/configuringAD-14.png)

### Update the application owners

![Azure app registration](../../assets/images/configuringAD-15.png)

### Adjusting authentication

In Authentication ensure you have loclahost for local development as well as the https based urls of your test, staging and/or production systems specified. Check only access token.

![Azure app registration](../../assets/images/configuringAD-15a.png)

### Adjusting the manifest

The manifest needs an update. Change `accessTokenAcceptedVersion` from `null` to `2`

Old:

![Azure app registration](../../assets/images/configuringAD-16.png)

New:

![Azure app registration](../../assets/images/configuringAD-17.png)

### URLs to note

![Azure app registration](../../assets/images/configuringAD-18.png)

![Azure app registration](../../assets/images/configuringAD-19.png)

All URLs can be retrived by accessing the "OpenID Connect metadata document", colloquially refered to as `.well-known`

## Configuration in the Domino REST API

## Testing the application

## Let's connect

--8<-- "feedback.md"

--8<-- "future.md"
