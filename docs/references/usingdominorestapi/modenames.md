# Reserved Form mode names

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
