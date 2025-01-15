# Schema & Scope

To effectively operate Domino REST API, one needs to be familiar with a few terms, their application, and the range of responsibility.

## Schema

A Schema is a design element located inside an NSF. It determines what data is accessible in the REST API, for read and write operations. For Views, Folders, and Agents, the schema narrows down from the existing Domino design elements.

### Form item, not Form design element

In case of a **Form** in a schema, this is different. A **Form** definition means: applicable for documents with a form item with the defined value. The REST API works even when there are no Form design elements in the NSF, which would be hard to use in a Notes client or nhttp.

In other words:

- What a form design element is to a document in a client, is the form schema in the REST API.
- The form schema can do more, see [Form modes](../topicguides/formmodes.md) and [The Barbican](../topicguides/barbican.md).
- The schema is the responsibility of the Domino developer.

## Scope

The scope is the name of a database advertised to REST API consumers. Once published, it's hard to change since all API consumers would need to update too. This is why there is a scope instead of using the NSF file path or replica ID.

The scope is mapped to an NSF, which is currently `KeepConfig.nsf`, through an entry in the REST directory. The scope is the responsibility of the Domino administrator.

## Tutorials

- [Using Admin UI](../tutorial/adminui.md)
- [Lab 03 - Schema exploration](../tutorial/walkthrough/lab-03.md)
- [Lab 04 - Additional scope & schema](../tutorial/walkthrough/lab-04.md)
- [Using Postman and curl to create a scope](../tutorial/postmancurl.md#create-a-scope)
- [Using Postman and curl to create a schema](../tutorial/postmancurl.md#create-a-schema)
- [Steps in creating a schema and scope in Quick Config](../tutorial/walkthrough/lab-02.md#steps-in-creating-a-schema-and-scope-in-quick-config)

## How-to guides

- [Use external names in schema definitions](../howto/database/externalnames.md)
- [The Domino REST API Schema](../howto/database/enablingadb.md#the-domino-rest-api-schema)
- [Enabling a database via Schema and Scope](../howto/database/enablingadb.md#enabling-a-database-via-schema-and-scope)

## References

- [Schema Management](../references/usingwebui/schemaui.md)
- [Scopes](../references/usingdominorestapi/scopes.md)
- [Scope Management](../references/usingwebui/scopeui.md)
- [Databases, schemas and scopes](../topicguides/understanding.md#databases-schemas-and-scopes)
- [Form and Alias handling](../references/usingdominorestapi/formnames.md)

## Let's connect

--8<-- "feedback.md"
