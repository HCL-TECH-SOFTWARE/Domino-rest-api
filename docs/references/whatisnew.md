# What's New

<!-- prettier-ignore -->
!!! Note "Important Information about API Changes"
    Items below that are marked in <span style="color:red">**red**</span> are API changes that may impact your application(s) and should be reviewed before upgrading.

## v1.0.3 - _What's new or changed_

- Fixed an issue where the Admin UI may become unresponsive when populating the Database list when defining a new Schema when there are a lot of databases on the server.
- `/lists/{listname}` API has a new parameter `keyAllowPartial=true` added to allow partial key matches.
- Fixed an issue where a JWT token will fail to decode if it's claims contain extended characters.
- Fixed an issue where, on a Windows Domino server, the `.wellknown` issuer may be incorrect.
- New endpoint added to the setup API, call `DELETE /admin/cache` to reset the Domino REST API Scope and Schema cache, call if you are modifying Scopes or Schemas directly in Notes as opposed to the API or the Admin UI.
- Fixed an issue where, in various endpoints, an error may be thrown if a Rich Text CD record returns invalid or unknown data.  This issue may have also prevented a database from showing up in the Admin UI.
- Fixed an issue when calling the `/design/{designType}/{designName}` and using the `nsfPath` parameter as opposed to the `dataSource` parameter results in the API trying to return that design information from KeepConfig.nsf instead of the specified database.
- Remove invalid Scopes (`openid` and `email`) from the Swagger UI dropdown list of APIs / Scopes.
- Docker image version for docker compose .env file (CONTAINER_IMAGE) is *docker.qs.hcllabs.net/hclcom/projectkeep-r12:1.15.0*

## v1.0.2 - _What's new or changed_

- Increased speed of design element population in the Admin UI.
- Increased stability of the Admin UI when the retrieving complex databases.
- Added ability to view the Domino Server console live as well as send commands from the Domino REST API management page if using admin credentials. See [Domino Console Configuration](../references/usingdominorestapi/console.md) for more information.
- Added ability to send Domino Server console commands via API if using admin credentials.
- Added ability to view the schema json within the Admin UI.
- Added ability for customers to use a different name for fields (like an alias) in a schema,  good for obfuscating field names or for descriptive naming.
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

- Docker image version for docker compose .env file (CONTAINER_IMAGE) is *docker.qs.hcllabs.net/hclcom/projectkeep-r12:1.12.0*

## V1.0.1 - _What's new or changed_

- Resolved issues that could cause the Domino restapi task to not successfully start on Linux Domino.
- The installer now has an upgrade option. Please see the [installation instructions](../tutorial/installconfig/index.md) for more information.
- Added the `PATCH` verb to the APIs `/api/v1/document/{unid}` and `/api/v1/bulk/update` allowing a document update without the need to provide all fields in the schema.
- Resolved an issue that prevented a document from being created or updated if one of it's multi-value fields had empty value(s).
- Fixed multiple issues around odata.
- Quick Config option was added to the Admin UI (lightning bolt on the left side). This feature creates a populated Schema and Scope based on the database you choose.
    - The Schema is configured with all visible Forms and Views.
    - All non-system fields are added to the Forms.
- <span style="color:red">Field schema has been modified. The boolean fields `readOnly` and `writeOnly` were removed and replaced with String field `fieldAccess` which specifies the access of this field, either `RW`, `RO` or `WO`. If existing schemas have the old fields, they will be still processed correctly.</span>
- `null` has been added as valid json for document updating, setting a field value to `null` will remove that field from the document.
- Inactive scopes will no longer show in the Swagger UI's drop down list since they are not available.
- Performance improvements.
- Docker image version for docker compose .env file (CONTAINER_IMAGE) is *docker.qs.hcllabs.net/hclcom/projectkeep-r12:1.10.0*

## V1.0 - _What's changed since the Early Access Release_

- The `core` api (`/api/v1`) has changed name, it is now `basis`, but still has the same path (`/api/v1`).
- The `design`, `schema`, `scope` and some `administrative` APIs that were in the `core` api have been moved to the `setup` api (`/api/setup-v1`). This has been done so that these apis can be disabled from a user facing server.
- The Domino REST API landing page now has a single button for the Swagger UI, once in the Swagger UI, use the drop down at the top right to switch between API specifications.

## **HCL Domino REST API formerly known as HCL Project KEEP**

`HCL Project KEEP` was introduced as an Early Adopter program. We have re-branded `HCL Project KEEP` to `HCL Domino REST API` to align with our `HCL VOLT MX GO` strategy.
You will find that there are still references to the KEEP branding throughout the product and in the documentation. Please see the table at the [bottom of this page](#keep-branding-examples) to see those areas where the KEEP branding is still prevalent.

### KEEP Branding Examples

| Examples of pages in the documentation still referring to KEEP                                                                       |
| ------------------------------------------------------------------------------------------------------------------------------------ |
| [Enabling a database](../howto/enablingadb.md)                                                                                       |
| [The Domino REST API CLI](../references/usingdominorestapi/keepcli.md#keepcmd)                                                       |
| [Running Agents: keepAgents.nsf](../topicguides/agents.md#running-agents)                                                            |
| [Parameters - AsyncAgentScheduler verticle: keepAgents.nsf](../references/quickreference/parameters.md#asyncagentscheduler-verticle) |
| [Domino REST API Roles](../references/usingdominorestapi/roles.md)                                                                   |
| [Factories and Caches: KeepFactory & KeepConfig](../topicguides/KeepFactory-and-caches.md)                                           |
| [HCL Tutorials, may reference KEEP](https://opensource.hcltechsw.com/domino-keep-tutorials)                                          |
| `HCL Documentation, images and image file names may reference KEEP`                                                                  |
