# OAuth Consents

Select **Consents** from the side navigation pane to access the **OAuth Consents** page, which allows the current user to view and revoke available OAuth consents. 

## View OAuth consents

The **OAuth Consents** page shows available OAuth consents. 

!!! note

    Users logged into the Admin UI that are in the `LocalKeepAdmins` group or are Managers in the `oauth.nsf` ACL will see all user consents and can revoke them as well.

[![OAuth Consent page](../../assets/images/oauthConsent.png)](../../assets/images/oauthConsent.png "Click to open in a new tab"){: target="_blank" rel="noopener noreferrer"}

!!! tip

    - Use the **Search User** or **Search App Name** search fields to search a specific OAuth consent.
    - Use the **User** and **App Name** sorting arrow icons to sort the OAuth consents by user or app name in an alphabetical or reverse alphabetical order. 
    - Set the number of OAuth consents displayed on the page by selecting a value from **Rows per page**.
    - Use the pagination arrows to move back and forth through pages.
    <!-- Click the **Go to Applications** icon on the upper right side of the **OAuth Consents** page to return to the **Application Management** page.--> 

## View OAuth consent details

**To show details of a specific OAuth consent**

- Click the expand arrow icon corresponding to a user in the list to show OAuth consent details, such as scope and URL.

!!! tip

    Clicking the collapse arrow icon corresponding to the user in the list with shown OAuth consent details hides the shown details.

**To show details of all OAuth consents**

- Click **Expand all** to show details of all the OAuth consents.

!!! tip

    Clicking **Collapse all** hides the details of all the OAuth consents. 

## Filter OAuth consents

You can use the filter function to filter which OAuth consents to display.

**To use the filter**

1. Click **All filters**. This opens the **Filter** pane.
2. Use any or all the filters as needed, and then click **Show Results**. 

For more information on the filters, refer to the following table:

|Filter|Description
|:----|:----|
|Status| Select **All** to display active and expired OAuth consents.<br/><br/>Select **Active** to show only active OAuth consents.|
|App name|Click the toggle to show only consents with application.|
|Expiration|Select **All** to display all OAuth consents regardless of expiration.<br/><br/>Select **None** to display OAuth consents without expiration.<br/><br/>Select **Custom** and then select a specific expiration date from the date picker to show only OAuth consents with expiration matching the selected expiration date.|
|Token Expiration|Select All to display all OAuth consents regardless of token expiration.<br/><br/>Select **None** to display OAuth consents without token expiration.<br/><br/>Select **Custom** and then select a specific token expiration date from the date picker to show only OAuth consents with token expiration matching the selected token expiration date.|
|Scopes|Select the scopes to show only OAuth consents with scopes matching the selected scopes.|

!!! tip

    Click **Reset** to clear all filters. 

## Revoke authorized user

1. Click **Revoke** corresponding to the authorized user in the list that you want the authorization revoked.
2. In the **Revoke Consent** dialog, click **Yes**.

The user is now removed from the authorized users list.
