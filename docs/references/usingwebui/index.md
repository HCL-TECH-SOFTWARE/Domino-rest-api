# Using Web UI

The Admin UI provides a user interface to a number of Domino REST APIs. It thus serves an example what a [React](https://reactjs.org/) application using the Domino REST APIs is capable of. It covers schema, scope, and app management. Anything that can be done using the WebUI can also be done using Postman, curl, SwaggerUI, or similar tools. There are [tutorials](../../tutorial/index.md) to walk you through the same.

<!-- prettier-ignore -->
!!! note
    The screenshots in this section may vary. The screenshots are based on the latest Domino REST API snapshots. Make sure you're up-to-date.

This is what the login page looks like.

![Domino REST API](../../assets/images/AdminLogin.png)
(Image: Castle [Johannisburg](https://en.wikipedia.org/wiki/Schloss_Johannisburg), Aschaffeburg, Germany)

You'll need the administrator username and password to access the server.

To use a Domino database in Domino REST API, it must be configured for use in the API. Download `Demo.nsf` from [Resources](../../references/downloads.md) and save it in the Notes data directory. Then login to the Domino REST API Admin UI using the administrator user name and password.

For more information on logging in to the Domino REST API Admin UI:

- see [Login](../../tutorial/adminui.md#login)

- see [Use passkey to login to Admin UI](../../howto/install/passkey.md)

From the Admin UI, you can access the following:

- [Schema Management](schemaui.md)

- [Scope Management](scopeui.md)

- [Quick Config](quickconfigui.md)

- [Application Management](appui.md)

- [OAuth Consents](oauthconsentui.md)

<!--## Database Management - REST API

Select **Database Management - REST API** from the home page.-->