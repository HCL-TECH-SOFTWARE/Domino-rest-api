# Reserved Form mode names

We use form modes to specify what data can be read or written to documents using the form name in their form item. While you are generally free to pick any name (lower case, no special characters), there are names with a special purpose, namely:

## default

The `default` mode is, as the name implies, the default when creating or reading documents and in the absence of an explicityly specified `mode=` parameter

## dql

WHen data is queried by [DQL](TODO: link to DQL), forms need a `dql` mode to return values. The mode specified what data gets returned. If a form doeesn't have a `dql` mode, no data will be returned for that form in a DQL query

## 
You use a mode which will set a different sets of data coming from a document within the same form. 
There are three reserved form mode names in Domino API database management namely:

| Name                          | Description                                                                                       |
| -----------                   | ----------- |
| Default                       | Default is the pre-selected option that is available to the user. The Default mode is automatically created when configuring a form in a Schema. The Default mode of the Form that is being referenced will be applied whenever an API calls for the declaration of a Scope (dataSource). |
| DQL                           | A unique mode that may be created using the Database Management REST API is denoted by the DQL mode name. It allows you to define the data come through with DQL endpoints.  Domino Query Language, often known as DQL, is the method that is used in order to get data from a Domino Server. It always use a DQL query to retrieve the data and returns a JSON data back. |
| odata                         | The odata mode lets you define the data that comes through our odata endpoints. The API support the odata standard [Open Data Protocol(oData)](https://en.wikipedia.org/wiki/). The odata mode defines the data that may be obtained or changed using odata mode.    |

## raw

needed for `/api/v1/raw` endpoint
