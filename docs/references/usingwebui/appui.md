# Application Management

Select **Application Management - OAUTH** from the home page or **Applications** from the side navigation pane to access the **Application Management** page.

## View available applications

The **Application Management** page shows the list of all available applications.

![List Applications](../../assets/images/ListOfApplications.png){: style="height:80%;width:80%"}

## Add an application

1. On the **Application Management** page, click **Add Application** to add an application.

      <!--![Add Application](../../assets/images/AddApplication.png){: style="height:80%;width:80%"}-->

2. Under **Add New Application**, fill in the form and click **Add**.

      ![Application Form](../../assets/images/AddApplicationForm.png){: style="height:80%;width:80%"}
      
      **When your app accesses endpoints that run write operations in the `/setup-v1/` URL path, make sure to add the `$SETUP` scope aside from the `$DATA` scope** to enhance access control in relation to the app inheriting a user's access rights when the user grants app access. 


3. Click the application tile to access options to generate application secret, to edit, and to delete the application.

      ![Edit Application](../../assets/images/EditApplication.png){: style="height:80%;width:80%"}

## Access OAuth Consents

- On the **Application Management** page, click **OAuth Consents**. The **OAuth Consents** dialog opens.

All the information and features in the **OAuth Consents** dialog are the same to the information and features in the **OAuth Consents** page. For more information, see [OAUth Consents](oauthconsentui.md).