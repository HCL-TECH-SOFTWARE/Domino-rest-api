# Using Web UI

The Admin UI provides a user interface to a number of Domino REST APIs. It thus serves an example what a [React](https://reactjs.org/) application using the Domino REST APIs is capable of. It covers schema, scope, and app management. Anything that can be done using the WebUI can also be done using Postman, curl, SwaggerUI, or similar tools. There are [tutorials](../../tutorial/index.md) to walk you through the same.

<!-- prettier-ignore -->
!!! note
    The screenshots may vary. The screenshots are based on the latest Domino REST API snapshots. Make sure you're up-to-date

This is what the login page looks like.

![Domino REST API](../../assets/images/AdminLogin.png)
(Image: Castle [Johannisburg](https://en.wikipedia.org/wiki/Schloss_Johannisburg), Aschaffeburg, Germany)

You'll need the administrator username and password to access the server.

To use a Domino database in Domino REST API, it must be configured for use in the API. Download `Demo.nsf` from [Resources](../../references/downloads.md) and save it in the Notes data directory. Then login to the Domino REST API Admin UI using the administrator user name and password.

For more information on logging in to the Domino REST API Admin UI, see [Login](../../tutorial/adminui.md#login).

## Database Management - REST API

Select **Database Management - REST API** from the home page.

---

### List Available Database Schemas

The **Schema Management** page shows the list of all available schemas.

![List Database](../../assets/images/ListSchemas.PNG)

You can arrange the schema names in either list or grid view or sort them alphabetically. There is also a provision to search through the list.

---

### Add A Schema

1. On the **Schema Management** page, click **Add Schema** to add a database schema.

   ![Create Database Configuration](../../assets/images/createSchema.png)

   The shape of data available is referred to as a schema. The schema is an JSON file in the design resources of the database. It gets created by a developer with Designer access to the NSF.

   This creates the Alias. You can use this to access the database via the Domino REST API. One NSF can be made available under more than one alias (such as with different security settings).

   ![Create Database Form](../../assets/images/AddSchemaForm.PNG)

2. Under **Available Databases**, select a database from the list of databases available to the Domino REST API.
3. Under **Add New Schema**, enter details in the **Schema Name** and **Description**, and then select the **Formula Engine** for the schema you want to create.
4. Click **Add**.

### List Available Forms

1. Select a schema from the list of schemas and the details for it will load.
2. Select **Database Forms** from the menu bar to show the list of all the Forms for the selected database.

   ![List Forms](../../assets/images/ListOfForms.png)

### Configure a Form

1. From the list of **Unconfigured Forms**, select the Form that you would like to configure.
2. In the **Configure** dialog, select **Yes**.

The selected form is now configured with default settings and listed under **Configured Forms**.

To make changes to the configuration:

1. Select the Form. This loads the `default` Access Mode for the Form.

   ![Access Mode](../../assets/images/AccessMode.png)

2. Set the Read or Write access formula for each of the fields in the Form.

---

### List Available Views

1. Select a schema from the list of schemas and the details for it will load.
2. Select **Database Views** from the menu bar. This lists all the Views for the selected schema.

   ![List Views](../../assets/images/ListOfViews.png)

### Activate a View

1. Click a View that you would like to activate to move it to **Activated Views**.
2. Click **Save**.

<!-- prettier-ignore -->
!!! tip
    Clicking on a View from the **Activated Views** undos the selection.

---

### List Available Agents

1. Select a schema from the list of schemas and the details for it will load.
2. Select **Database Agents** from the menu bar. This lists all the Agents for the selected database.

   ![List Agents](../../assets/images/ListOfAgents.png)

### Activate an Agent

1. Click an Agent that you would like to activate to move it to **Activated Agents**.
2. Click **Save**.

<!-- prettier-ignore -->
!!! tip
    Clicking on an Agent from the **Activated Agents** section undos the selection.

---

## Database Management - Activation

Select **Database Management - Activation** from the home page.

---

### Add A Scope

1. On the **Scope Management** page, click **Add Scope** to add a database.

   ![Create Database Scope](../../assets/images/CreateDatabaseBlue.png)

2. Under **Available Schema**, select the schema that the scope will belong to.
3. Under **Add New Scope**, fill in the form and click **Add**.

   ![Configure Database](../../assets/images/AddNewDatabase.png)

A scope points to a schema that's contained in a database. A database can have multiple schemas for different use cases and a schema can be pointed to by more than one scope

---

## Application Management - OAuth

Select **Application Management - OAuth** from the home page.

---

### List Available Applications

The **Application Management** page shows the list of all available applications.

![List Applications](../../assets/images/ListOfApplications.png)

---

### Add An Application

1. On the **Application Management** page, click **Add Application** to add an application.

   ![Add Application](../../assets/images/AddApplication.png)

2. Under **Add New Application**, fill in the form and click **Add**.

   ![Application Form](../../assets/images/AddApplicationForm.png)

3. Hover over the application tile to access options to generate Application Secret, and edit and delete the application.

   ![Edit Application](../../assets/images/EditApplication.png)
