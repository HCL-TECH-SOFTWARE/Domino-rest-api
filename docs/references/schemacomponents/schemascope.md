# Schema and Scope

To use the Domino REST API effectively, it’s important to understand a few key concepts, how they apply, and who is responsible for managing them.

To effectively operate Domino REST API, you needs to be familiar with a the following terms, their application, and the range of responsibility.

## Schema

A Schema is a design element located inside an NSF database. It defines what data is accessible via the REST API for reading and writing. For Views, Folders, and Agents, the schema narrows down from the existing Domino design elements.

### Form Item, Not Form Design Element

When referring to a **Form** in a schema, this is different. A **Form** definition applies to documents that have a form item with the specified value. The REST API functions even if there are no Form design elements present in the NSF, which would otherwise be challenging to use in a Notes client or with nhttp.

In other words:

- What a form design element is to a document in a client, is the form schema in the REST API.
- The form schema can do more, see [The Barbican](../extensibility/barbican.md#form-modes) for more information.
- The schema is the responsibility of the Domino developer.

## Scope

The scope is the name under which a database is presented to REST API consumers. Once published, changing the scope is difficult because all API consumers would need to update their references. This makes the scope a more stable and manageable identifier compared to using the NSF file path or replica ID.

Each scope is mapped to an NSF database, which is currently `KeepConfig.nsf`, through an entry in the REST directory. Managing scopes is the responsibility of the Domino administrator.

## Useful links

Tutorials

- [Using Admin UI](../../tutorial/adminui.md)
- [Lab 03 - Schema exploration](../../tutorial/walkthrough/lab-03.md)
- [Lab 04 - Additional scope & schema](../../tutorial/walkthrough/lab-04.md)
- [Using Postman and curl to create a scope](../../tutorial/postmancurl.md#create-a-scope)
- [Using Postman and curl to create a schema](../../tutorial/postmancurl.md#create-a-schema)
- [Steps in creating a schema and scope in Quick Config](../../tutorial/walkthrough/lab-02.md#procedure)

How-to guides

- [Use external names in schema definitions](../../howto/database/externalnames.md)
- [The Domino REST API Schema](../../howto/database/enablingadb.md#the-domino-rest-api-schema)
- [Enabling a database via Schema and Scope](../../howto/database/enablingadb.md#enabling-a-database-via-schema-and-scope)
- [Add a mode](../usingwebui/schemaui.md#add-a-mode)
- [Clone a mode](../usingwebui/schemaui.md#clone-a-mode)
- [Compare modes](../usingwebui/schemaui.md#compare-modes)

References

- [Schema Management](../usingwebui/schemaui.md)
- [Scopes](../schemacomponents/scopes.md)
- [Scope Management](../usingwebui/scopeui.md)
- [Databases, schemas and scopes](../../topicguides/understanding.md#databases-schemas-and-scopes)
- [Form and Alias handling](../usingdominorestapi/formnames.md)

<!--## Let's Connect

"feedback.md"-->
