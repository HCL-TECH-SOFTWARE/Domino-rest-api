# DXL Extension API guide

!!! warning "Important"

    **The DXL Extension API is experimental and is provided for users to try and evaluate. It is not yet supported for production use.**

    The DXL Extension API is disabled by default. To enable it, see [Enable CalDav, CardDav, and DXL extension APIs](../../howto/production/davdxl.md).

    For any feedback, questions, or issues, you may post them in the [OpenNTF Discord channel](https://discord.com/invite/jmRHpDRnH4 "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../assets/images/external-link.svg){: style="height:15px;width:15px"}.

The DXL Extension API (`/api/dxl`) provides developers with programmatic access to Domino database design elements. It supports operations to read, modify, delete, and import individual design elements, as well as database-level operations such as ACL management, property updates, and bulk DXL export and import.

## Common concepts

### Base URL

`/api/dxl`

### Authentication

All endpoints require a JWT bearer token, except the schema file itself.

```http
Authorization: Bearer <token>
```

Obtain a token via the `POST /api/v1/auth` endpoint using your Domino credentials.

### nsfPath parameter

Every endpoint accepts `nsfPath` as a required query parameter. It is the relative path
to the NSF file on the Domino server.

For example:

```text
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

## Design element types

The following type names are used in path parameters and query parameters throughout
the API.

|Type name|Domino element|
|:---|:---|
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

## Typical workflows

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
the target database. Use the entries API to read and rewrite them without touching DXL.

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

If a database workspace icon is missing (for example, the icon appears in Domino Designer but not in the Notes workspace), the database's icon note may be missing or invalid. Copy the icon note from a database with a working workspace icon to restore it.

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

## Error reference

| HTTP status | Meaning |
|---|---|
| 400 | Bad request — missing required parameter, invalid value, or malformed DXL |
| 401 | Missing or invalid JWT token |
| 403 | Insufficient ACL access for this operation |
| 404 | Resource not found (design element, frameset, import job) |
| 500 | Internal server error — check the Domino KEEP log |

All error responses include a JSON body with a `message` field describing the problem.

## Agent DXL reference

This section documents all valid values for agent DXL elements and attributes, sourced
directly from the Domino 14.5 DXL schema (`domino_14_5.dtd`).

### `<agent>` attributes

| Attribute | Type | Default | Description |
|---|---|---|---|
| `name` | string | — | Agent name (required) |
| `alias` | string | — | Alternate name |
| `comment` | string | — | Description shown in Designer |
| `enabled` | boolean | `true` | Whether the agent is enabled |
| `restrictions` | see [details](#restrictions-values) | `restricted` | Security restriction level |
| `runaswebuser` | boolean | `false` | Run with the effective web user's identity |
| `runonbehalfof` | string | — | Run on behalf of this username |
| `activatable` | boolean | — | For scheduled agents: can be toggled enabled/disabled |
| `showinsearch` | boolean | `false` | Show agent's search in the search bar |
| `clientbackgroundthread` | boolean | `false` | Run in a background thread on the client |
| `allowremotedebugging` | boolean | `false` | Allow remote debugger to attach |
| `storehighlights` | boolean | `false` | Store search highlights |
| `formulatype` | see [details](#formulatype-values) | `modifydocs` | For formula agents: how the formula operates |
| `profile` | boolean | `false` | Profile agent execution each run |

#### `restrictions` values

| Value | Description |
|:---|:---|
| `restricted` | Restricted operations only |
| `unrestricted` | Unrestricted operations allowed |
| `fulladminunrestricted` | Full admin unrestricted (requires server trust) |

#### `formulatype` values

For formula agents only.

| Value | Description |
|:---|:---|
| `modifydocs` | Formula modifies documents |
| `createdocs` | Formula creates new documents |
| `selectdocs` | Formula selects documents |

### `<trigger>` element

This is a **required** element that specifies the event or mechanism that triggers the agent.

```xml
<trigger type='actionsmenu'/>
```

For scheduled agents, the `<trigger>` element contains a `<schedule>` child element.

**`type` values**

| Value | Description |
|:---|:---|
| `actionsmenu` | Manually from Actions menu |
| `agentlist` | Manually from agent list |
| `beforenewmail` | Before new mail arrives |
| `afternewmail` | After new mail has arrived |
| `docupdate` | When documents are created or modified |
| `docpaste` | When documents are pasted |
| `scheduled` | On a specified schedule (requires `<schedule>` child) |
| `serverstart` | When the Domino server starts up |

### `<schedule>` element

This is a required element when `trigger type='scheduled'`. This element is a child of `<trigger>`.

```xml
<trigger type='scheduled'>
  <schedule type='daily' runlocation='any' onweekends='false'>
    <starttime><datetime>T090000,00</datetime></starttime>
    <endtime><datetime>T170000,00</datetime></endtime>
  </schedule>
</trigger>
```

**Optional child elements of `<schedule>`:**

- `<starttime>`
- `<endtime>`
- `<startdate>`
- `<enddate>`

Each optional child element contains a `<datetime>` element.

#### `<schedule>` attributes

| Attribute | Type | Default | Description |
|:---|:---|:---|:---|
| `type` | see [details](#type-values) | — | Schedule frequency (required) |
| `runlocation` | see [details](#runlocation-values) | — | Where the agent runs |
| `runserver` | string | — | Server name when `runlocation='specific'` |
| `hours` | integer | — | Hours between runs (use with `type='byminutes'`) |
| `minutes` | integer | — | Minutes between runs (use with `type='byminutes'`) |
| `onweekends` | boolean | `true` | Allow runs on weekends |
| `dayofweek` | see [details](#runlocation-values) | — | Required when `type='weekly'` |
| `dateinmonth` | integer | — | Day of month (1–31); Required when `type='monthly'` |

#### `type` values

| Value | Description |
|:---|:---|
| `automatic` | Schedule implied by trigger, such as `docupdate` |
| `byminutes` | More than once a day; use `hours` and/or `minutes` attributes |
| `daily` | Once per day |
| `weekly` | Once per week; requires `dayofweek` attribute |
| `monthly` | Once per month; requires `dateinmonth` attribute |
| `never` | Disabled schedule |

#### `runlocation` values

| Value | Description |
|:---|:---|
| `any` | Any server |
| `choose` | User chooses when enabling the agent |
| `specific` | Specific server named in `runserver` attribute |
| `local` | *(Deprecated since ND 8.52)* Local workstation |
| `server` | *(Deprecated since ND 8.52)* A server |

#### `dayofweek` values

- `sunday`
- `monday`
- `tuesday`
- `wednesday`
- `thursday`
- `friday`
- `saturday`

### `<documentset>` element

This is an **optional** element that specifies which documents that agent operates on. Omit this element for agents whose document set is implied by the `<trigger>` element's `type` attribute `beforenewmail`, `afternewmail`, and `serverstart`.

```xml
<documentset type='all'/>
```

**`type` values**

| Value | Description |
|:---|:---|
| `modified` | All new and modified documents |
| `unreadinview` | All unread documents in a view |
| `allinview` | All documents in a view |
| `selected` | Selected documents |
| `runonce` | Run once (current document) |
| `all` | All documents in database |
| `implicit` | Document set implied by trigger (required for `docpaste`; not valid for manual triggers) |

### `<code>` elements

One or more `<code>` elements hold the agent's source code. Each `<code>` element has `event`
attribute that specify which section it represents.

=== "LotusScript events"

    | Event | Description |
    |:---|:---|
    | `options` | `Option Public` / `Option Declare` section |
    | `declarations` | Module-level variable declarations |
    | `initialize` | `Sub Initialize` — main entry point |
    | `terminate` | `Sub Terminate` — cleanup on exit |

=== "Java event"

    `action`

The LotusScript content goes in a `<lotusscript>` child element, while the Java content goes in a
`<javaproject>` child element.

```xml
<code event='options'><lotusscript>Option Public
Option Declare
</lotusscript></code>
<code event='initialize'><lotusscript>Sub Initialize
    MsgBox "Hello World"
End Sub</lotusscript></code>
```

### Minimal create payloads

The following examples show the minimal payloads required to create agents. They include only the required elements and omit optional metadata.

=== "LotusScript agent"

    Manually run:

    ```xml
    <agent xmlns='http://www.lotus.com/dxl' name='MyAgent'>
      <trigger type='actionsmenu'/>
      <documentset type='runonce'/>
      <code event='initialize'><lotusscript>Sub Initialize
        MsgBox "Hello World"
    End Sub</lotusscript></code>
    </agent>
    ```
=== "Java agent"

    Manually run:

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
=== "Formula agent"

    Manually run:

    ```xml
    <agent xmlns='http://www.lotus.com/dxl' name='MyFormulaAgent'>
      <trigger type='actionsmenu'/>
      <documentset type='runonce'/>
      <code event='action'>
        <simpleaction action='runformula'><formula>@Prompt([Ok]; "Hello World Prompt"; "Hello World!")</formula></simpleaction>
      </code>
    </agent>
    ```
=== "Scheduled agent"

    Runs daily on any server:

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

## Additional information

### Java agents

- The `code event` must be `action`. Do not use `initialize`, which is used for LotusScript agents.
- The `javaproject class` points to the compiled entry point, which is always `JavaAgent.class` for standard agents.
- The `codepath` attribute that appears in an exported DXL is a Domino Designer metadata and should be omitted on import.
- The `$JavaCompilerSource` and `$JavaCompilerTarget` items in an exported DXL are Domino Designer generated, and should be omitted. Domino sets them on compile.
- Source is embedded as a `<java name='JavaAgent.java'>` child element. Make sure the class name and filename match.

### Formula agents

- The `code event` must be `action`, the same as in Java agents.
- The formula goes inside `<simpleaction action='runformula'><formula>...</formula></simpleaction>`. There should be no `<lotusscript>` or `<javaproject>` wrapper.
- There is no compilation step. The formula agents work immediately after import with no server-side issues.
- The `SELECT @All` clause seen in the Domino Designer-exported DXL is the document selection formula. It can be omitted when using `<documentset type='runonce'/>`.

### DXL format

- **Do not include an XML declaration.** The Domino DXL importer's XML parser is strict about where `<?xml version='1.0' ...?>` may appear. When our code wraps your element fragment inside a `<database>` element before importing, an XML declaration in your payload ends up *inside* the root element. This is illegal XML and causes an immediate fatal parse error:

  ```text
  Fatal Error: No processing instruction starts with 'xml'
  ```

  This applies to **all endpoints that accept DXL**, such as `PUT /{type}/{name}`, `POST /import`, and `POST /validate`. Simply omit the declaration entirely as it is never required here.
- **Do not include a DOCTYPE declaration.** The same reason with the XML declaration, the importer rejects it.
- The exported DXL from `GET /{type}/{name}` and `GET /export` does not include either declaration, so round-tripping exported DXL is safe.
- The Lotus DXL namespace declaration is required on the root element:
  `xmlns='http://www.lotus.com/dxl'`.
- For `PUT /{type}/{name}`, supply only the element fragment, such as `<form ...>`, and not a full `<database>` wrapper.
- For `POST /import` and `POST /validate`, the DXL **must** be wrapped in `<database>...</database>`.
- A leading UTF-8 BOM is accepted and stripped by the importer and validator. This
  handles files generated by tools like Windows PowerShell `Out-File`.

## Known limitations

### Java compilation on import

When creating a Java agent using `PUT /{type}/{name}`, Domino attempts to compile the Java source immediately. On some server configurations, compilation can fail silently because of a wildcard `classpath` issue: `libs/*` is passed literally to `javac` instead of being shell-expanded.

If compilation fails, the agent note is still created and signed correctly, but contains only the source and no compiled bytecode and will not run. The import response includes a warning similar to the following:

```text
Java compile errors: error: illegal argument for --class-path: Illegal char <*>
```

The workaround is to open the agent in Domino Designer after import, which triggers recompilation in the Domino Designer environment where the `classpath` is handled correctly.

!!! note

    LotusScript agents are not affected by this issue.

### Ampersand in action button titles

The Domino C API DxlImporter silently drops `<action>` elements whose `title` attribute contains `&amp;` (the XML entity for `&`). For example, a button titled `Save & Close` is encoded in valid XML as `<action title='Save &amp; Close'>`, but the DxlImporter discards the entire element during import without any error raised and without any written log entry.

The issue originates in the Notes C API, not in the DXL specification or this extension. To prevent import failures, DXL-EXT automatically sanitizes affected action button titles before passing DXL to the importer. For example, a title containing `&amp;` is rewritten to use `and` (`Save & Close` becomes `Save and Close`).

When DXL-EXT makes this change, the import response includes a `"sanitized"` array that lists each modified value:

```json
"sanitized": [
  { "type": "actionTitleSanitized", "original": "Save & Close", "replaced": "Save and Close" }
]
```

This applies to `PUT /{type}/{name}` (synchronous — in the response body) and `POST /import` (asynchronous — in the job status when polled). If your action titles must avoid the word `and`, rename them before submitting the DXL.
