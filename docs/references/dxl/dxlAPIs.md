# DXL extension API endpoints

!!! warning "Important"

    **The DXL Extension API is experimental and is provided for users to try and evaluate. It is not yet supported for production use.**

    The DXL Extension API is disabled by default. To enable it, see [Enable CalDav, CardDav, and DXL extension APIs](../../howto/production/davdxl.md).

    For any feedback, questions, or issues, you may post them in the [OpenNTF Discord channel](https://discord.com/invite/jmRHpDRnH4 "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../assets/images/external-link.svg){: style="height:15px;width:15px"}.

The following tables show the DXL extension API endpoints, including their HTTP method, path, required ACL, and purpose.

!!! tip

    All endpoints use the standard HCL Domino REST API authentication model, which requires a JWT bearer token. The interactive Swagger UI is available at `http://<host>:8880/openapi/swagger-ui/?url=/api/dxl/schema/openapi.dxlext.json`.

## Database properties

### GET /database

=== "Description"

    Returns the database properties, including the title, replica ID, file path, design template name, and launch settings (Notes client and web browser) in JSON format.

=== "Path"

    `/api/dxl/database`

=== "ACL"

    Reader

=== "Request"

    Sample request:

    ```http
    GET /api/dxl/database?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
    "replicaId": "AABBCCDD00112233",
    "title": "My Application",
    "filePath": "apps/myapp.nsf",
    "designTemplate": "",
    "launchSettings": {
        "notes": {
           "whenOpened": "openframeset",
           "framesetName": "MainFrameset"
        }
      }
    }
    ```

    !!! note
    
        The `launchSettings` object is extracted by exporting the database icon note as DXL. If the database has no explicit launch settings, `launchSettings` will be an empty object. If the DXL parse fails, a `parseError` field is included but basic fields, such as title and replicaId, are always returned.

### PUT /database

=== "Description"

    Updates the database title and launch settings. Only the fields included in the request are modified, while omitted fields remain unchanged.

=== "Path"

    `/api/dxl/database`

=== "ACL"

    Manager

=== "Request"

    Sample request:

    ```http
    PUT /api/dxl/database?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    Content-Type: application/json

    {
        "title": "My Application v2",
        "notes": {
            "whenOpened": "openframeset",
            "framesetName": "MainFrameset"
        }
    }
    ```    

    **Notes client `whenOpened` values**

    | Value | Effect |
    |:---|:---|
    | `openaboutdocument` | Show About document |
    | `openframeset` | Open a specific frameset |
    | `restorelastview` | Restore the last-used view |
    | `openfirstdocument` | Open the first document |
    | `openpage` | Open a named page |
    | `openxpage` | Open an XPage |
    | `opencompapp` | Open a composite application |

    **Web `whenOpened` values:**

    - `page` 
    - `view`
    - `url`
    - `doclink`

=== "Response"

    Sample response:

    ```json
    {
    "status": "ok",
    "log": "<DXLImportLog/>"
    }
    ```

---

## Design summary

### GET /designsummary

=== "Description"

    Returns every design elements in the database, grouped by type. Each element includes its name, aliases, UNID, and note ID. No DXL is returned, keeping the response lightweight. Design element types with no entries are omitted.

=== "Path"

    `/api/dxl/designsummary`

=== "ACL"

    Reader

=== "Request"

    Sample request:

    ```http
    GET /api/dxl/designsummary?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
      "database": "My Application",
      "replicaId": "85257ABC00123DEF",
      "totalCount": 42,
      "types": {
        "form": {
          "count": 3,
          "elements": [
            { "name": "MainForm", "aliases": ["MF"], "unid": "AABBCCDD...", "noteId": 256 },
            { "name": "SubForm",  "unid": "11223344...", "noteId": 260 },
            { "name": "Feedback", "aliases": ["FB", "FeedbackForm"], "unid": "55667788...", "noteId": 264 }
          ]
        },
        "view": {
          "count": 2,
          "elements": [
            { "name": "AllDocuments", "aliases": ["All"], "unid": "DDEE0011...", "noteId": 512 },
            { "name": "ByAuthor", "unid": "FFAA2233...", "noteId": 516 }
          ]
        }
      }
    }
    ```

    !!! note

        Elements without aliases omit the `aliases` field entirely. The `database` and `replicaId` fields make the response self-describing, which is useful when working with multiple databases.

---

## Design elements

### GET /{type}

=== "Description"

    Lists every design element of the requested type with name, UNID, and note ID.

=== "Path"

    `/api/dxl/{type}`

=== "ACL"

    Reader

=== "Request"

    Sample request:

    ```http
    GET /api/dxl/form?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
      "type": "form",
      "count": 3,
      "elements": [
        { "name": "MainForm", "unid": "AABBCCDD...", "noteId": 256 },
        { "name": "SubForm",  "unid": "11223344...", "noteId": 260 }
      ]
    }
    ```

### GET /{type}/{name}

=== "Description"

    Exports a single design element as DXL wrapped in a JSON response.

=== "Path"

    `/api/dxl/{type}/{name}`

=== "ACL"

    Reader

=== "Request"

    Sample request:

    ```http
    GET /api/dxl/form/MainForm?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
      "type": "form",
      "name": "MainForm",
      "unid": "AABBCCDD00112233AABBCCDD00112233",
      "noteId": 256,
      "dxl": "<form name='MainForm' ...>...</form>"
    }
    ```

    !!! note
    
        The `dxl` field contains the raw element DXL without an XML declaration or DOCTYPE.

### PUT /{type}/{name}

=== "Description"

    Imports a single design element from raw DXL. The element is created if it does not exist, or it is replaced if it already does. The DXL body must be the element fragment, and not a full `<database>` document. The imported element is automatically signed after import. 
    
    When the calling user is authenticated via a method compatible with ID Vault, such as SAML or OAuth, the note is signed with their own identity to preserve an audit trail of who deployed the element. When the user's ID cannot be retrieved, the note is signed with the server ID instead. Either way, agents and script libraries are immediately runnable.

=== "Path"

    `/api/dxl/{type}/{name}`

=== "ACL"

    Designer

=== "Request"

    Sample request:

    ```http
    PUT /api/dxl/form/MainForm?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    Content-Type: text/xml

    <form name='MainForm' xmlns='http://www.lotus.com/dxl'>
    ...
    </form>
    ```

    !!! note

        Do not include an `<?xml ...?>` declaration or DOCTYPE at the top of the body. The importer wraps your fragment in a `<database>` element before parsing, which makes an XML declaration illegal and causes a fatal parse error. For more information, see [Notes on DXL Format](dxlguide.md#notes-on-dxl-format).

=== "Response"

    Sample response:

    ```json
    {
      "status": "ok",
      "importedCount": 1,
      "log": "<DXLImportLog>...</DXLImportLog>"
    }
    ```

### DELETE /{type}/{name}

=== "Description"

    Permanently removes the named element from the database.

=== "Path"

    `/api/dxl/{type}/{name}`

=== "ACL"

    Designer

=== "Request"

    Sample request:

    ```http
    DELETE /api/dxl/form/MainForm?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
      "deleted": true,
      "type": "form",
      "name": "MainForm",
      "unid": "AABBCCDD00112233AABBCCDD00112233"
    }
    ```

    !!! note

        Returns a **404 Not Found** response if the specified design element does not exist.

### Supported `{type}` values

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

---

## Framesets

Framesets have two additional endpoints that work with a structured JSON representation of the frameset layout instead of raw DXL, making them easier to create and parse programmatically.

### GET /frameset/{name}/layout

=== "Description"

    Returns the frameset as a structured JSON tree.

=== "Path"

    `/api/dxl/frameset/{name}/layout`

=== "ACL"

    Reader

=== "Request"

    Sample request:

    ```http
    GET /api/dxl/frameset/MainFrameset/layout?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
      "name": "MainFrameset",
      "orientation": "rows",
      "sizes": ["50px", "1", "30px"],
      "content": [
        {
          "type": "frame",
          "name": "Header",
          "target": { "kind": "page", "name": "HeaderPage" }
        },
        {
          "type": "frame",
          "name": "Content",
          "target": { "kind": "view", "name": "AllDocuments" },
          "scrolling": "auto"
        },
        {
          "type": "frame",
          "name": "Footer",
          "target": { "kind": "url", "url": "/footer.html" }
        }
      ]
    }
    ```

    !!! note

        - The value of `orientation` is `rows` if frames are stacked vertically, or `columns` if frames are side by side.
        - `sizes` has one entry per frame. A plain number like `"1"` means "take remaining space."
        - Returns a **404 Not Found** response if the frameset does not exist.

### PUT /frameset/{name}/layout

=== "Description"

    Converts the JSON layout to DXL and imports it, or creates the frameset from the JSON spec if it does not exist.

=== "Path"

    `/api/dxl/frameset/{name}/layout`

=== "ACL"

    Designer

=== "Request"

    Sample request:

    ```http
    PUT /api/dxl/frameset/MainFrameset/layout?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    Content-Type: application/json

    {
      "orientation": "columns",
      "sizes": ["239px", "1"],
      "content": [
        {
          "type": "frame",
          "name": "Nav",
          "target": { "kind": "view", "name": "NavView" }
        },
        {
          "type": "frame",
          "name": "Main",
          "target": { "kind": "view", "name": "AllDocs" },
          "scrolling": "auto",
          "targetFrame": "Main"
        }
      ]
    }
    ```
    !!! note

        - The **frame target kinds** are `page`, `view`, `form`, `frameset`, and `url`.
        - For nested framesets, include a content item of `"type": "frameset"` with its own `orientation`, `sizes`, and `content` array.

=== "Response"

    Sample response:

    ```json
    {
      "status": "ok",
      "importedCount": 1,
      "log": "<DXLImportLog/>"
    }
    ```

---

## Outlines

Outlines have two additional endpoints that work with a structured JSON representation of the entry hierarchy instead of raw DXL. This makes it straightforward to add, reorder, or rename outline entries without having to modify the DXL directly. This is particularly useful in hybrid-mode workflows where an outline is copied from a reference database and its view targets need to be updated.

### GET /outline/{name}/entries

=== "Description"

    Returns the outline's entry hierarchy as a label/target/children tree. Supports both flat level-based and nested DXL formats, including the `imageref` properties.

=== "Path"

    `/api/dxl/outline/{name}/entries`

=== "ACL"

    Reader

=== "Request"

    Sample request:

    ```http
    GET /api/dxl/outline/MainOutline/entries?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
      "name": "MainOutline",
      "entries": [
        {
          "label": "All Documents",
          "frame": "NotesView",
          "target": { "kind": "view", "name": "All Documents" }
        },
        {
          "label": "Administration",
          "children": [
            {
              "label": "Pending",
              "frame": "NotesView",
              "target": { "kind": "view", "name": "Pending Approval" }
            }
          ]
        }
      ]
    }
    ```

    !!! note

        Returns a **404 Not Found** response if the outline does not exist.

### PUT /outline/{name}/entries

=== "Description"

    Converts the JSON entry tree to flat DXL with level attributes for hierarchy and imports it. Supports nested children arrays and optional `imageref` per entry. Creates the outline if it does not exist, or replaces it entirely if it does.

=== "Path"

    `/api/dxl/outline/{name}/entries`

=== "ACL"

    Designer

=== "Request"

    Sample request:

    ```http
    PUT /api/dxl/outline/MainOutline/entries?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    Content-Type: application/json

    {
      "entries": [
        {
          "label": "All Documents",
          "frame": "NotesView",
          "target": { "kind": "view", "name": "All Documents" }
        },
        {
          "label": "Administration",
          "children": [
            {
              "label": "Pending",
              "frame": "NotesView",
              "target": { "kind": "view", "name": "Pending Approval" }
            }
          ]
        }
      ]
    }
    ```

    **Entry fields**

    | Field | Type | Description |
    |---|---|---|
    | `label` | string (required) | Display text for the entry |
    | `frame` | string | Target frame that opens when a link from this entry is clicked |
    | `alias` | string | Alternate name |
    | `expanded` | boolean | Whether the entry is expanded by default |
    | `target` | object | Where the entry navigates to (see below) |
    | `children` | array | Nested entries — supports any depth |

    **Target object**

    | Field | Description |
    |---|---|
    | `kind` | One of `view`, `form`, `page`, `frameset`, `navigator`, `url` |
    | `name` | Design element name (all kinds except `url`) |
    | `url` | URL string (kind `url` only) |

=== "Response"

    Sample response:

    ```json
    {
      "status": "ok",
      "importedCount": 1,
      "log": "<DXLImportLog/>"
    }
    ```
---

## DXL export

### GET /export

=== "Description"

    Exports design elements from the database as a DXL `<database>` document fully or filtered by type.

=== "Path"

    `/api/dxl/export`

=== "ACL"

    Reader

=== "Request"

    Sample request:

    **Full export**: includes database properties, ACL, and all design elements

    ```http
    GET /api/dxl/export?nsfPath=apps/myapp.nsf&full=true
    Authorization: Bearer <token>
    ```

    **Filtered export by type**: exports only the listed element types

    ```http
    GET /api/dxl/export?nsfPath=apps/myapp.nsf&types=form,view
    Authorization: Bearer <token>
    ```

    **Filtered export with database properties**: adds `include=properties`

    ```http
    GET /api/dxl/export?nsfPath=apps/myapp.nsf&types=form&include=properties
    ```

=== "Response"

    Sample response:

    For **full export** that includes database properties, ACL, and all design elements

    ```json
    {
      "mode": "full",
      "dxl": "<database xmlns='http://www.lotus.com/dxl'>...</database>"
    }
    ```

    For **filtered export by type** that exports only the listed element types

    ```json
    {
      "mode": "filtered",
      "types": ["form", "view"],
      "elementCount": 12,
      "dxl": "<database xmlns='http://www.lotus.com/dxl'>...</database>"
    }
    ```

    For **filtered export with database properties** that add `include=properties`

    ```json
    {
      "mode": "filtered",
      "types": ["form"],
      "elementCount": 4,
      "dxl": "<database ...>...</database>",
      "propertiesDxl": "<database ...>...</database>"
    }
    ```

    !!! note
    
        The `propertiesDxl` field is a separate DXL document containing only database-level properties (useful for replicating launch settings without copying design elements).

---

## DXL validate

### POST /validate

=== "Description"

    Performs a two-pass validation: first verifies that the XML is well-formed, then runs the importer in dry-run mode without writing any changes. Use this endpoint before starting an asynchronous import operation.

=== "Path"

    `/api/dxl/validate`

=== "ACL"

    Reader

=== "Request"

    Sample request:

    ```http
    POST /api/dxl/validate?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    Content-Type: application/json

    {
      "dxl": "<database xmlns='http://www.lotus.com/dxl'><form name='Test'>...</form></database>"
    }
    ```

    !!! note

        The DXL must be wrapped in a `<database>` element. A leading UTF-8 BOM is accepted and stripped automatically.

=== "Response"

    Sample response:

    **Valid response**

    ```json
    {
      "valid": true,
      "errors": [],
      "warnings": []
    }
    ```

    **Invalid response**

    ```json
    {
      "valid": false,
      "errors": ["Root element is not <database>"],
      "warnings": []
    }
    ```

---

## DXL import (Async)

Large DXL imports run asynchronously. Start the import by sending a `POST /import` request, then poll `GET /import/{jobId}` until the job completes.

### POST /import

=== "Description"

    Starts an async DXL import job.

    !!! note

        Before the import begins, the DXL is automatically preprocessed. Any leading UTF-8 byte order mark (BOM) and whitespace before the first `<` character are removed, allowing imports to succeed even with files exported from, for example, PowerShell.

=== "Path"

    `/api/dxl/import`

=== "ACL"

    Designer

=== "Request"

    Sample request:

    ```http
    POST /api/dxl/import?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    Content-Type: application/json

    {
      "dxl": "<database xmlns='http://www.lotus.com/dxl'>...</database>",
      "options": {
        "designOption": "replaceElseCreate",
        "documentsOption": "ignore",
        "replaceDbProperties": false
      }
    }
    ```

    **Options**

    | Field | Default | Description |
    |---|---|---|
    | `designOption` | `replaceElseCreate` | How to handle existing design elements |
    | `documentsOption` | `ignore` | How to handle documents in the DXL |
    | `replaceDbProperties` | `false` | Whether to update database-level properties |

    **Option values:** 
    
    - `replaceElseCreate`
    - `replaceElseIgnore`
    - `ignoreElseCreate`
    - `create`
    - `ignore`

=== "Response"

    Sample response:

    ```json
    {
      "jobId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
      "status": "running",
      "nsfPath": "apps/myapp.nsf"
    }
    ```

### GET /import/{jobId}

=== "Description"

    Returns the current status of an async DXL import job.

=== "Path"

    `/api/dxl/import/{jobId}`

=== "ACL"

    Reader

=== "Request"

    Sample request:

    ```http
    GET /api/dxl/import/f47ac10b-58cc-4372-a567-0e02b2c3d479?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    **Status: running**

    ```json
    {
      "jobId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
      "status": "running"
    }
    ```

    **Status: complete**

    ```json
    {
      "jobId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
      "status": "complete",
      "importedCount": 14,
      "log": "<DXLImportLog>...</DXLImportLog>"
    }
    ```

    **Status: error**

    ```json
    {
      "jobId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
      "status": "error",
      "error": "DXL is blank"
    }
    ```

    !!! note

        Returns a **404 Not Found** response if the job ID is unknown or has expired.

---

## ACL management

### GET /acl

=== "Description"

    Returns all ACL entries and the list of roles defined in the database.

=== "Path"

    `/api/dxl/acl`

=== "ACL"

    Manager

=== "Request"

    Sample request:

    ```http
    GET /api/dxl/acl?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
      "entries": [
        {
          "name": "-Default-",
          "level": "NOACCESS",
          "type": "UNSPECIFIED",
          "roles": [],
          "flags": []
        },
        {
          "name": "CN=Alice Example/O=MyOrg",
          "level": "EDITOR",
          "type": "PERSON",
          "roles": ["[Approver]"],
          "flags": ["NODELETE_DOCUMENT"]
        }
      ],
      "roles": ["[Approver]", "[Admin]"]
    }
    ```

    !!! note
    
        The `roles` array lists every role defined in the ACL, whether assigned or not.

### PUT /acl/entry/{aclEntryName}

=== "Description"

    Creates the named ACL entry if it does not exist, or replaces it with the supplied level, roles, type, and flags.

=== "Path"

    `/api/dxl/acl/entry/{aclEntryName}`

=== "ACL"

    Manager

=== "Request"

    Sample request:

    ```http
    PUT /api/dxl/acl/entry/CN%3DAlice%20Example%2FO%3DMyOrg?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    Content-Type: application/json

    {
      "level": "EDITOR",
      "type": "PERSON",
      "roles": ["[Approver]"],
      "flags": ["NODELETE_DOCUMENT"]
    }
    ```

    !!! note 

        - URL-encode the entry name (slashes, equals signs, spaces). 
        - `level` is required while all other fields are optional and default to empty.
        - Roles must already be defined in the ACL. If a role does not exist, the request fails with a `400 Bad Request` error.

=== "Response"

    Sample response:

    The response is the saved entry as JSON.

### DELETE /acl/entry/{aclEntryName}

=== "Description"

    Removes the named entry from the ACL.
    
    !!! note
    
        The entries `-Default-` and `LocalDomainServers` are protected and cannot be removed.

=== "Path"

    `/api/dxl/acl/entry/{aclEntryName}`

=== "ACL"

    Manager

=== "Request"

    Sample request:

    ```http
    DELETE /api/dxl/acl/entry/CN%3DAlice%20Example%2FO%3DMyOrg?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
      "deleted": true,
      "name": "CN=Alice Example/O=MyOrg"
    }
    ```

---

## Help documents

Every NSF contains two special notes intended for user-facing documentation:

|Document|NoteID|Purpose|
|:---|:---|:---|
|**About**|`0xFFFF0002`|Shown when the database opens if configured to display in the launch settings|
|**Using**|`0xFFFF0100`|Available from **Help**&nbsp;&rarr;&nbsp;**Using This Database** in the Notes client|

Use the following endpoints to read, replace, or delete either document programmatically.

!!! note

    The `docType` path parameter accepts the values `about` and `using`. The values are case-insensitive.

### GET /helpdoc/{docType}

=== "Description"

    Returns the database's **About** or **Using** help document as DXL.

=== "Path"

    `/api/dxl/helpdoc/{docType}`

=== "ACL"

    Reader

=== "Request"

    Sample request:

    ```http
    GET /api/dxl/helpdoc/about?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
      "type": "about",
      "unid": "86E3F50B2B8A4D...",
      "noteId": "0xFFFF0002",
      "dxl": "<document xmlns='http://www.lotus.com/dxl' ...>...</document>"
    }
    ```

    !!! note
    
        The `dxl` field contains the full DXL representation of the help document, including its rich-text body.

### PUT /helpdoc/{docType}

=== "Description"

    Creates or replaces the database's **About** or **Using** help document.

=== "Path"

    `/api/dxl/helpdoc/{docType}`

=== "ACL"

    Designer

=== "Request"

    Sample request:

    ```http
    PUT /api/dxl/helpdoc/about?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    Content-Type: text/xml

    <helpaboutdocument xmlns='http://www.lotus.com/dxl'>
      <body>
        <richtext>
          <pardef id='1'/>
          <par def='1'>Welcome to My Application.</par>
        </richtext>
      </body>
    </helpaboutdocument>
    ```

    !!! note

        The DXL element name must match the document type: 
        
        - `<helpaboutdocument>` for **About**
        - `<helpusingdocument>` for **Using**. 
        
        The easiest approach is to `GET` the existing document, modify the rich text content, and `PUT` it back.

=== "Response"

    Sample response:

    ```json
    {
      "type": "about",
      "status": "ok",
      "importedCount": 1,
      "log": "<DXLImportLog .../>"
    }
    ```

    !!! note
    
        The imported note is automatically signed with the calling user's identity when it is available via ID Vault, or with the server ID.

### DELETE /helpdoc/{docType}

=== "Description"

    Removes the database's **About** or **Using** help document permanently.

=== "Path"

    `/api/dxl/helpdoc/{docType}`

=== "ACL"

    Designer

=== "Request"

    Sample request:

    ```http
    DELETE /api/dxl/helpdoc/about?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
      "deleted": true,
      "type": "about",
      "unid": "86E3F50B2B8A4D...",
      "noteId": "0xFFFF0002"
    }
    ```

    !!! note

        Returns a **404 Not Found** response if the help document does not exist in the database.

---

## Database icon note

Every NSF includes a special icon note (`DocumentClass.ICON`, NoteID `0xFFFF0010`) that controls the database's workspace icon in the Notes client. This icon note is separate from the `$DBIcon` image resource, which stores the higher-resolution database icon used by Domino Designer and supported web clients.

To ensure the database icon displays consistently across supported clients, both the icon note and the `$DBIcon` image resource must be present.

### GET /dbicon

=== "Description"

    Returns the database icon note as DXL.

=== "Path"

    `/api/dxl/dbicon`

=== "ACL"

    Reader

=== "Request"

    Sample request:

    ```http
    GET /api/dxl/dbicon?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
      "type": "dbicon",
      "unid": "3228AB6D79FC1C61...",
      "noteId": "0xFFFF0010",
      "dxl": "<iconnote xmlns='http://www.lotus.com/dxl' ...>...</iconnote>"
    }
    ```

    !!! note

        The `dxl` field contains the full icon note DXL, which includes the icon bitmap and the database launch settings.

### PUT /dbicon

=== "Description"

    Creates or replaces the database icon note.

=== "Path"

    `/api/dxl/dbicon`

=== "ACL"

    Designer

=== "Request"

    Sample request:

    ```http
    PUT /api/dxl/dbicon?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    Content-Type: text/xml

    <iconnote xmlns='http://www.lotus.com/dxl'>
      <png>iVBORw0KGgoAAAANSUhEUg...</png>
    </iconnote>
    ```

    !!! tip

        The recommended approach is to `GET` the icon note from a working database and `PUT` it into the target database.
        
    !!! note "Launch settings preservation"

        The icon note also stores the database launch settings (`<launchsettings>`), such as whether the database opens to a frameset or page. When the icon is replaced, the server automatically snapshots the current launch settings before the import and restores them after the import. This ensures that replacing the icon does not accidentally reset the database's launch configuration.

=== "Response"

    Sample response:

    ```json
    {
      "type": "dbicon",
      "status": "ok",
      "importedCount": 1,
      "propsRestored": true,
      "log": "<DXLImportLog .../>"
    }
    ```

    !!! note

        - The `propsRestored` field indicates whether the database launch settings were preserved and restored during the icon replacement operation. If its value is true, the launch settings existed and were successfully restored. If its value is false, no launch settings were available to restore, or the settings could not be restored because the snapshot failed.
        - The imported note is automatically signed with the calling user's identity when it is available via ID Vault, or with the server ID.

### DELETE /dbicon

=== "Description"

    Removes the database icon note permanently.

=== "Path"

    `/api/dxl/dbicon`

=== "ACL"

    Designer

=== "Request"

    Sample request:

    ```http
    DELETE /api/dxl/dbicon?nsfPath=apps/myapp.nsf
    Authorization: Bearer <token>
    ```

=== "Response"

    Sample response:

    ```json
    {
      "deleted": true,
      "type": "dbicon",
      "unid": "3228AB6D79FC1C61...",
      "noteId": "0xFFFF0010"
    }
    ```

    !!! note

        Returns a **404 Not Found** response if the icon note does not exist in the database. After deletion, the database reverts to the default Domino icon on the Notes workspace.
