# Schema components

Make yourself familiar with [Schema and Scope](../../topicguides/schemascope.md) to make full use of this article.

A schema stores meta data, form definitions, view definitions, and agent definitions. All are expressed in JSON, based as far as possible on [OpenAPI specification](https://swagger.io/specification/).

## Meta data

    *Section under development*

## [Form definitions](./formdefinitions.md)

Form definitions relate to *Documents that have a Form item with the given value*, not *the Form design element with the given name*. The Admin UI uses fields listed in Form design elements, so it's convenient to create form definitions. 

## [View definitions](./viewdefinitions.md)

An array of entries describing the name or alias, if any, and UNID of the view design element. Views shows all columns contained.

## [Agent definitions](./agentdefinitions.md)

Suitable agents can be called from the Domino REST API.

## Tutorials

- [Using Admin UI](../../tutorial/adminui.md)

## References

- [Schema Management](../usingwebui/schemaui.md)

## Let's connect

--8<-- "feedback.md"
