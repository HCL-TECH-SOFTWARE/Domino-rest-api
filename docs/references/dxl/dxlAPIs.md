# DXL extension API endpoints

The following tables show the DXL extension API endpoints, including their HTTP method, path, required ACL, and purpose.

## Database properties

|Method|Path|ACL|Description|
|:---|:---|:---|:---|
|GET|`/api/dxl/database`|Reader|Returns the database properties, including the title, replica ID, file path, template information, and launch settings, in JSON format.|
|PUT|`/api/dxl/database`|Manager|Updates the database properties, including launch settings.|

## Design summary

|Method|Path|ACL|Description|
|:---|:---|:---|:---|
|GET|`/api/dxl/designsummary`|Reader|Returns an inventory of all design elements in the database, grouped by design type. Each element includes its name, aliases, UNID, and note ID.|

## Design element CRUD

|Method|Path|ACL|Description|
|:---|:---|:---|:---|
|GET|`/api/dxl/{type}`|Reader|Lists design elements of the specified type.|
|GET|`/api/dxl/{type}/{name}`|Reader|Returns the design element as DXL in a JSON wrapper.|
|PUT|`/api/dxl/{type}/{name}`|Designer|Creates or replaces the named design element from a raw DXL body (`text/xml`).|
|DELETE|`/api/dxl/{type}/{name}`|Designer|Deletes the named design element permanently from the database.|

**Supported `{type}` values**:

|Type|DbDesign method|DocumentClass|
|:---|:---|:---|
|`form`|`getForm()` / `getForms()`|FORM|
|`subform`|`getSubform()` / `getSubforms()`|FORM|
|`view`|`getView()` / `getViews()`|VIEW|
|`folder`|`getFolder()` / `getFolders()`|VIEW|
|`frameset`|`getFrameset()` / `getFramesets()`|FORM|
|`page`|`getPage()` / `getPages()`|FORM|
|`agent`|`getAgent()` / `getAgents()`|FILTER|
|`scriptlibrary`|`getScriptLibrary()` / `getScriptLibraries()`|FILTER|
|`sharedfield`|`getSharedField()` / `getSharedFields()`|FIELD|
|`sharedcolumn`|`getSharedColumn()` / `getSharedColumns()`|FORM|
|`outline`|`getOutline()` / `getOutlines()`|FORM|
|`navigator`|`getNavigator()` / `getNavigators()`|FORM|
|`imageresource`|`getImageResource()` / `getImageResources()`|FORM|
|`fileresource`|`getFileResource()` / `getFileResources()`|FORM|

## Frameset JSON API

|Method|Path|ACL|Description|
|:---|:---|:---|:---|
|GET|`/api/dxl/frameset/{name}/layout`|Reader|Returns the frameset as a structured JSON tree.|
|PUT|`/api/dxl/frameset/{name}/layout`|Designer|Converts the JSON layout to DXL and imports it, or creates the frameset from the JSON spec if it does not exist.|

## ACL Management

|Method|Path|ACL|Description|
|:---|:---|:---|:---|
|GET|`/api/dxl/acl`|Manager|Returns all ACL entries and the list of roles defined in the database.|
|PUT|`/api/dxl/acl/entry/{aclEntryName}`|Manager|Creates the named ACL entry if it does not exist, or replaces it with the supplied level, roles, type, and flags.|
|DELETE|`/api/dxl/acl/entry/{aclEntryName}`|Manager|Removes the named entry from the ACL.</br></br> **`-Default-` and `LocalDomainServers` are protected and cannot be removed.**|

## Validate, export, and async import

|Method|Path|ACL|Description|
|:---|:---|:---|:---|
|POST|`/api/dxl/validate`|Reader|Performs two-pass DXL validation without importing.|
|GET|`/api/dxl/export`|Reader|Exports design elements as DXL fully or filtered by type.|
|POST|`/api/dxl/import`|Designer|Starts an async DXL import job.|
|GET|`/api/dxl/import/{jobId}`|Reader|Returns the current status of an async DXL import job.|

## Help documents

|Method|Path|ACL|Description|
|:---|:---|:---|:---|
|GET|`/api/dxl/helpdoc/{docType}`|Reader|Returns the database's **About** (NoteID 0xFFFF0002) or **Using** (NoteID 0xFFFF0100) help document as DXL.|
|PUT|`/api/dxl/helpdoc/{docType}`|Designer|Creates or replaces the database's **About** or **Using** help document.|
|DELETE|`/api/dxl/helpdoc/{docType}`|Designer|Removes the database's **About** or **Using** help document permanently.|

## Database icon

|Method|Path|ACL|Description|
|:---|:---|:---|:---|
|GET|`/api/dxl/dbicon`|Reader|Returns the database icon note as DXL. The database icon note (NoteID 0xFFFF0010, DocumentClass.ICON) is a special note that controls the workspace icon.|
|PUT|`/api/dxl/dbicon`|Designer|Creates or replaces the database icon note.|
|DELETE|`/api/dxl/dbicon`|Designer|Removes the database icon note permanently.|

## Outline

|Method|Path|ACL|Description|
|:---|:---|:---|:---|
|GET|`/api/dxl/outline/{name}/entries`|Reader|Returns the outline's entry hierarchy as a label/target/children tree. Supports both flat level-based and nested DXL formats, including the `imageref` properties.|
|PUT|`/api/dxl/outline/{name}/entries`|Designer|Converts the JSON entry tree to flat DXL with level attributes for hierarchy and imports it. Supports nested children arrays and optional `imageref` per entry, and creates the outline if it does not exist.|
