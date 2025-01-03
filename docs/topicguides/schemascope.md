# Schema & Scope

To be happily operating the Domino REST API one needs to be familiar with a few terms, their application and the range of resposibility.

## Schema

A Schema is a design element located inside an NSF. It determines what data is accessible in the REST API, for read and write operations. For Views, Folders and Agents the schema narrows down from the exsiting Domino design Elements.

### Form item, not Form design element

In case of a "Form" in a schema, this is different!
A "Form" definition means: Applicable for documents with a form item with the defined value. The REST API works even when there are no Form design elements in the NSF (which would be hard to use in a Notes client or nHttp).

In other words:

What a form design element is to a document in a client, is the form schema in the REST API.

The form schema can do more, see [Form modes](#) and [The Barbican](#).

The schema is the responsibility of the Domino developer

## Scope

The scope is the name a database gets advertised to consumers of the REST API. Once published it is hard to change, since all consumers of the API would need to update too. This is the reason why ther is a scope instead of using the NSF filepath or replica ID.

The scope is mapped to an NSF through an entry in the REST directory (currently `KeepConfig.nsf`).

The scope is the responsibility of the Domino administrator

## Tutorials

- add links

## How to

- add links

## References

- add links

## Let's connect

--8<-- "feedback.md"
