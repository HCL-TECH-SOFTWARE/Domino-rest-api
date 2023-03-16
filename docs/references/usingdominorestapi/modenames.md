# Reserved Form mode names

We use form modes to specify what data can be read or written to documents using the form name in their form item. While you are generally free to pick any name (lower case, no special characters), there are names with a special purpose, namely:

## default

The `default` mode is, as the name implies, the default when creating or reading documents and in the absence of an explicityly specified `mode=` parameter

## dql

WHen data is queried by [DQL](TODO: link to DQL), forms need a `dql` mode to return values. The mode specified what data gets returned. If a form doeesn't have a `dql` mode, no data will be returned for that form in a DQL query

## odata

smae but for odata -> link to wikipedia is wrong

## raw

needed for `/api/v1/raw` endpoint
