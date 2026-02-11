# Using Admin UI

## Overview

The **Admin UI** provides a browser‑based user interface to several Domino REST APIs. It demonstrates what a [React](https://reactjs.org/) application using the Domino REST APIs is capable of and includes functionality for:

- [Schema Management](schemaui.md)

- [Scope Management](scopeui.md)

- [Quick Config](quickconfigui.md)

- [Application Management](appui.md)

- [OAuth Consents](oauthconsentui.md)

Anything you can perform with the **Admin UI** can also be done using tools such as Postman, curl, Swagger UI. [Tutorials](../../tutorial/index.md) are available that walk through performing these tasks using different tools.

To use a Domino database in Domino REST API, it must be configured for use in the API. As an example, download the sample Domino database `Demo.nsf` from [Resources](../../references/downloads.md) and save it in your Domino server's Notes data directory. Then login to the **Admin UI** using an administrator account and configure the Domino database.

## Log in options

There are multiple options for logging in to the Domino REST API **Admin UI**, depending on how the system is configured.

![Domino REST API](../../assets/images/AdminLogin.png){: style="height:70%;width:70%"}

### Log in with password

To use this option, enter your Domino administrator credentials in the **Username** and **Password** fields, then click **LOG IN**.

!!! note

    If an external identity provider (IdP) has been configured for **Admin UI** access, the **Username** and **Password** fields may not be visible by default. To use this login option, click **LOG IN WITH PASSWORD** to display the fields.

### Log in with passkey

This option allows you to log in using a passkey, which enables passwordless authentication. Authentication may be performed using device-based mechanisms such as biometrics, PIN, or pattern. For more information on how to log in with passkey, see [Use passkey to log in to Admin UI](../../howto/install/passkey.md).

### Log in with OIDC

The OIDC login option uses the Domino REST API IdP (identity provider) by default and implements the OAuth login flow requiring user consent.

!!! info

    If an external identity provider has been configured to log in to the Admin UI, the *Log in with OIDC* will be the default login option. For information about configuring an external IdP for Admin UI login, see [Set up Admin UI external IdP login configuration](../../howto/IdP/adminuiidp.md).

**To log in**:

1. Click **LOG IN WITH OIDC**.
2. Select the identity provider.

    - If only the default Domino REST API IdP option is available:

        1. Click **LOG IN**.

            ![HCL Domino Login](../../assets/images/AdminLogin3.png){: style="height:70%;width:70%"}

        2. Enter your administrator username and password on the **HCL Domino Login** screen.

            ![HCL Domino Login](../../assets/images/AdminLogin2.png){: style="height:70%;width:70%"}

        3. Click **Login**.

    - If an external identity provider has been configured:

        1. Select the desired IdP from the drop-down list.

            ![HCL Domino Login](../../assets/images/AdminUiLoginExternalIdP.png){: style="height:70%;width:70%"}

        2. Click **LOG IN**.
        3. Use your external IdP authentication credentials and follow the provider’s login instructions.







<!--
The **Admin UI** provides a user interface to several Domino REST APIs. It thus serves as an example of what a [React](https://reactjs.org/) application using the Domino REST APIs is capable of. It covers schema, scope, and app management. Anything that can be done using the Admin UI can also be done using Postman, curl, Swagger UI, or similar tools. There are [tutorials](../../tutorial/index.md) to walk you through the same.


!!! note

    The screenshots in this section may vary depending on your version of the Domino REST API.

This is what the login page looks like.

![Domino REST API](../../assets/images/AdminLogin.png){: style="height:70%;width:70%"}

(Image: Castle [Johannisburg](https://en.wikipedia.org/wiki/Schloss_Johannisburg), Aschaffeburg, Germany)

You'll need the administrator username and password to access the server.

To use a Domino database in Domino REST API, it must be configured for use in the API. Download `Demo.nsf` from [Resources](../../references/downloads.md) and save it in the Notes data directory. Then login to the Domino REST API **Admin UI** using the administrator username and password.

## Log in options

There are options for logging in to the Domino REST API **Admin UI**.

### Log in with password

This option uses your Domino administrator username and password. You can log in to the **Admin UI** by entering your administrator username and password in the **Username** and **Password** fields, and clicking **LOG IN**.

!!! note

    If you have set up an external IdP to access the **Admin UI**, the **Username** and **Password** fields will not be visible by default. To display these fields, click **LOG IN WITH PASSWORD**. This allows you to enter your credentials and use the *Log in with password* option.

### Log in with passkey

This option enables users to log in with a passkey that enables signing in to websites without remembering and managing passwords using a biometric sensor, PIN, or pattern. For more information on how to log in with passkey, see [Use passkey to log in to Admin UI](../../howto/install/passkey.md).

### Log in with OIDC

This option uses the Domino REST API IdP by default and implements the OAuth process requiring user consent to log in. You can log in to the **Admin UI** by clicking **LOG IN WITH OIDC**. The **DRAPI** option will be the only one available from the drop-down field. Click **LOG IN**.

![HCL Domino Login](../../assets/images/AdminLogin3.png){: style="height:70%;width:70%"}

Enter you administrator username and password in the **Username** and **Password** fields in the **HCL Domino Login** page, and then click **Login**.  

![HCL Domino Login](../../assets/images/AdminLogin2.png){: style="height:70%;width:70%"}

If you have configured an external IdP to log in to the Admin UI, the *Log in with OIDC* will be the default login option. For more information on the needed configuration, see [Set up Admin UI external IdP login configuration](../../howto/IdP/adminuiidp.md).

You can log in to the **Admin UI** by selecting your external IdP from the down-down list, and clicking **LOG IN**. Use your external IdP authentication credentials and follow succeeding login instructions.

<!--If you have configured an external IdP to log in to the **Admin UI** and is only available after performing some configurations. For more information on the needed configurations, see [Set up Admin UI external IdP login configuration](../../howto/IdP/adminuiidp.md).

Once configured, a **LOG IN WITH {configured IdP name}** button is available on the **Admin UI** login page. You can log in to the **Admin UI** by clicking **LOG IN WITH {configured IdP name}**, using your IdP authentication credentials to log in, and following succeeding login instructions.-->

<!--The following image shows an example of the **Admin UI** login page when the user configured their own external IdPs to log in to the **Admin UI**.

![HCL Domino Login](../../assets/images/AdminUiLoginExternalIdP.png){: style="height:70%;width:70%"}

## Links

From the **Admin UI**, you can access the following:

- [Schema Management](schemaui.md)

- [Scope Management](scopeui.md)

- [Quick Config](quickconfigui.md)

- [Application Management](appui.md)

- [OAuth Consents](oauthconsentui.md)

<!--## Database Management - REST API

Select **Database Management - REST API** from the home page.-->