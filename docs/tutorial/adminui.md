# Using Admin UI

This tutorial shows how to use the Admin UI to configure and use a database for Domino REST API. Download the database `Demo.nsf` from [Resources](../references/downloads.md) and follow along. Anything you can do with the Admin UI you can also do using Postman, curl, Swagger UI, or similar tools. See how to do each of the tasks in this tutorial using [Postman and Curl](./postmancurl.md) and using [Swagger UI](./swagger.md).

!!! note
    The screenshots may vary. The screenshots are based on latest Domino REST API snapshots. Make sure you're up-to-date.

## Prepare database access

Download `Demo.nsf` from [Resources](../references/downloads.md) and save it in the Notes data directory.

## Login

Go to the Domino REST API Admin UI.<br>

> _For example `http://restapi.myhost.com:8880/admin/ui`, replacing the host with your Domino REST API's host._

On the login page, enter the administrator username and password, and then click **LOG IN WITH PASSWORD**.

![Login Page](../assets/images/AdminLogin.png)

See other [log in options](../references/usingwebui/index.md) to learn more.

## Landing

A successful login would lead to this landing page:

![Landing Page](../assets/images/AdminLanding.png)

!!!tip
    Starting with the Domino REST API v1.1.2 release, you can click **Overview** on the landing page, indicated by the <span style="color:red">red arrow</span> in the image, to open the Domino REST API functional diagram. Clicking parts of the functional diagram directs you to corresponding topics in the documentation.

## List available schemas

Click **Database Management - Rest API** in the landing page. This opens the **Schema Management** page.

![Schema Management Page](../assets/images/AllSchemas.png)

## Add a schema

1. In the **Schema Management** page, click **Add Schema**.

    ![Add schema](../assets/images/addSchema.png)

2. In the **Add New Schema** dialog, click **Create Schema**.

    ![Create Database Configuration](../assets/images/createSchema.png){: style="height:70%;width:70%"}

3. In the **Create Schema** dialog:

    1. Select `Demo.nsf` from the **Database** drop-down list.
    2. Select an **Icon**.
    3. Enter a **Schema Name** and a **Schema Description**.
    4. Click **Save Schema**.

This creates a schema that defines what views, folders, document, and agents you can access through the Domino REST API.

<!-- prettier-ignore -->
!!! note
    If the **Only show schemas configured with scopes** toggle is turned on, you can't see the created schema because it doesn't have a scope yet.

## Create a scope

1. Go back to the landing page by clicking **Overview**.

    ![Overview](../assets/images/overview.png)

2. Click **Database Management - Activation**. This opens the **Scope Management** page.

    ![Scope Management Page](../assets/images/ScopeManagement.png)

3. Click **Add Scope**. This opens a pane as shown below:

    ![Add scope Menu](../assets/images/AddNewScope.png)

4. Under **Available Schema**, click `Demo.nsf`. This shows a list of schemas that uses `Demo.nsf` as a database.
5. Select the schema you created earlier.
6. Under **Add New Scope**, fill in the form and click **Add**.

    For the **Server** field, enter the name of the server the scope is available on, or leave it blank for the current server. The value of the entered name must be either the server's hierarchical name or in canonical format. See the following examples for reference:

    - MyServer/MyOrg
    - CN=MyServer/O=MyOrg

    --8<-- "scopenote.md"

    For the **Maximum Access Level**, the default is **Editor**. You can set it to another value to set the scope's maximum access anyone using the scope has.

![Configure New Scope](../assets/images/ConfigureNewScope.png)

!!!note
    The **Maximum Access Level** prevents an app that has inherited a user's access rights when the user grants the app access from unauthorized altering of schemas or access control lists.  To know more about what each access level allows and to whom the access level is assigned, see [Access levels in the ACL](https://help.hcltechsw.com/domino/14.0.0/admin/conf_accesslevelsintheacl_c.html).

You can use the scope to access a schema via the Domino REST API. One NSF can be made available under more than one scope, such as with different security settings.

## Manage created schema

Go back to the **Schema Management** page, and click the schema you created earlier. This takes you to the page shown below:

![Manage Demo Schema](../assets/images/ManageDemoSchema.png)

This page allows you to set various configurations to your schema.

## Manage database forms

1. Click **Database Forms** from the menu bar. This lists all the forms available for the schema.
2. Select the form that you want to activate, click the corresponding menu icon beside the form's status, and then select **Activate**.

    ![List Forms](../assets/images/ListOfForms2.png)

<!-- prettier-ignore -->
!!!tip
    Clicking the menu icon and selecting **Deactivate** corresponding to a form deactivates the form. In the **Reset Form** dialog, click **Yes** to confirm.

**To make changes to the configured form:**

1. On the **Database Forms** tab, click the pencil icon corresponding to the configured form that you want to edit to load the form **Access Mode** page showing the `default` access mode.
2. Under **Show fields from**, hover over a field item and click the **+** icon to add the field in the form. Repeat this for all the fields you want to add.

    [![Access Mode](../assets/images/AccessMode1.png)](../assets/images/AccessMode1.png "Click to open in a new tab"){: target="_blank" rel="noopener noreferrer"}

3. Set the Read or Write access formula for each of the fields in the form.
4. Click **Save**.

To learn more, see [Schema Management](../references/usingwebui/schemaui.md#change-form-configuration).

## Manage database views

1. Click **Database Views** from the menu bar. This lists all the views for the selected database.
2. Select the view that you want to activate, and then click the corresponding **Active** option under **Status**.

    ![List Views](../assets/images/ListOfViews1.png)

<!-- prettier-ignore -->
!!!tip
    Clicking the **Inactive** option corresponding to a view deactivates the view. On the **Reset Views Columns** dialog, click **Yes** to confirm deactivation of the view.

## Manage database agents

1. Click **Database Agents** from the menu bar. This lists all the agents for the selected database.

    ![List Agents](../assets/images/ListOfAgents.png)

2. Select the agent you want to activate, and then click the corresponding **Active** option under **Status**.

<!-- prettier-ignore -->
!!! tip
    Clicking the **Inactive** option corresponding to an agent deactivates the agent.

## Logout

To log out, click the profile icon and then select **Sign Out**.

![Logout](../assets/images/AdminUILogout.png)

## Additional information

Refer to the [Swagger UI tutorial](./swagger.md) for a UI-driven tutorial for creating a document and more.
