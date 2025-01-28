# What's new

The section provides information on the latest features, improvements, and resolved issues related to Domino REST API.

<!-- prettier-ignore -->
!!! note "Important"
    - Items marked in <span style="color:red">**red**</span> are API changes that may impact your applications and should be reviewed before upgrading.
    
    - Always be aware of features that have been deprecated in the current and earlier releases by checking [deprecated features](deprecated.md).

???+ info "v1.1.2 -  What's new or changed"
    ## v1.1.2 - _What's new or changed_

    *Release date: February XX, 2025*

    **New features**

    - Added the console command `tell restapi refresh` that refreshes Domino REST API to implement a new configuration when executed on the Domino console.
    - Added the **Prevent Design Refresh** toggle in the **Admin UI** to flag the schema written to the database, so the Domino design task won't replace or delete the schema. For more information, see [Edit a schema](../references/usingwebui/schemaui.md#edit-a-schema). 

    **Improvements**

    - Added an *Overview* link on the **Admin UI** landing page that opens the Domino REST API functional diagram when clicked. Clicking parts of the functional diagram directs you to corresponding documentation topics for easier navigation.

    **Resolved issues**

    **Others**

    - Moved the `GET webdav-v1/login/idpList` endpoint from WebDAV OpenAPI to Basis OpenAPI and renamed it to `GET v1/auth/idpList` endpoint. Added the **configFor** query parameter as a required parameter of the endpoint to specify what external IdP to retrieve. 

    - Installer jar files:
	    - For Domino 14: *restapiInstall-r14.jar*
	    - For Domino 12: *restapiInstall-r12.jar*

    - Docker image version for docker compose .env file (CONTAINER_IMAGE):
        - For Domino 14: *domino-rest-api:1.1.2-r14*
        - For Domino 12: *domino-rest-api:1.1.2-r12*  
        
    - Docker image version for docker compose .env file from Harbor:
        - For Domino 14: *hclcr.io/domino/restapi:1.1.2-r14*
        - For Domino 12: *hclcr.io/domino/restapi:1.1.2-r12* 


??? info "v1.1.1 - What's new or changed"
    ## v1.1.1 - _What's new or changed_

    *Release date: December 02, 2024*

    **New features**

    - When using the DRAPI IdP users can be locked out if they enter incorrect credentials several times.  You can now view and reinstate these users without waiting for the lockout period to end via the **Management console**. For more information, see [Release suspended users](../howto/management/suspendeduser.md).

    - Users with valid JWT tokens can now be identified via the **Users** tab on the **Management console**. For more information, see [Identify known users with valid JWT token](../howto/management/usersmc.md). 

    - The Domino REST API configuration settings and where they are located can be identified via the **Config src** tab on the **Management console**. For more information, see [Find configuration sources](../howto/management/configsrc.md).

    - Domino REST API administrators can now customize which API schemas and endpoints are available to meet specific requirements and use cases. For more information, see [Customize available API schemas and endpoints](../howto/production/customAPI.md).

    - Implemented the Monaco Editor to the **Text View** mode on the **Source** tab on the **Schema Management** page of the **Admin UI**. With this implementation, users can now also edit the database schema from the **Text View** mode. For more information, see [Edit database schema JSON](../howto/database/editsourcejson.md).

    - Added a new OpenAPI landing page that shows all the general API schemas and application-specific schemas, enabling users to easily find the schemas they require.

    - Added OpenAPI schema and Swagger page for the [WebDAV API](openapidefinitions.md#webdav) that provides endpoints to perform remote Web content authoring operations that support the Office Round Trip Experience and Virtual Spreadsheet features of Domino REST API.

    - Added the console command `tell restapi idpstatus` that shows the state of the configured identity providers when executed on the Domino console.   

    **Improvements**

    - When adding a JSON object to the database schema on the **Source** tab on the **Schema Management** page in the **Admin UI**, the value of the JSON object is now validated to ensure the correct format based on the selected JSON object type. For more information, see [Edit database schema JSON](../howto/database/editsourcejson.md).

    - When adding fields to a form on the **Schema Management** page in the **Admin UI**, users can now identify the property of the field by hovering over the **info** icon beside the field name. For more information, see [Change form configuration](./usingwebui/schemaui.md#change-form-configuration).

    - The **Clear passkey** option has been removed from the **Admin UI** login page to avoid user confusion. This option only clears local storage data, not the actual passkey. To enhance the user experience, both the **LOG IN WITH PASSWORD** and **LOG IN WITH PASSKEY** options are available on the **Admin UI** login page. For more information, see [Use WebAuthn (Passkey) to log in to Admin UI](../howto/install/passkey.md).

    - Added the column attributes `twisties` and `responsesonly` to the `GET v1/lists` endpoint response when the *columns* parameter is set to true.

    - Added hourly task to refresh TLS certificates when using the **Domino Certificate Manager**.

    - Implemented the remaining special-text functions when retrieving a view. Special-text functions are calculated at runtime and include functions, such as `@DocNumber`, `@DocDecendants`, `@DocParentNumber`. 

    **Resolved issues**

    - Forms or views with some special characters were not encoded when performing a REST call to retrieve the list of fields or columns, resulting in a 405 Method Not Allowed error response. 
    - Editing a schema in the **Admin UI** led to an empty page when the name of the schema form or view contained `#`.
    - When calling the `GET v1/lists/{name}` endpoint using the view alias, the configured external names were not retrieved; instead, the column programmatic names were retrieved.
    - Implemented various fixes resolving issues when using **Domino Certificate Manager** to enable HTTPs.
    - Fixed the issue with the Domino REST API Task not always showing correctly via **Domino Administrator Monitor** pane. 
    - Fixed the issues around Office Round Trip Editing in Windows using Webdav APIs.

    **Others**

    - Added [tip for ensuring successful round-trip editing on Windows](../howto/production/roundtrip.md#to-access-and-edit-the-ms-office-file-attachment).
    
    - Added **Bruno** as one of the tools you can use when dealing with REST APIs. For more information, see [Bruno](./usertools/bruno.md).
    
    - Installer jar files:
	    - For Domino 14: *restapiInstall-r14.jar*
	    - For Domino 12: *restapiInstall-r12.jar*

    - Docker image version for docker compose .env file (CONTAINER_IMAGE):
        - For Domino 14: *domino-rest-api:1.1.1-r14*
        - For Domino 12: *domino-rest-api:1.1.1-r12*  
        
    - Docker image version for docker compose .env file from Harbor:
        - For Domino 14: *hclcr.io/domino/restapi:1.1.1-r14*
        - For Domino 12: *hclcr.io/domino/restapi:1.1.1-r12*  

??? info "v1.1 - What's new or changed"
    ## v1.1 - _What's new or changed_

    *Release date: September 30, 2024*

    **New features**

    - Domino REST API can now encrypt document fields and sign a document with keys stored in your Notes ID file. This protects data from unauthorized access and further enhances data security and integrity. 
    
        To learn more about encrypting, descrypting, and signing, see [Using encryption, decryption, and signing during development](../references/usingdominorestapi/encryptsign.md).

        To set up Domino REST API and enable this feature, see [Set up Domino REST API for encryption, decryption, and signing](../howto/production/signencrypt.md).
    
    - Domino REST API can now enable HTTPS setup in Domino using Domino's certificate configuration. To learn more, see [Enable HTTPS using the Domino Certificate Manager](../howto/production/dominohttps.md). 

    - Added support for using external IdP for Office Round Trip Experience. For more information, see [Setup external IdP for Office Round Trip Experience](../howto/IdP/roundtripidp.md).

    - Added `DELETE v1/nameddocument` endpoint to delete a named document.
    - Added `GET v1/nameddocument` endpoint to retrieve a named document using the appropriate name.
    - Added `GET v1/nameddocumentlist` endpoint to retrieve a list of named documents.
    - Added `POST v1/nameddocument` endpoint to create and update a named document. 
        
        !!!warning "Important" 
            A POST request replaces all fields listed in your schema. Ensure to include all the fields in the POST request body and the corresponding values you want to retain and overwrite. 
 
    - Added `GET v1/richtext/{richTextAs}/{unid}` endpoint that returns a stream of data from a Rich Text field based on the specified format. The endpoint is usable for all Rich Text processors and combines the functionalities of the following endpoints:

        - `GET v1/richtext/markdown/{unid}`
        - `GET v1/richtext/mime/{unid}`
        - `GET v1/richtext/plain/{unid}`

    **Improvements**

    - Domino REST API Task

        The Domino Addin Task has been updated with the following:

        - When Domino REST API is started, it displays the messages `REST API: Starting...` and then `REST API Started` instead of printing a JSON status message. 
        - When Domino REST API is stopped,  it now displays the message `REST API: Shutdown` instead of a long output of JSON.
        - The Domino REST API Java process is now integrated with the Domino process, resulting in a better-integrated product and improved reliability.
        - The Domino REST API Statistics can now be accessed via the Domino Console `SHOW STAT` command. To see just the Domino REST API statistics, use the `SHOW STAT restapi` command.
        - The `KeepManagementURL` line in the `notes.ini` is no longer necessary. If set, it will be ignored.

    - Added an option of selecting additional modes when executing [Quick Config](../references/usingwebui/quickconfigui.md).
    
    - Implemented UI enhancements to the **Source** tab under **Schema Management** in the **Admin UI**. 

    - Added an option for exporting database schema as JSON file by copying the schema and then creating a JSON file containing the copied schema. For more information, see [Export database schema as JSON file](../howto/database/exportsourcejson.md#to-create-a-json-file). 

    **Resolved issues**

    - The `GET admin-v1/access/users` endpoint returned a **404 No users found with requested name** error when the value entered for the query parameter `startsWith` included a slash character.
    - Swedish characters were not correctly encoded and displayed in the response body when Office Round Trip Experience with RichText content was attempted using `POST /v1/document` endpoint.
    - Issues were encountered when logging in with MS-OFBA via Internet Explorer 8, as some login functions were not supported by the web browser.

    **Others**

    - Updated [Edit database schema JSON](../howto/database/editsourcejson.md) and [Export schema as JSON file](../howto/database/exportsourcejson.md) based on the UI enhahcements to the **Source** tab under **Schema Management**.

    - The following endpoints have been replaced with the `GET v1/richtext/{richTextAs}/{unid}` endpoint:

        - `GET v1/richtext/markdown/{unid}`
        - `GET v1/richtext/mime/{unid}`
        - `GET v1/richtext/plain/{unid}`
    
    - Installer jar files:
	    - For Domino 14: *restapiInstall-r14.jar*
	    - For Domino 12: *restapiInstall-r12.jar*

    - Docker image version for docker compose .env file (CONTAINER_IMAGE):
        - For Domino 14: *domino-rest-api:1.1.0-r14*
        - For Domino 12: *domino-rest-api:1.1.0-r12*  
        
    - Docker image version for docker compose .env file from Harbor:
        - For Domino 14: *hclcr.io/domino/restapi:1.1.0-r14*
        - For Domino 12: *hclcr.io/domino/restapi:1.1.0-r12*  


??? info "v1.0.14 - What's new or changed"
    ## v1.0.14 - _What's new or changed_

    *Release date: June 13, 2024*

    **New features**

    - Preview: **Virtual Spreadsheet**  

        The **Virtual Spreadsheet** feature allows you to open up and edit view entries using Microsoft Excel [^1]. This feature uses the round trip editing feature of Domino REST API for Microsoft Office applications. For more information, see [Set up Virtual Spreadsheet](../howto/production/virtualsheet.md).

        [^1]: Microsoft and Excel are registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.

    - Added ability for a third-party Rich Text processor to process incoming Rich Text. For more information, see [Incoming Rich Text Processor](../references/richtextension.md#incoming-rich-text-processor). 

    **Improvements**
    
    - Added support for `contains`, `startswith`, and `endswith` in OData functions.
    - Added the `includeAttachmentMetadata` parameter to the `GET v1/attachmentnames` endpoint to output the attachment file size, created date, and modified date.
    - Added an array that contains the top-level child document UNIDs to the `@meta` object in the response of the `GET v1/document/{unid}` and `GET v1/docmeta/{unid}` endpoints.
    - Uses the correct mail template based on the Domino version when creating a second calendar using the `POST pim-v1/calendar` endpoint.
    
    - Implemented UI/UX enhancements in the [Application Management](./usingwebui/appui.md) page in the **Admin UI**.

    **Resolved issues**

    - The `POST v1/run/formula` endpoint did not allow the formula to run unless the user was in the server config *allow run formula agents*.

    **Others**
    
    - Implemented documentation updates.
    - Installer jar files:
	    - For Domino 14: *restapiInstall-r14.jar*
	    - For Domino 12: *restapiInstall-r12.jar*

    - Docker image version for docker compose .env file (CONTAINER_IMAGE):
        - For Domino 14: *domino-rest-api:1.0.14-r14*
        - For Domino 12: *domino-rest-api:1.0.14-r12*  
        
    - Docker image version for docker compose .env file from Harbor:
        - For Domino 14: *hclcr.io/domino/restapi:1.0.14-r14*
        - For Domino 12: *hclcr.io/domino/restapi:1.0.14-r12*



??? info "v1.0.12 - What's new or changed"
    ## v1.0.12 - _What's new or changed_

    *Release date: April 25, 2024*

    **New features**

    - Added `GET v1/richtextprocessors` endpoint to return a list of the available methods of returning Rich Text.
    - Added `POST v1/run/agentWithContext` endpoint to specify an array of UNIDs to run an agent on. 

        !!!note
            The agent must use `NotesSession.DocumentContext` to access the document.

    **Improvements**

    - Extended how Rich Text is processed. For more information, see [Rich Text extension](richtextension.md).
    
    - Improved OData filter processing by adding support for `in`, `contains`, `startswith`, and `endswith` clauses.
    - Enhanced user experience by allowing user to activate a form and bringing user directly into form edit mode by clicking the pencil icon corresponding to an inactive form in the **Database Form** tab in the **Admin UI** and confirming form activation.
    
    - Implemented UI/UX enhancements in the [OAuth Consents](./usingwebui/oauthconsentui.md) page in the **Admin UI**.
    - Enhanced the PIM Swagger documentation. 

    **Resolved issues**

    - An intermittent issue occurred where deleting a schema might have caused other schemas not to load or be created for that same database.
    - Running `tell restapi quit` might have crashed the Domino server.
    - An issue occurred with `pim-v1/attachments/{unid}/{attachmentName}` where deleting the attachment did not remove the attachment's icon.
    - The **External Name** field in the **Admin UI** was blank when editing a View and the column title has DBCS characters.

    **Others**

    - Implemented documentation updates.
    - Installer jar files:
	    - For Domino 14: *restapiInstall-r14.jar*
	    - For Domino 12: *restapiInstall-r12.jar*

    - Docker image version for docker compose .env file (CONTAINER_IMAGE):
        - For Domino 14: *domino-rest-api:1.0.12-r14*
        - For Domino 12: *domino-rest-api:1.0.12-r12*  
        
    - Docker image version for docker compose .env file from Harbor:
        - For Domino 14: *hclcr.io/domino/restapi:1.0.12-r14*
        - For Domino 12: *hclcr.io/domino/restapi:1.0.12-r12* 


??? info "v1.0.11 - What's new or changed"
    ## v1.0.11 - _What's new or changed_

    *Release date: March 27, 2024*

    **New features**
    
    - Added the **Add New Form Schema** button on the **Database Forms** page in the **Admin UI** to allow the creation of a Form schema for a form that does not exist in the design of the database. This is useful for the profile document update introduced in the v1.0.10 release and can also be used to add or retrieve documents when no form exists in the design. For more information, see [Add new form schema](usingwebui/schemaui.md#add-new-form-schema).
    
    - Added OData support for queries using `$select`.
    - Added OData support for the **ne** (not equal) operator in a filter.

    **Improvements**

    - Provides column hidden metadata when using the `v1/lists` endpoint and setting the value of the **columns** parameter to *true*.
    - Provides additional field metadata specifying if a **datetime** form field shows a date, a time, or both when retrieving a list of fields from the `setup-v1/design/forms/{formName}` endpoint.
    - Sets the field type correctly, depending on how the field is defined on the form, when adding a **datetime** field to a Form schema in the **Admin UI**. The field type is set to:
    
        - *date-time* when the **datetime** field with date and time is selected.
        - *date* when the **datetime** field with only date is selected.
        - *string* when the **datetime** field with only time is selected.  

    - Changed the **Inactive-Active** toggle for activating a form on the **Database Forms** page in the **Admin UI** to a 3-dot icon menu that displays available options when clicked.
    - Added an **Activate Form** dialog in the **Admin UI** to get user confirmation for activating an inactive form when the user clicks the edit icon corresponding to an inactive form.
    - Enhanced processing speed for retrieving a list of schemas with a large number of schemas in the **Admin UI**.

    **Resolved issues**

    - The error “badly formatted directory string”  was produced when creating a certificate via the **Management** page.
    - Trace logging did not work on Windows. 
    - A different form was shown to be activated when activating a form that has been searched.  

    **Others**

    - Implemented documentation updates.
    - The terms *Configure* and *Unconfigure* in relation to database forms in the **Admin UI** have been changed to *Activate* and *Deactivate*, respectively.
    - Installer jar files:
	    - For Domino 14: *restapiInstall-r14.jar*
	    - For Domino 12: *restapiInstall-r12.jar*

    - Docker image version for docker compose .env file (CONTAINER_IMAGE):
        - For Domino 14: *domino-rest-api:1.0.11-r14*
        - For Domino 12: *domino-rest-api:1.0.11-r12*  
        
    - Docker image version for docker compose .env file from Harbor:
        - For Domino 14: *hclcr.io/domino/restapi:1.0.11-r14*
        - For Domino 12: *hclcr.io/domino/restapi:1.0.11-r12* 


??? info "v1.0.10 - What's new or changed"
    ## v1.0.10 - _What's new or changed_

    *Release date: February 22, 2024*

    **New features**

    - Added `POST v1/profiledocument` endpoint to create and update an existing profile document. 
        
    !!!warning "Important" 
	    A POST request replaces all fields listed in your schema. Ensure to include all the fields in the POST request body and the corresponding values you want to retain and overwrite.

    - Added `DELETE v1/profiledocument` endpoint to delete a profile document as long as the schema allows it.
    - Added `GET setup-v1/admin/purge` endpoint to discover scopes that no longer have a valid schema because the schema no longer exists, the schema has invalid JSON, a corrupted NSF, or the NSF no longer exists.
    - Added  `POST setup-v1/admin/purge` endpoint to specify the schema and scope information to remove using the GET setup-v1/admin/purge endpoint response.
    
    - Added Microsoft Office round-trip editing capability to simplify document editing experience by launching Office documents directly into their native applications and saving changes back to the server. For more information, see [Setup Office Round Trip Experience](../howto/production/roundtrip.md).

    **Improvements**

    - <span style="color:red">The **`GET v1/profiledocument` endpoint has been updated**. Previously, this endpoint returned the complete profile document by default, but starting this release, you must define a schema to get a Profile document. The need for the schema also applies to the new `POST v1/profiledocument` and `DELETE v1/profiledocument` endpoints.</span> 
 
        <span style="color:red">Profile documents do not always have a Form associated with them. In such cases, you must create a schema for the Form named "Profile" (case sensitive). Profile documents without a Form will look for the "Profile" schema and return the error "No form and mode configuration found for Profile/default" if the schema doesn't exist.</span>
 
        <span style="color:red">The easiest way to create the "Profile" schema is to create a Form named "Profile" in the database containing all fields you need to retrieve or update and then add the Form Schema. Alternatively, you can create the schema programmatically by following the steps:</span>

        1. Call the `GET setup-v1/schema` endpoint to get the schema where you want to add the "Profile" form.
        2. Copy the response to a text editor, and modify it by adding the "Profile" form and the fields required using other Form schemas as a guide.
        3. Update the whole schema using the `POST setup-v1/schema` endpoint. 
 
        <span style="color:red">Make sure to save a copy of the `GET setup-v1/schema` response in case you need to revert to the previous version. In a future release, you will be able to add a Form schema for a form that doesn't exist in the database and will be able to add the Profile using this method.</span> 
 
        !!!note
            The `GET v1/profiledocument` endpoint no longer creates a profile document. Instead, use the `POST v1/profiledocument` endpoint to create one.

    - Reduced heap memory used by Domino REST API.
    - Added option to use a named key when using the `v1/profiledocument` endpoints.
    - Added the date time attributes of a **datetime** field when executing the `setup-v1/design/forms/{designName}` endpoint.

    **Resolved issues**

    - Passkey on **Admin UI** didn't work on newer versions of Safari.
    - The `setup-v1/design/{designType}/{designName}` endpoint returned shared libraries.

    **Others**

    - Implemented documentation updates.
    - Installer jar files:
	    - For Domino 14: *restapiInstall-r14.jar*
	    - For Domino 12: *restapiInstall-r12.jar*

    - Docker image version for docker compose .env file (CONTAINER_IMAGE):
        - For Domino 14: *domino-rest-api:1.0.10-r14*
        - For Domino 12: *domino-rest-api:1.0.10-r12*  
        
    - Docker image version for docker compose .env file from Harbor:
        - For Domino 14: *hclcr.io/domino/restapi:1.0.10-r14*
        - For Domino 12: *hclcr.io/domino/restapi:1.0.10-r12* 
    

??? info "v1.0.9 - What's new or changed"
    ## v1.0.9 - _What's new or changed_

    *Release date: December 14, 2023*

    **New features**

    - Added full support for Domino 14.
    
        To utilize the newer JVM functionality provided by Domino 14, we  now provide both a Domino 12 and a Domino 14 installer, as well as Docker images for both platforms.
 
        Older versions of the Domino REST API will run on Domino 14, but may have issues with certain endpoints. It is suggested that you follow the following steps to upgrade your Domino 12 server with the Domino REST API to Domino 14:
 
        1. Stop your Domino 12 server.
        2. Remove `restapi` from the `ServerTasks` line in `notes.ini`.
        3. Upgrade your Domino 12 server to Domino 14.
        4. Start your Domino 14 server.
        5. Stop your Domino 14 server.
        6. Install the Domino 14 version of the Domino REST API.
        7. Start Domino.

    - Added `POST v1/query/qrp/json` endpoint to perform a DQL query to get back QueryResultsProcessor JSON results. For an example of usage, see *Swagger UI*. 

    **Improvements**

    - Added a new option on the `GET v1/lists` endpoint by adding a filter parameter to return a list of available views containing the case-insensitive filter text.
    - Added warnings to the `POST setup-v1/schema` endpoint if design elements specified in the schema are not found in the database.
    - Added a new option to the`POST setup-v1/schema` endpoint by enabling the setting of `dryRun=true` to get the response and verify there are no warnings without creating the schema.
    - Enabled retrieval of the document's parent UNID in the response (@parentDocument) when retrieving view contents via `GET v1/lists/{name}` endpoint by setting `metaAdditional=true`.
    - Updated the access-control-allow-methods with the correct set of allowed methods.

    **Resolved issues**

    - Shared Fields, Shared Actions and Item Definitions were not returned when retrieving them from the `GET setup-v1/design/{designType}/{designName}` endpoint.
    - Access-control-allow-headers were not being set in the CORS response.
    - A returned field specified as Rich Text in the Form and Schema was not actually Rich Text on the document. 
    - Views or Folders were retrieved even if the column was defined as *Show Responses only*.

    **Others**

    - Removed the use of `dataSource` or a path to an NSF in the `dataSource` parameter by most `admin-v1` endpoints. See [Deprecated features](deprecated.md) for more information and recommendation.
    
    - Implemented various documentation updates.
    - Starting this release, there will be two installer jar files:
        - For Domino 14: *restapiInstall-r14.jar*
        - For Domino 12: *restapiInstall-r12.jar*
     
    - Docker image version for docker compose .env file (CONTAINER_IMAGE):
        - For Domino 14: *domino-rest-api:1.0.9-r14*
        - For Domino 12: *domino-rest-api:1.0.9-r12*  
        
    - Docker image version for docker compose .env file from Harbor:
        - For Domino 14: *hclcr.io/domino/restapi:1.0.9-r14*
        - For Domino 12: *hclcr.io/domino/restapi:1.0.9-r12* 
        


??? info "v1.0.8 - What's new or changed"
    ## v1.0.8 - _What's new or changed_

    *Release date: November 14, 2023*

    **New features**

    - OAuth will auto consent if a valid refresh token exists for a user scope application combination.
    - Added the following OAuth consent endpoints:
        
        - `GET v1/consents` returns all valid consents for the current user.
        - `GET v1/consent/{client_id}` returns all valid OAuth consents for the current user associated with the application app `id (client_id)`.
        - `DELETE v1/consents` revokes all OAuth consents that the current user has access to.
        - `DELETE v1/consent/revoke/{unid}` revokes a specific OAuth consent. The `unid` is available in the response of the consent `GET` endpoints.

        !!!warning "Important"
            - Users in the LocalKeepAdmins group or have manager access to the OAuth database (`oauth.nsf`) have access to all valid consents. 
            - Consent endpoints that act on All consents the user has access to will act on all valid consents.

    - Added endpoint `GET v1/attachmentnames/{unid}` to return a list of attachments attached to this document.
    - Added endpoint `GET v1/preview` to list endpoints that are marked as preview, may be considered beta endpoints.
    
    - Added ability to view and revoke OAuth consents in the AdminUI via the [OAuth Consents](../references/usingwebui/oauthconsentui.md#oauth-consents) pane.
    
    **Improvements**

    - Added the ability to [clone form modes](../references/usingwebui/schemaui.md#clone-a-mode) and [compare form modes](../references/usingwebui/schemaui.md#compare-modes) in the AdminUI.
    
    - Added the ability to [export a schema](../howto/database/exportsourcejson.md) and [import a schema](../references/usingwebui/schemaui.md#import-a-schema) in the AdminUI.
    
    - Added search feature in **Schema Management** to easily look for forms, views, and agents.  
    - Added ability to configure or unconfigure all database forms at the same time.
    
    **Resolved issues**

    - `POST v1/run/agent` did not run when using the agent's alias.
    - `POST v1/run/agent` did not run in the user's context when the agent is set to *Run as Web User*.
    - Calling `POST /attachments/{unid}` multiple times did not render the attachments correctly in Notes.
    - `POST v1/query` wasn't returning `richtext` fields as plain when `richTextAs=plain` was set.

    **Others**
    
    - Implemented various documentation updates.
    - Docker image version for docker compose .env file (CONTAINER_IMAGE) is *domino-rest-api:1.0.8*.
    - Docker image version for docker compose .env file from Harbor is *hclcr.io/domino/restapi:1.0.8*.



??? info "v1.0.7 - What's new or changed"
    ## v1.0.7 - _What's new or changed_

    **New features**

    - Added endpoint `GET v1/richtext/plain/{unid}` to retrieve just plain text from a `richtext` field.
    - Added endpoint `POST v1/bulk/etag` to give an entity tag (ETag) to specified documents. The endpoint is also useful in finding if a doc has been updated or deleted.
    - Added endpoint `POST v1/bulk/folder` to add or remove documents to or from folders.
    - Added endpoint `GET v1/logout` for OIDC compliance. `POST v1/logout` is still recommended as a browser's PREFETCH could potentially cause issues.
    
    - Added support for [Azure Active Directory as an IdP](../howto/IdP/configuringAD.md).
    
    - Added ability to directly [edit a schema JSON](../howto/database/editsourcejson.md) in the **Admin UI**.
    - Added the ability to specify multiple filter keys for `GET v1/lists/{name}`.
    - Added the ability to filter by top-level category in `GET v1/lists/{name}`.
    
    **Improvements**

    - Sped up the `setup-v1/admin/quickconfig` endpoint significantly, which sped up **Admin UI Quick Config**.
    - Added a file selection button for `POST v1/attachments/{unid}` in the Swagger UI to select attachments for a document.
    - Implemented UI improvements in Schema Management in the Admin UI for better user experience. 

    **Resolved issues**

    - A valid sort may fail in `GET v1/lists/{name}` under certain circumstances.
    - A document, which was deleted but in an abnormal state and showing up in a view, generated an error when retrieved via `v1/lists/{name}`.
    - Creating a view via `POST setup-v1/design` would cause an NPE if the selection formula was left off.

    **Others**

    - Implemented various documentation updates.
    - Starting this release, the installer jar file name now includes the Domino version, for example, `restapiInstall-r12.jar`. 
    - Docker image version for docker compose .env file (CONTAINER_IMAGE) is *domino-rest-api:1.0.7*. 
    - Docker image version for docker compose .env file from Harbor is *hclcr.io/domino/restapi:1.0.7*.
    

???info "v1.0.6 - What's new or changed"
    ## v1.0.6 - _What's new or changed_

    **New features**

    - HCL Domino REST API now supports WebAuthn allowing users to [log in to the **Admin UI** using a passkey](../howto/install/passkey.md).
    
    - Introduced access control for scopes via maximum access level to control the maximum access anyone using a scope might have. For example, if a scope's maximum access level is Editor and you are a Manager, the API runs as Editor. This feature doesn't increase a user's access level. The default for existing scopes is Editor.
    
    - Introduced `$SETUP` scope that can be added to an application, which needs access to `$SETUP` endpoints. For more information, see [Scopes](../references/usingdominorestapi/scopes.md).
    
    - Added `ftSearchQuery` to the `GET v1/lists/{name}` endpoint to filter a view based on a full text search query.
    - Added column multi-value delimiter and column position when retrieving information about views utilizing the `GET v1/lists?columns=true` endpoint. 
    - Enabled retrieval of Rich Text embedded images by the `GET v1/attachments/{unid}/{attachmentName}` endpoint. When retrieving the html of a `richtext` field, embedded images come back in an <img> tag such as `<img src="/test.nsf/0/a0286fbd3bdc1d5bc12222d5006ac837/Photo/0.84?OpenElement&FieldElemFormat=gif">`. Use base64 encoding to encode the image src URL and pass that in as the `attachmentName`. 

    **Improvements**

    - A database view can now be edited in the Admin UI to select which columns to include. Column external names can now also be set or edited.
    - Added ability to mark a document as read (`markRead=true`) or unread (`markUnread=true`) when getting a view that contains those documents using the `GET v1/lists/{name}` endpoint.
    - Added the ability to select only distinct documents (`distinctDocuments=true`) when retrieving view contents via the `GET v1/lists/{name}` endpoint.
    - Added ability to mark a document as read (`markRead=true`) or unread (`markUnread=true`) when retrieving a document using the `GET v1/document/{unid}` endpoint.
    - Added ability to mark a document as unread (`markUnread=true`) when updating a document using the `PUT/PATCH v1/document/{unid}` endpoints.
    - Added ability to retrieve a database's DXL utilizing the `GET setup-v1/dxl` endpoint.
    - Updated the Domino REST API serializer / deserializer so that only items specific to the fields and their types are added to the schema when creating or updating the schema. There should be no issues with pre-existing schemas, and the schema will update next time something in that schema has changed. 

    **Resolved issues**

    - An issue occurred with `GET setup-v1/design/{designType}/{designName}` when the `designName` contained characters that would normally be encoded.

    **Others**

    - Docker image version for docker compose .env file (CONTAINER_IMAGE) is *docker.qs.hcllabs.net/hclcom/projectkeep-r12:DRAPI-1.0.6*. 
    - Docker image version for docker compose .env file from Harbor is *hclcr.io/domino/restapi:1.0.6*.


???info "v1.0.5 - What's new or changed"
    ## v1.0.5 - _What's new or changed_

    **New features**

    - Added `v1/docmeta/{unid}` endpoint that includes metadata information about the document specified.
    - Added `richTextAs` parameter to the `v1/bulk/create`, `v1/bulk/unid`, `v1/bulk/update` and `v1/lists/{name}` endpoints when using `documents=true`.
    - Added a list of Server Commands to the Management Page's Domino Server console.

    **Improvements**

    - Refined Rich Text MIME representation and Rich Text Markdown representation.
    - An error message now appears when deleting an ACL role using `admin-v1/acl/roles/{rolename}` while a member in the ACL still has that role.
    - Returns the rendered Markdown as HTML when retrieving a document where the Rich Text representation is HTML and the `richtext` field contains Markdown. 
    - Searches for the text/markdown MIME part of the document and returns it if existing when retrieving a document where the Rich Text representation is Markdown but stored as MIME.
    - Updated the **Database Views** activation page in **Schema Management** for better user experience.   
 
    **Resolved issues**

    - `admin-v1/access/groups` parameters weren't working as expected.
    - `v1/scope/form/{form}` didn't return the form information when using the form's alias.
    - The default configuration wasn't set for some attributes when using the **Admin UI Quick Config** or the `setup-v1/admin/quickconfig` endpoint.
    - `v1/bulk/delete` returned an error instead of deleting the document.

    **Others**

    - Changed default Rich Text representation to MIME in the documentation.
    - Docker image version for docker compose .env file (CONTAINER_IMAGE) is *docker.qs.hcllabs.net/hclcom/projectkeep-r12:1.18.3*. 

???info "v1.0.4 - What's new or changed"
    ## v1.0.4 - _What's new or changed_

    **New features** 

    - Added parameter `metaAdditional=` to the `/lists/{name}` endpoint in `api/v1` to return additional metadata for each row. Currently just returning the Form name of the underlying document.
    - Added the OpenID `/userinfo` endpoint in `api/v1` for OIDC compliance.

    **Improvements**

    - Increased throughput performance of most endpoints.
    - Modified the `/admin/quickconfig` endpoint in `api/setup-v1` to add default values to some Schema items if not specified.
    
    **Resolved issues**

    -  A page in the **Admin UI** may time out while bringing up a list of databases if there are a lot of databases.
    - The `/attachments/{unid}` endpoint in `api/v1` didn't honor the `fieldName=` parameter. This parameter specifies the `richtext` field to attach to, instead, it attached to the document.
    
    **Others**

    - Docker image version for docker compose .env file (CONTAINER_IMAGE) is *docker.qs.hcllabs.net/hclcom/projectkeep-r12:1.17.0*.

???info "v1.0.3 - What's new or changed"
    ## v1.0.3 - _What's new or changed_

    **New features** 

    - `/lists/{listname}` API has a new parameter `keyAllowPartial=true` added to allow partial key matches.
    - New endpoint added to the setup API, call `DELETE /admin/cache` to reset the Domino REST API Scope and Schema cache, call if you are modifying Scopes or Schemas directly in Notes as opposed to the API or the Admin UI.
    
    **Improvements**

    - Removed invalid Scopes (`openid` and `email`) from the Swagger UI dropdown list of APIs / Scopes.

    **Resolved issues**

    - The Admin UI became unresponsive when populating the Database list when defining a new Schema when there were a lot of databases on the server.
    - A JWT token failed to decode if it's claims contained extended characters.
    - On a Windows Domino server, the `.wellknown` issuer may have been wrong.
    - In various endpoints, an error may have been thrown if a Rich Text CD record returns invalid or unknown data. This issue may have also prevented a database from showing up in the Admin UI.
    - When calling the `/design/{designType}/{designName}` and using the `nsfPath` parameter as opposed to the `dataSource` parameter resulted in the API trying to return that design information from KeepConfig.nsf instead of the specified database.

    **Others**

    - Docker image version for docker compose .env file (CONTAINER_IMAGE) is *docker.qs.hcllabs.net/hclcom/projectkeep-r12:1.15.0*. 

???info "v1.0.2 - What's new or changed"
    ## v1.0.2 - _What's new or changed_

    **New features**

    - Added ability to view the Domino Server console live as well as send commands from the Domino REST API management page if using admin credentials. See [Domino Console Configuration](../references/usingdominorestapi/console.md) for more information.
    
    - Added ability to send Domino Server console commands via API if using admin credentials.
    - Added ability to view the schema json within the Admin UI.
    - Added ability for customers to use a different name for fields (like an alias) in a schema,  good for obfuscating field names or for descriptive naming.
    
    **Improvements**

    - Increased speed of design element population in the Admin UI.
    - Increased stability of the Admin UI when the retrieving complex databases.
    - <span style="color:red">The `setup-v1/design` json output been modified so the design element key is the UNID, previously the key was the design element name. This change was made because design element names are not necessarily unique and part of the fix for design element population noted above.</span>

    ```json
    previous versions :
    "forms": {
              "ReportNotes": {
                  "@unid": "87A0390EA55C0D4C852567710005FF52",
                  "@name": "ReportNotes",
                  ...

    current version :
    "forms": {
            "87A0390EA55C0D4C852567710005FF52": {
                "@unid": "87A0390EA55C0D4C852567710005FF52",
                "@name": "ReportNotes",
                ...
    ```

    **Others**

    - Docker image version for docker compose .env file (CONTAINER_IMAGE) is *docker.qs.hcllabs.net/hclcom/projectkeep-r12:1.12.0*.

???info "v1.0.1 - What's new or changed"
    ## v1.0.1 - _What's new or changed_

    **New features**

    - The installer now has an upgrade option. Please see the [installation instructions](../tutorial/installconfig/index.md) for more information.
    
    - A Quick Config option is now available to the Admin UI (lightning bolt on the left side). This feature creates a populated Schema and Scope based on the database you choose.
        - The Schema is configured with all visible Forms and Views.
        - All non-system fields are added to the Forms.
    
    **Improvements**

    - Added the `PATCH` verb to the APIs `/api/v1/document/{unid}` and `/api/v1/bulk/update` allowing a document update without the need to provide all fields in the schema.

    - <span style="color:red">Field schema has been modified. The boolean fields `readOnly` and `writeOnly` were removed and replaced with String field `fieldAccess` which specifies the access of this field, either `RW`, `RO` or `WO`. If existing schemas have the old fields, they will be still processed correctly.</span>
    - `null` has been added as valid json for document updating, setting a field value to `null` will remove that field from the document.
    - Inactive scopes will no longer show in the Swagger UI's drop down list since they're not available.
    - Performance improvements.
    
    **Resolved issues**

    - The Domino restapi task may not successfully start on Linux Domino.
    - A document was prevented from being created or updated if one of it's multi-value fields had empty value(s).
    - Fixed multiple issues around odata.

    **Others**

    - Docker image version for docker compose .env file (CONTAINER_IMAGE) is *docker.qs.hcllabs.net/hclcom/projectkeep-r12:1.10.0*.

???info "v1.0 - What's changed since the Early Access Release"
    ## v1.0 - _What's changed since the Early Access Release_

    **Improvements**

    - The `core` api (`/api/v1`) has changed name, it's now `basis`, but still has the same path (`/api/v1`).
    - The `design`, `schema`, `scope`, and some `administrative` APIs that were in the `core` api have been moved to the `setup` api (`/api/setup-v1`). This has been done so that these apis can be disabled from a user facing server.
    - The Domino REST API landing page now has a single button for the Swagger UI, once in the Swagger UI, use the drop down at the top right to switch between API specifications.

???info "HCL Domino REST API formerly known as HCL Project KEEP"
    ## HCL Domino REST API formerly known as HCL Project KEEP

    *HCL Project KEEP* was introduced as an Early Adopter program. We've re-branded *HCL Project KEEP* to *HCL Domino REST API* to align with the *HCL VOLT MX GO* strategy. You will find that there are still references to the KEEP branding throughout the product and in the documentation. Refer to the *KEEP branding examples* table to see areas and documentation pages where the KEEP branding is still prevalent.

    | KEEP branding examples|
    | ---- |
    | [Enabling a database](../howto/database/enablingadb.md) |
    | [The Domino REST API CLI](../references/usingdominorestapi/keepcli.md#keepcmd) |
    | [Running Agents: keepAgents.nsf](../topicguides/agents.md#running-agents) |
    | [Parameters - AsyncAgentScheduler verticle: keepAgents.nsf](../references/parameters.md#asyncagentscheduler-verticle) |
    | [Domino REST API Roles](../references/usingdominorestapi/roles.md) |
    | [Factories and Caches: KeepFactory & KeepConfig](../topicguides/KeepFactory-and-caches.md) |
    | [HCL Tutorials, may reference KEEP](https://opensource.hcltechsw.com/domino-keep-tutorials) |
    | HCL Documentation, images and image file names may reference KEEP |
