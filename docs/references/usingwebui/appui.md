# Application Management

Select **Application Management - OAUTH** from the home page or **Applications** from the side navigation pane to access the **Application Management** page.

## View available applications

The **Application Management** page shows all available applications.

![List Applications](../../assets/images/ListOfApplications.png)

!!!tip
    - Click the play button to launch the application.
    - Click the **Edit Application** icon to update the details of the application.
    - Click the **Delete Application** icon to delete the application. 
    - Use the **Search App Name** search field to search for an application by name. 
    - Set the number of applications displayed on the page by selecting a value from **Rows per page**.
    - Use the pagination arrows to move back and forth through pages.

## Add an application

1. On the **Application Management** page, click **Add Application**.
2. Under **Add New Application**, fill in the form and click **Add**.

      ![Application Form](../../assets/images/AddApplicationForm.png)

      When adding a scope, select the scope from the **Scope** drop-down list and click the **Add Scope** icon.
      
      **When your app accesses endpoints that run write operations in the `/setup-v1/` URL path, make sure to add the `$SETUP` scope aside from the `$DATA` scope** to enhance access control in relation to the app inheriting a user's access rights when the user grants app access. 

The new application is now shown in the **Application Management** page.

## Generate an app secret

- For applications without a configured app secret, click the **Click to Generate Secret** text.
- For applications with a configured app secret, click the **Click to Generate Secret** icon&nbsp;![app secret icon](../../assets/images/appsecreticon.png){: style="height:2%;width:2%"}.


<!--
## Add an application

1. On the **Application Management** page, click **Add Application** to add an application.

      ![Add Application](../../assets/images/AddApplication.png){: style="height:80%;width:80%"}

2. Under **Add New Application**, fill in the form and click **Add**.

      ![Application Form](../../assets/images/AddApplicationForm.png){: style="height:80%;width:80%"}
      
      When adding a scope, select the scope from the Scope drop-down list and click the Add Scope icon. 

      **When your app accesses endpoints that run write operations in the `/setup-v1/` URL path, make sure to add the `$SETUP` scope aside from the `$DATA` scope** to enhance access control in relation to the app inheriting a user's access rights when the user grants app access. 


3. Click the application tile to access options to generate application secret, to edit, and to delete the application.

      ![Edit Application](../../assets/images/EditApplication.png){: style="height:80%;width:80%"}
-->


## Filter applications

You can use the filter function to filter which applications to display.

**To use the filter**

1. Click the filter icon. This opens the **Filter** pane.
2. Use any or all the filters as needed, and then click **Show Results**. 

For more information on the filters, refer to the following table:

|Filter|Description
|:----|:----|
|Status| Select **All** to display active and inactive applications.<br/><br/>Select **Active** to show only active applications.<br/><br/>Select **Inactive** to show only inactive applications.|
|App secret|Select **All** to display all applications.<br/><br/>Select **Generated** to show only applications with an app secret.<br/><br/>Select **Not Generated** to show only applications without a generated app secret.|

!!!tip
    Click **Reset** in the **Filter** pane to clear all filters. 


## Access OAuth Consents

- On the **Application Management** page, click **OAuth Consents**. The **OAuth Consents** dialog opens.

All the information and features in the **OAuth Consents** dialog are the same to the information and features in the **OAuth Consents** page. For more information, see [OAUth Consents](oauthconsentui.md).