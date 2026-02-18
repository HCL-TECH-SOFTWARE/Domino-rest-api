# Reserved Form Mode names

In the Domino REST API, Form Modes specify what data can be read or written to documents using the form name in their form item. You can create any name as long as it is in lowercase and has no special characters, but there are certain Form Mode names that are reserved and have specific purposes.  

## default

The `default` mode is the standard mode used when:

- reading or creating documents
- there is no explicitly specified `mode=` parameter

## dql

The `dql` mode specifies what fields are returned when querying documents using [DQL](https://help.hcltechsw.com/dom_designer/12.0.1/basic/dql_overview.html). If a form does not include a `dql` mode, no data for that form will be returned in DQL queries.

## odata

The `odata` mode defines what data the OData endpoints will expose for the form. Domino REST API supports the [Open Data Protocol (OData)](https://www.odata.org), and if a form does not have an `odata` mode, OData queries won't return any data for that form.

## raw

The `raw` mode is used by the `/api/v1/raw` endpoint. When a client requests data via `/api/v1/raw`, the form must have a `raw` mode defined, and the current user must have access permission as expressed in the `@formula` of the `raw` mode definition. Because this mode can expose all fields without transformation, it is typically restricted to administrators or support users only.

!!! note

    `raw` returns all fields exactly as stored, without translation or adjustment.

## vsheet

The `vsheet` mode is used by the [Virtual Spreadsheet](../../howto/production/virtualsheet.md) feature. It must include all fields on the form because it allows view-like editing where changes are saved back to documents. If a `vsheet` mode is missing, the Virtual Spreadsheet functionality cannot save edits.

<!--
Use form modes to specify what data can be read or written to documents using the form name in their form item. While you are free to pick any name (lower case, no special characters), there are names with a special purpose, namely:

## default

The `default` mode is, as the name implies, the default when creating or reading documents and in the absence of an explicitly specified `mode=` parameter

## dql

When data is queried by [DQL](https://help.hcltechsw.com/dom_designer/12.0.1/basic/dql_overview.html), forms need a `dql` mode to return values. The mode specified what data gets returned. If a form doesn't have a `dql` mode, no data will be returned for that form in a DQL query.

## odata

The `odata` mode lets you define the data that comes through OData endpoints. The API support the OData standard [Open Data Protocol(OData)](https://www.odata.org). If a form doesn't have an `odata` mode, then an OData won't return any data for that form.

## raw

Needed for `/api/v1/raw` endpoint. The endpoint `/api/v1/raw` will only return data when the mode `raw` exists for the form requested and the user has the permission, expressed in the @formula of the raw mode definition. Typically you want to restrict raw access to admin and support users.

## vsheet

The [Virtual Spreadsheet feature](../../howto/production/virtualsheet.md) uses the `vsheet` mode to save the changes made on each view entry to its respective document. It's recommended that this mode contains all fields that the form has. The Virtual Spreadsheet feature won't be able to save any changes without this mode.

!!!note
    `raw` mode returns all fields without translation or adjustment.

-->