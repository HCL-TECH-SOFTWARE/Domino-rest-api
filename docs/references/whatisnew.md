# What's new

The section provides the information related to Domino REST API.

<!-- prettier-ignore -->
!!! Note "Important Information about API Changes"
    Items marked in <span style="color:red">**red**</span> are API changes that may impact your applications and should be reviewed before upgrading.

???info "v1.0.6 - What's new or changed"
    ## v1.0.6 - _What's new or changed_

    **New**

    - HCL Domino REST API now supports WebAuthn allowing users to [log in to the **Admin UI** using a passkey](../howto/install/passkey.md).
    - Introduced access control for scopes via maximum access level to control the maximum access anyone using a scope might have. For example, if a scope's maximum access level is Editor and you are a Manager, the API runs as Editor. This feature doesn't increase a user's access level. The default for existing scopes is Editor.
    - Introduced `$SETUP` scope that can be added to an application, which needs access to `$SETUP` endpoints. For more information, see [Scopes](../references/usingdominorestapi/scopes.md).
    - Added `ftSearchQuery` to the `GET v1/lists/{name}` endpoint to filter a view based on a full text search query.
    - Added column multi-value delimiter and column position when retrieving information about views utilizing the `GET v1/lists?columns=true` endpoint. 
    - Enabled retrieval of Rich Text embedded images by the `GET v1/attachments/{unid}/{attachmentName}` endpoint. When retrieving the html of a Rich Text field, embedded images come back in an <img> tag such as `<img src="/test.nsf/0/a0286fbd3bdc1d5bc12222d5006ac837/Photo/0.84?OpenElement&FieldElemFormat=gif">`. Use base64 encoding to encode the image src URL and pass that in as the `attachmentName`. 

    **Improvements**

    - A database view can now be edited in the Admin UI to select which columns to include. Column external names can now also be set or edited.
    - Added ability to mark a document as read (`markRead=true`) or unread (`markUnread=true`) when getting a view that contains those documents using the `GET v1/lists/{name}` endpoint.
    - Added the ability to select only district documents (`distinctDocuments=true` when retrieving view contents via the `GET v1/lists/{name}` endpoint.
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

    **New**

    - Added `v1/docmeta/{unid}` endpoint that includes metadata information about the document specified.
    - Added `richTextAs` parameter to the `v1/bulk/create`, `v1/bulk/unid`, `v1/bulk/update` and `v1/lists/{name}` endpoints when using `documents=true`.
    - Added a list of Server Commands to the Management Page's Domino Server console.

    **Improvements**

    - Refined Rich Text MIME representation and Rich Text Markdown representation.
    - An error message now appears when deleting an ACL role using `admin-v1/acl/roles/{rolename}` while a member in the ACL still has that role.
    - Returns the rendered Markdown as HTML when retrieving a document where the Rich Text representation is HTML and the Rich Text field contains Markdown. 
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

    **New** 

    - Added parameter `metaAdditional=` to the `/lists/{name}` endpoint in `api/v1` to return additional metadata for each row. Currently just returning the Form name of the underlying document.
    - Added the OpenID `/userinfo` endpoint in `api/v1` for OIDC compliance.

    **Improvements**

    - Increased throughput performance of most endpoints.
    - Modified the `/admin/quickconfig` endpoint in `api/setup-v1` to add default values to some Schema items if not specified.
    
    **Resolved issues**

    -  A page in the **Admin UI** may time out while bringing up a list of databases if there are a lot of databases.
    - The `/attachments/{unid}` endpoint in `api/v1` didn't honor the `fieldName=` parameter. This parameter specifies the Rich Text field to attach to, instead, it attached to the document.
    
    **Others**

    - Docker image version for docker compose .env file (CONTAINER_IMAGE) is *docker.qs.hcllabs.net/hclcom/projectkeep-r12:1.17.0*.

???info "v1.0.3 - What's new or changed"
    ## v1.0.3 - _What's new or changed_

    **New** 

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

    **New**

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

    **New**

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
