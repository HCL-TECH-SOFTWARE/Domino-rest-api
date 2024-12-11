# Configure Domino REST API IdP with Volt MX Foundry Identity Service

--8<-- "keepmngtURLcaution1.md"

## About this task

Domino REST API implements what essentially amounts to an OAuth2 Provider DominoIDP and Volt MX Foundry implements an Integration Service adapter for OAuth2 providers. The following is a guide for creating a Foundry Identity Service using Domino REST API's OAuth provider.

## Before you begin

You must first set up the [Domino Rest API IdP](../../howto/IdP/configuredrapiIdP.md).


## Create Foundry Identity Service

Some things to note when creating an identity service in Volt MX Foundry using Domino REST API IdP (also refer to the screenshot below):

1. Create a new Identity Service in the Foundry browser console by filling in the fields:

      - **Type of identity** = OAuth 2.0
      - **Grant Type** = Authorization Code
      - **Authorize Endpoint** = `[your Domino REST API API server]/oauth/authorization`
      - **Token Endpoint** = `[your Domino REST API API server]/oauth/token`
      - **IMPORTANT** - make sure to select **Form Param** under **Advanced**. <!--{: .alert .alert-danger}-->
      - Take note of the **Callback URL**.

      Pause here for a moment (don't save yet), and complete the steps for [setting up Domino REST API application and database](#set-up-domino-rest-api-application-and-database).

      - **Scope** = database `name` (API Name) for the database added in the next step; if more than one database, you should be able to enter a list of database names; check Domino REST API documentation to see how the names are delimited (perhaps a comma or space, but to Domino REST API it simple, just enter one db name if uncertain about how to specify multiple).
      - **Client ID** = `App id` from the application created in the next section below.
      - **Client Secret** = Obtained when you first create the application (next section).

2. Now you can **Save**.

![voltmx identityprovider keepidplite](../../assets/images/voltmx-identityprovider-keepidplite.png)

## Set up Domino REST API application and database

From the Domino REST API Admin browser client:

1. Add a database, and note its name (API name, when you create the DB in Domino REST API).
2. Create an application, and note its client id, and client secret.

!!! note
    When you create the application, you'll need the callback URL [defined earlier](#create-foundry-identity-service).

![Domino REST API create application](../../assets/images/keep-create-application.png){: style="height:80%;width:80%"}

The App ID (Client ID) is available any time you view a created application. The secret is shown only when the secret is created the first time. If you forget the secret, generate a new one by clicking the circular arrow as indicated in the following image:

![Domino REST API application id and secret](../../assets/images/keep-application-id-and-secret.png)
