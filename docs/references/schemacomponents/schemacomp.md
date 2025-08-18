# Schema components

<!--Make yourself familiar with [Schema and Scope](schemascope.md) to make full use of this article.-->

A schema stores meta data, form definitions, view definitions, and agent definitions. All are expressed in JSON, based as far as possible on [OpenAPI specification](https://swagger.io/specification/).

## Form definitions

Form definitions relate to *Documents that have a Form item with the given value*, not *the Form design element with the given name*. The [Admin UI](../usingwebui/index.md) uses fields listed in Form design elements, so it's convenient to create form definitions. At runtime, no Form design element is used by the REST API.

### Useful links

Tutorials

- [Manage database forms](../../tutorial/adminui.md#manage-database-forms)

References

- [List available database forms](../usingwebui/schemaui.md#list-available-database-forms)
- [Add new form schema](../usingwebui/schemaui.md#add-new-form-schema)
- [Activate a form](../usingwebui/schemaui.md#activate-a-form)
- [Change form configuration](../usingwebui/schemaui.md#change-form-configuration)

## View definitions

A view definition configures view visibility and the selection and naming of the view columns. It's an array of entries describing the name or alias, if any, and UNID of the view design element. Views show all columns contained.

### Useful links

Tutorials

- [Manage database views](../../tutorial/adminui.md#manage-database-views)
- [Verify the views for the demo database](../../tutorial/postmancurl.md#verify-the-views-for-the-demo-database)
- [List views with Swagger UI](../../tutorial/swagger.md#list-views-with-swagger-ui)

How-to guide

- [Edit database view of a schema](../../howto/database/editviewcolumn.md)

References

- [List available database views](../usingwebui/schemaui.md#list-available-database-views)
- [Activate a view](../usingwebui/schemaui.md#activate-a-view)
- [Edit a view](../usingwebui/schemaui.md#edit-a-view)

## Agent definitions

Suitable agents can be called from the Domino REST API.

!!! note

    The API doesn't check if the agent is suitable for being called individually. It's the developer's responsibility to ensure this.

### Useful links

Tutorials

- [Manage database agents](../../tutorial/adminui.md#manage-database-agents)

How-to guide

- [List available agents in the Admin UI](../usingwebui/schemaui.md#list-available-database-agents)
- [Activate an agent in the Admin UI](../usingwebui/schemaui.md#activate-an-agent)

References

- [Agents](https://help.hcl-software.com/dom_designer/14.0.0/basic/H_ABOUT_DESIGNING_AGENTS.html)
- [Agent processing](../../topicguides/agents.md)
- [Running Agents](../../topicguides/agents.md#running-agents)

## Meta data

!!! info

    Section under development

<!--## Let's connect

"feedback.md"-->
