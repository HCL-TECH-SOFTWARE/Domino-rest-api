# DXL Extension API — Developer Guide

The DXL Extension API (`/api/dxl`) gives developers full programmatic control over a
Domino database's design — read, modify, delete, and import individual design elements —
as well as database-level operations like ACL management, property updates, and bulk DXL
export/import.

All endpoints are available through the standard HCL Domino REST API authentication model
(JWT bearer token). The interactive Swagger UI is available at
`http://<host>:8880/openapi/swagger-ui/?url=/api/dxl/schema/openapi.dxlext.json`.

---

## Common Concepts

### Base URL

```
/api/dxl
```

### Authentication

Every endpoint (except the schema file itself) requires a JWT bearer token.

```
Authorization: Bearer <token>
```

Obtain a token from `POST /api/v1/auth` using your Domino credentials.

### nsfPath parameter

Every endpoint accepts `nsfPath` as a required query parameter. It is the relative path
to the NSF file on the Domino server, for example:

```
?nsfPath=mail/user.nsf
?nsfPath=apps/myapp.nsf
```

### Required access levels

| Operation | Minimum ACL level |
|---|---|
| Read / List / Export / Validate | READER |
| Import / Create / Update / Delete design elements | DESIGNER |
| Create / Update / Delete help documents (About, Using) | DESIGNER |
| ACL operations / Database property writes | MANAGER |

---

## Design Element Types

The following type names are used in path parameters and query parameters throughout
the API.

| Type name | Domino element |
|---|---|
| `form` | Form |
| `subform` | Subform |
| `view` | View |
| `folder` | Folder |
| `frameset` | Frameset |
| `page` | Page |
| `agent` | Agent |
| `scriptlibrary` | Script Library |
| `sharedfield` | Shared Field |
| `sharedcolumn` | Shared Column |
| `navigator` | Navigator |
| `outline` | Outline |
| `imageresource` | Image Resource |
| `fileresource` | File Resource |

---

## Endpoints

### Database Properties

#### GET /database — Read properties

Returns the database title, replica ID, file path, design template name, and launch
settings (Notes client and web browser).

```http
GET /api/dxl/database?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

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

The `launchSettings` object is extracted by exporting the database icon note as DXL.
If the database has no explicit launch settings, `launchSettings` will be an empty
object. If the DXL parse fails, a `parseError` field is included but basic fields
(title, replicaId, etc.) are always returned.

#### PUT /database — Update properties

Updates database title and/or launch settings. Only the fields you supply are modified;
omitted fields are left unchanged.

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
|---|---|
| `openaboutdocument` | Show About document |
| `openframeset` | Open a specific frameset |
| `restorelastview` | Restore the last-used view |
| `openfirstdocument` | Open the first document |
| `openpage` | Open a named page |
| `openxpage` | Open an XPage |
| `opencompapp` | Open a composite application |

**Web `whenOpened` values:** `page`, `view`, `url`, `doclink`

**Response**

```json
{
  "status": "ok",
  "log": "<DXLImportLog/>"
}
```

Requires MANAGER access.

---

### Design Summary

#### GET /designsummary — Full design inventory

Returns every design element in the database grouped by type. Each element includes
its name, aliases, UNID, and note ID. No DXL is returned, keeping the response
lightweight. Types with zero elements are omitted.

```http
GET /api/dxl/designsummary?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

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

Elements without aliases omit the `aliases` field entirely. The `database` and
`replicaId` fields make the response self-describing — useful when working with
multiple databases.

---

### Design Elements — List

#### GET /{type} — List elements by type

Lists every design element of the requested type with name, UNID, and note ID.

```http
GET /api/dxl/form?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

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

---

### Design Elements — CRUD

#### GET /{type}/{name} — Read a single element

Exports a single design element as DXL wrapped in a JSON response.

```http
GET /api/dxl/form/MainForm?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

```json
{
  "type": "form",
  "name": "MainForm",
  "unid": "AABBCCDD00112233AABBCCDD00112233",
  "noteId": 256,
  "dxl": "<form name='MainForm' ...>...</form>"
}
```

The `dxl` field contains the raw element DXL without an XML declaration or DOCTYPE.

#### PUT /{type}/{name} — Create or replace an element

Imports a single design element from raw DXL. The element is created if it does not
exist, or replaced if it does. The DXL body must be the element fragment — not a full
`<database>` document. The imported element is automatically signed after import. When the calling
user authenticated via a method compatible with ID Vault (e.g. SAML or OAuth),
the note is signed with their own identity — preserving an audit trail of who
deployed the element. When the user's ID cannot be retrieved (e.g. basic auth),
the note is signed with the server ID instead. Either way, agents and script
libraries are immediately runnable.

```http
PUT /api/dxl/form/MainForm?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
Content-Type: text/xml

<form name='MainForm' xmlns='http://www.lotus.com/dxl'>
  ...
</form>
```

> **Important:** Do not include an `<?xml ...?>` declaration or DOCTYPE at the top of
> the body. The importer wraps your fragment in a `<database>` element before parsing,
> which makes an XML declaration illegal and causes a fatal parse error. See
> [Notes on DXL Format](#notes-on-dxl-format).

**Response**

```json
{
  "status": "ok",
  "importedCount": 1,
  "log": "<DXLImportLog>...</DXLImportLog>"
}
```

Requires DESIGNER access.

#### DELETE /{type}/{name} — Delete an element

Permanently removes the named element.

```http
DELETE /api/dxl/form/MainForm?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

```json
{
  "deleted": true,
  "type": "form",
  "name": "MainForm",
  "unid": "AABBCCDD00112233AABBCCDD00112233"
}
```

Returns 404 if the element does not exist. Requires DESIGNER access.

---

### Framesets

Framesets have two additional endpoints that work with a structured JSON representation
of the frameset layout instead of raw DXL, making them easier to create and parse
programmatically.

#### GET /frameset/{name}/layout — Get frameset as JSON

```http
GET /api/dxl/frameset/MainFrameset/layout?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

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

`orientation` is `rows` (frames stacked vertically) or `columns` (frames side by side).
`sizes` has one entry per frame; a plain number like `"1"` means "take remaining space."
Returns 404 if the frameset does not exist.

#### PUT /frameset/{name}/layout — Create or replace a frameset

Converts the JSON layout to DXL and imports it.

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

**Frame target kinds:** `page`, `view`, `form`, `frameset`, `url`

For nested framesets, include a content item of `"type": "frameset"` with its own
`orientation`, `sizes`, and `content` array.

**Response**

```json
{
  "status": "ok",
  "importedCount": 1,
  "log": "<DXLImportLog/>"
}
```

Requires DESIGNER access.

---

### Outlines

Outlines have two additional endpoints that work with a structured JSON representation
of the entry hierarchy instead of raw DXL. This makes it straightforward to add,
reorder, or rename outline entries without touching DXL at all — particularly useful
in hybrid-mode workflows where an outline is copied from a reference database and
its view targets need to be updated.

#### GET /outline/{name}/entries — Get outline as JSON

```http
GET /api/dxl/outline/MainOutline/entries?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

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

Returns 404 if the outline does not exist.

#### PUT /outline/{name}/entries — Create or replace an outline

Converts the JSON entry tree to DXL and imports it. Creates the outline if it does
not exist, or replaces it entirely if it does.

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

**Response**

```json
{
  "status": "ok",
  "importedCount": 1,
  "log": "<DXLImportLog/>"
}
```

Requires DESIGNER access.

---

### DXL Export

#### GET /export — Export design as DXL

Exports design elements from the database as a DXL `<database>` document.

**Full export** — includes database properties, ACL, and all design elements:

```http
GET /api/dxl/export?nsfPath=apps/myapp.nsf&full=true
Authorization: Bearer <token>
```

```json
{
  "mode": "full",
  "dxl": "<database xmlns='http://www.lotus.com/dxl'>...</database>"
}
```

**Filtered export by type** — exports only the listed element types:

```http
GET /api/dxl/export?nsfPath=apps/myapp.nsf&types=form,view
Authorization: Bearer <token>
```

```json
{
  "mode": "filtered",
  "types": ["form", "view"],
  "elementCount": 12,
  "dxl": "<database xmlns='http://www.lotus.com/dxl'>...</database>"
}
```

**Filtered export with database properties** — add `include=properties`:

```http
GET /api/dxl/export?nsfPath=apps/myapp.nsf&types=form&include=properties
```

```json
{
  "mode": "filtered",
  "types": ["form"],
  "elementCount": 4,
  "dxl": "<database ...>...</database>",
  "propertiesDxl": "<database ...>...</database>"
}
```

The `propertiesDxl` field is a separate DXL document containing only database-level
properties (useful for replicating launch settings without copying design elements).

---

### DXL Validate

#### POST /validate — Validate DXL without importing

Performs a two-pass validation: XML well-formedness check, then a dry-run importer pass
with no changes written. Use this before kicking off an async import.

```http
POST /api/dxl/validate?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
Content-Type: application/json

{
  "dxl": "<database xmlns='http://www.lotus.com/dxl'><form name='Test'>...</form></database>"
}
```

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

The DXL must be wrapped in a `<database>` element. A leading UTF-8 BOM is accepted and
stripped automatically.

---

### DXL Import (Async)

Large DXL imports run asynchronously. Submit the job with `POST /import`, then poll
`GET /import/{jobId}` until it completes.

#### POST /import — Start an import

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

**Option values:** `replaceElseCreate`, `replaceElseIgnore`, `ignoreElseCreate`, `create`, `ignore`

**Response** — returned immediately:

```json
{
  "jobId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
  "status": "running",
  "nsfPath": "apps/myapp.nsf"
}
```

The DXL is preprocessed before import: a leading UTF-8 BOM and any whitespace before
the first `<` are stripped automatically (handles files exported from PowerShell, etc.).

Requires DESIGNER access.

#### GET /import/{jobId} — Poll job status

```http
GET /api/dxl/import/f47ac10b-58cc-4372-a567-0e02b2c3d479?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

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

Returns 404 if the job ID is unknown or has expired.

---

### ACL Management

All ACL endpoints require MANAGER access.

#### GET /acl — Read the ACL

```http
GET /api/dxl/acl?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

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

The `roles` array lists every role defined in the ACL, whether assigned or not.

#### PUT /acl/entry/{aclEntryName} — Create or update an entry

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

URL-encode the entry name (slashes, equals signs, spaces). `level` is required; all
other fields are optional and default to empty.

Roles must already be defined in the ACL. If a role does not exist, the request fails
with a 400.

**Response** — the saved entry as JSON.

#### DELETE /acl/entry/{aclEntryName} — Remove an entry

```http
DELETE /api/dxl/acl/entry/CN%3DAlice%20Example%2FO%3DMyOrg?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

```json
{
  "deleted": true,
  "name": "CN=Alice Example/O=MyOrg"
}
```

The entries `-Default-` and `LocalDomainServers` are protected and cannot be deleted.

---

### Help Documents (About / Using)

Every NSF contains two special notes for user-facing documentation:

| Document | NoteID | Purpose |
|---|---|---|
| **About** | `0xFFFF0002` | Displayed when the database opens (if configured in launch settings) |
| **Using** | `0xFFFF0100` | Accessible via Help > Using This Database in the Notes client |

These endpoints let you read, replace, and delete both documents programmatically.
The `docType` path parameter must be `about` or `using` (case-insensitive).

#### GET /helpdoc/{docType} — Read a help document

```http
GET /api/dxl/helpdoc/about?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

```json
{
  "type": "about",
  "unid": "86E3F50B2B8A4D...",
  "noteId": "0xFFFF0002",
  "dxl": "<document xmlns='http://www.lotus.com/dxl' ...>...</document>"
}
```

The `dxl` field contains the full DXL representation of the help document, including
its rich-text body.

#### PUT /helpdoc/{docType} — Create or replace a help document

Requires DESIGNER access.

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

The DXL element name must match the document type: `<helpaboutdocument>` for About,
`<helpusingdocument>` for Using. The easiest approach is to GET the existing document,
modify the rich text content, and PUT it back.

**Response**

```json
{
  "type": "about",
  "status": "ok",
  "importedCount": 1,
  "log": "<DXLImportLog .../>"
}
```

The imported note is automatically signed with the calling user's identity (when
available via ID Vault) or the server ID.

#### DELETE /helpdoc/{docType} — Delete a help document

Requires DESIGNER access.

```http
DELETE /api/dxl/helpdoc/about?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

```json
{
  "deleted": true,
  "type": "about",
  "unid": "86E3F50B2B8A4D...",
  "noteId": "0xFFFF0002"
}
```

Returns 404 if the help document does not exist in the database.

---

### Database Icon Note

Every NSF has a special icon note (`DocumentClass.ICON`, NoteID `0xFFFF0010`) that
controls the database's workspace icon in the Notes client. This is **distinct** from
the `$DBIcon` image resource, which stores the higher-resolution icon for Domino
Designer and web clients. Both must be present for the icon to appear correctly
everywhere.

#### GET /dbicon — Read the icon note

```http
GET /api/dxl/dbicon?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

```json
{
  "type": "dbicon",
  "unid": "3228AB6D79FC1C61...",
  "noteId": "0xFFFF0010",
  "dxl": "<iconnote xmlns='http://www.lotus.com/dxl' ...>...</iconnote>"
}
```

The `dxl` field contains the full icon note DXL, which includes the icon bitmap
and database launch settings.

#### PUT /dbicon — Create or replace the icon note

Requires DESIGNER access.

```http
PUT /api/dxl/dbicon?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
Content-Type: text/xml

<iconnote xmlns='http://www.lotus.com/dxl'>
  <png>iVBORw0KGgoAAAANSUhEUg...</png>
</iconnote>
```

The easiest approach is to GET the icon note from a working database and PUT it
into the target database.

**Launch settings preservation:** The icon note also stores database launch settings
(`<launchsettings>` — open to frameset, page, etc.). When replacing the icon, the
server automatically snapshots the current launch settings before import and restores
them afterwards, so changing the icon does not accidentally reset the database's
launch configuration.

**Response**

```json
{
  "type": "dbicon",
  "status": "ok",
  "importedCount": 1,
  "propsRestored": true,
  "log": "<DXLImportLog .../>"
}
```

The `propsRestored` field indicates whether launch settings were preserved across
the replacement (`true` = settings existed and were restored, `false` = no settings
to restore or snapshot failed).

The imported note is automatically signed with the calling user's identity (when
available via ID Vault) or the server ID.

#### DELETE /dbicon — Delete the icon note

Requires DESIGNER access.

```http
DELETE /api/dxl/dbicon?nsfPath=apps/myapp.nsf
Authorization: Bearer <token>
```

**Response**

```json
{
  "deleted": true,
  "type": "dbicon",
  "unid": "3228AB6D79FC1C61...",
  "noteId": "0xFFFF0010"
}
```

Returns 404 if the icon note does not exist in the database. After deletion the
database reverts to the default Domino icon on the Notes workspace.

---

## Typical Workflows

### Migrate a design element between databases

```bash
# 1. Export the element from the source database
curl -H "Authorization: Bearer $TOKEN" \
  "http://server:8880/api/dxl/form/OrderForm?nsfPath=source.nsf" \
  | jq -r .dxl > OrderForm.dxl

# 2. Import the element into the target database
curl -X PUT -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: text/xml" \
  --data-binary @OrderForm.dxl \
  "http://server:8880/api/dxl/form/OrderForm?nsfPath=target.nsf"
```

### Validate before importing

```bash
# Validate first
curl -X POST -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"dxl\": $(jq -Rs . < export.dxl)}" \
  "http://server:8880/api/dxl/validate?nsfPath=target.nsf"

# If valid, kick off async import
curl -X POST -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"dxl\": $(jq -Rs . < export.dxl)}" \
  "http://server:8880/api/dxl/import?nsfPath=target.nsf"
```

### Update outline view targets after a hybrid-mode copy

When an outline is copied from a reference database, the view names may differ in
the target. Use the entries API to read and rewrite them without touching DXL:

```bash
# 1. Read the current entries
curl -H "Authorization: Bearer $TOKEN" \
  "http://server:8880/api/dxl/outline/MainOutline/entries?nsfPath=apps/myapp.nsf" \
  > entries.json

# 2. Edit entries.json (update target names, reorder, add children, etc.)

# 3. Write the modified entries back
curl -X PUT -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  --data-binary @entries.json \
  "http://server:8880/api/dxl/outline/MainOutline/entries?nsfPath=apps/myapp.nsf"
```

### Migrate the About document between databases

```bash
# 1. Export the About document from the source database
curl -H "Authorization: Bearer $TOKEN" \
  "http://server:8880/api/dxl/helpdoc/about?nsfPath=source.nsf" \
  | jq -r .dxl > about.dxl

# 2. Import the About document into the target database
curl -X PUT -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: text/xml" \
  --data-binary @about.dxl \
  "http://server:8880/api/dxl/helpdoc/about?nsfPath=target.nsf"
```

### Copy the database icon note between databases

If a database's workspace icon is missing (shows in Designer but not on the
workspace), the icon note is likely absent. Copy it from a database where the
icon works:

```bash
# 1. Export the icon note from the source database
curl -H "Authorization: Bearer $TOKEN" \
  "http://server:8880/api/dxl/dbicon?nsfPath=nifty50/n50-base.nsf" \
  | jq -r .dxl > dbicon.dxl

# 2. Import the icon note into the target database
curl -X PUT -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: text/xml" \
  --data-binary @dbicon.dxl \
  "http://server:8880/api/dxl/dbicon?nsfPath=nifty50/n50-risk.nsf"
```

### Set a database to open a frameset on launch

```bash
curl -X PUT -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"notes": {"whenOpened": "openframeset", "framesetName": "MainFrameset"}}' \
  "http://server:8880/api/dxl/database?nsfPath=apps/myapp.nsf"
```

---

## Error Reference

| HTTP status | Meaning |
|---|---|
| 400 | Bad request — missing required parameter, invalid value, or malformed DXL |
| 401 | Missing or invalid JWT token |
| 403 | Insufficient ACL access for this operation |
| 404 | Resource not found (design element, frameset, import job) |
| 500 | Internal server error — check the Domino KEEP log |

All error responses include a JSON body with a `message` field describing the problem.

---

## Agent DXL Reference

This section documents all valid values for agent DXL elements and attributes, sourced
directly from the Domino 14.5 DXL schema (`domino_14_5.dtd`).

### `<agent>` attributes

| Attribute | Type | Default | Description |
|---|---|---|---|
| `name` | string | — | Agent name (required) |
| `alias` | string | — | Alternate name |
| `comment` | string | — | Description shown in Designer |
| `enabled` | boolean | `true` | Whether the agent is enabled |
| `restrictions` | see below | `restricted` | Security restriction level |
| `runaswebuser` | boolean | `false` | Run with the effective web user's identity |
| `runonbehalfof` | string | — | Run on behalf of this user name |
| `activatable` | boolean | — | For scheduled agents: can be toggled enabled/disabled |
| `showinsearch` | boolean | `false` | Show agent's search in the search bar |
| `clientbackgroundthread` | boolean | `false` | Run in a background thread on the client |
| `allowremotedebugging` | boolean | `false` | Allow remote debugger to attach |
| `storehighlights` | boolean | `false` | Store search highlights |
| `formulatype` | see below | `modifydocs` | For formula agents: how the formula operates |
| `profile` | boolean | `false` | Profile agent execution each run |

**`restrictions` values**

| Value | Description |
|---|---|
| `restricted` | Restricted operations only |
| `unrestricted` | Unrestricted operations allowed |
| `fulladminunrestricted` | Full admin unrestricted (requires server trust) |

**`formulatype` values** (formula agents only)

| Value | Description |
|---|---|
| `modifydocs` | Formula modifies documents |
| `createdocs` | Formula creates new documents |
| `selectdocs` | Formula selects documents |

---

### `<trigger>` element

Required. Specifies what triggers the agent.

```xml
<trigger type='actionsmenu'/>
```

For scheduled agents, contains a `<schedule>` child element.

**`type` values**

| Value | Description |
|---|---|
| `actionsmenu` | Manually from Actions menu |
| `agentlist` | Manually from agent list |
| `beforenewmail` | Before new mail arrives |
| `afternewmail` | After new mail has arrived |
| `docupdate` | When documents are created or modified |
| `docpaste` | When documents are pasted |
| `scheduled` | On a specified schedule (requires `<schedule>` child) |
| `serverstart` | When the Domino server starts up |

---

### `<schedule>` element

Required when `trigger type='scheduled'`. Child of `<trigger>`.

```xml
<trigger type='scheduled'>
  <schedule type='daily' runlocation='any' onweekends='false'>
    <starttime><datetime>T090000,00</datetime></starttime>
    <endtime><datetime>T170000,00</datetime></endtime>
  </schedule>
</trigger>
```

**`<schedule>` attributes**

| Attribute | Type | Default | Description |
|---|---|---|---|
| `type` | see below | — | Schedule frequency (required) |
| `runlocation` | see below | — | Where the agent runs |
| `runserver` | string | — | Server name when `runlocation='specific'` |
| `hours` | integer | — | Hours between runs (use with `type='byminutes'`) |
| `minutes` | integer | — | Minutes between runs (use with `type='byminutes'`) |
| `onweekends` | boolean | `true` | Allow runs on weekends |
| `dayofweek` | see below | — | Required when `type='weekly'` |
| `dateinmonth` | integer | — | Day of month (1–31); required when `type='monthly'` |

**`type` values**

| Value | Description |
|---|---|
| `automatic` | Schedule implied by trigger (e.g. `docupdate`) |
| `byminutes` | More than once a day; use `hours` and/or `minutes` attributes |
| `daily` | Once per day |
| `weekly` | Once per week; requires `dayofweek` attribute |
| `monthly` | Once per month; requires `dateinmonth` attribute |
| `never` | Disabled schedule |

**`runlocation` values**

| Value | Description |
|---|---|
| `any` | Any server |
| `choose` | User chooses when enabling the agent |
| `specific` | Specific server named in `runserver` attribute |
| `local` | *(Deprecated since ND 8.52)* Local workstation |
| `server` | *(Deprecated since ND 8.52)* A server |

**`dayofweek` values:** `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday`, `saturday`

**Optional child elements of `<schedule>`:** `<starttime>`, `<endtime>`, `<startdate>`, `<enddate>` — each contains a `<datetime>` element.

---

### `<documentset>` element

Optional. Specifies which documents the agent operates on. Omit for triggers where
the document set is implied (`beforenewmail`, `afternewmail`, `serverstart`).

```xml
<documentset type='all'/>
```

**`type` values**

| Value | Description |
|---|---|
| `modified` | All new and modified documents |
| `unreadinview` | All unread documents in a view |
| `allinview` | All documents in a view |
| `selected` | Selected documents |
| `runonce` | Run once (current document) |
| `all` | All documents in database |
| `implicit` | Document set implied by trigger (required for `docpaste`; not valid for manual triggers) |

---

### `<code>` elements

One or more `<code>` elements hold the agent's source code. Each has an `event`
attribute specifying which section it represents.

**LotusScript events**

| Event | Description |
|---|---|
| `options` | `Option Public` / `Option Declare` section |
| `declarations` | Module-level variable declarations |
| `initialize` | `Sub Initialize` — main entry point |
| `terminate` | `Sub Terminate` — cleanup on exit |

**Java event:** `action`

LotusScript content goes in a `<lotusscript>` child element; Java content goes in a
`<javaproject>` child element.

```xml
<code event='options'><lotusscript>Option Public
Option Declare
</lotusscript></code>
<code event='initialize'><lotusscript>Sub Initialize
    MsgBox "Hello World"
End Sub</lotusscript></code>
```

---

### Minimal create payloads

**LotusScript agent, manually run:**
```xml
<agent xmlns='http://www.lotus.com/dxl' name='MyAgent'>
  <trigger type='actionsmenu'/>
  <documentset type='runonce'/>
  <code event='initialize'><lotusscript>Sub Initialize
    MsgBox "Hello World"
End Sub</lotusscript></code>
</agent>
```

**Java agent, manually run:**
```xml
<agent xmlns='http://www.lotus.com/dxl' name='MyJavaAgent'>
  <trigger type='actionsmenu'/>
  <documentset type='runonce'/>
  <code event='action'><javaproject class='JavaAgent.class'>
    <java name='JavaAgent.java'>import lotus.domino.*;

public class JavaAgent extends AgentBase {
    public void NotesMain() {
        try {
            System.out.println("Hello World");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}</java>
  </javaproject></code>
</agent>
```

Notes on Java agents:
- `code event` must be `action` (not `initialize` as with LotusScript)
- `javaproject class` points to the compiled entry point — always `JavaAgent.class` for standard agents
- The `codepath` attribute that appears in exported DXL is Designer metadata and should be omitted on import
- `$JavaCompilerSource` / `$JavaCompilerTarget` items in exported DXL are also Designer-generated — omit them; Domino sets these on compile
- Source is embedded as a `<java name='JavaAgent.java'>` child element — the class name and filename must match

> **Known limitation — Java compilation on import:** When a Java agent is created via
> `PUT /{type}/{name}`, Domino attempts to compile the Java source immediately. This
> compilation can fail silently on some server configurations due to a wildcard classpath
> issue (`libs/*` passed literally to javac rather than being shell-expanded). When this
> occurs, the agent note is created and signed correctly, but contains only source — no
> compiled bytecode — and will not run. The import response will include a warning like:
> ```
> Java compile errors: error: illegal argument for --class-path: Illegal char <*>
> ```
> The workaround is to open the agent in Domino Designer after import, which triggers
> recompilation in the Designer environment where the classpath is handled correctly.
> LotusScript agents are not affected by this issue.

> **Known limitation — ampersand in action button titles:** The Domino C API DxlImporter
> silently drops `<action>` elements whose `title` attribute contains `&amp;` (the XML
> entity for `&`). For example, a button titled `Save & Close` is encoded in valid XML as
> `<action title='Save &amp; Close'>`, but DxlImporter discards the entire element during
> import — no error is raised and no log entry is written.
>
> This is a bug in the Notes C API, not in the DXL specification or this extension. DXL-EXT
> mitigates it automatically: before any DXL is passed to the importer, action button titles
> containing `&amp;` are rewritten to use `and` instead (e.g. `Save & Close` →
> `Save and Close`). When this occurs, the import response includes a `"sanitized"` array
> describing each change:
> ```json
> "sanitized": [
>   { "type": "actionTitleSanitized", "original": "Save & Close", "replaced": "Save and Close" }
> ]
> ```
> This applies to `PUT /{type}/{name}` (synchronous — in the response body) and
> `POST /import` (asynchronous — in the job status when polled). If your action titles
> must avoid the word `and`, rename them before submitting the DXL.

**Formula agent, manually run:**
```xml
<agent xmlns='http://www.lotus.com/dxl' name='MyFormulaAgent'>
  <trigger type='actionsmenu'/>
  <documentset type='runonce'/>
  <code event='action'>
    <simpleaction action='runformula'><formula>@Prompt([Ok]; "Hello World Prompt"; "Hello World!")</formula></simpleaction>
  </code>
</agent>
```

Notes on formula agents:
- `code event` is `action`, same as Java
- The formula goes inside `<simpleaction action='runformula'><formula>...</formula></simpleaction>` — no `<lotusscript>` or `<javaproject>` wrapper
- No compilation step — formula agents work immediately after import with no server-side issues
- The `SELECT @All` clause seen in Designer-exported DXL is the document selection formula; it can be omitted when using `<documentset type='runonce'/>`

**Scheduled agent, daily on any server:**
```xml
<agent xmlns='http://www.lotus.com/dxl' name='MyScheduledAgent' enabled='true'>
  <trigger type='scheduled'>
    <schedule type='daily' runlocation='any' onweekends='false'>
      <starttime><datetime>T020000,00</datetime></starttime>
      <endtime><datetime>T030000,00</datetime></endtime>
    </schedule>
  </trigger>
  <documentset type='all'/>
  <code event='initialize'><lotusscript>Sub Initialize
    ' Agent logic here
End Sub</lotusscript></code>
</agent>
```

---

## Notes on DXL Format

- **Do not include an XML declaration.** The Domino DXL importer's XML parser is strict
  about where `<?xml version='1.0' ...?>` may appear. When our code wraps your element
  fragment inside a `<database>` element before importing, an XML declaration in your
  payload ends up *inside* the root element — which is illegal XML and causes an immediate
  fatal parse error:
  ```
  Fatal Error: No processing instruction starts with 'xml'
  ```
  This applies to **all endpoints that accept DXL** — `PUT /{type}/{name}`,
  `POST /import`, and `POST /validate`. Simply omit the declaration entirely; it is
  never required here.
- **Do not include a DOCTYPE declaration.** Same reason — the importer rejects it.
- Exported DXL from `GET /{type}/{name}` and `GET /export` does not include either
  declaration, so round-tripping exported DXL is safe.
- The Lotus DXL namespace declaration is required on the root element:
  `xmlns='http://www.lotus.com/dxl'`
- For `PUT /{type}/{name}`, supply only the element fragment (e.g. `<form ...>`) —
  not a full `<database>` wrapper.
- For `POST /import` and `POST /validate`, the DXL **must** be wrapped in
  `<database>...</database>`.
- A leading UTF-8 BOM is accepted and stripped by the importer and validator. This
  handles files generated by tools like Windows PowerShell `Out-File`.
