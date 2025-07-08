# Limitations and considerations

This section outlines known limitations and important considerations for using the Domino REST API.

- The Domino REST API uses Forms as a data schema. So, access to a document is determined by the value of the form item.
- The Domino REST API configuration determines what items can be read or written per form and mode.
- The Admin UI provides access to the field names of the form, but the API lets you specify any field name.
- If an item doesn't exist in a document, it doesn't get returned.
- When you have multiple forms with the same name, the Admin UI selects one without any guarantee which one.
- When you have multiple views with the same name, the Admin UI selects the first one found. Unique aliases or names help to avoid ambiguity.
- When an item name isn't specified in the configuration, you can't read or write it.
- The Domino REST API translates Rich Text to HTML/MIME. This is one way. The Domino REST API doesn't translate MIME back to Rich Text.

- Documents can only be read when they have a Form item configured in `KeepConfig` to allow access.
- Only configured fields can be created, read, or updated.

    !!! note

        If no fields are configured in `KeepConfig`, no fields on the form can be accessed. As a best practice, define fields to constitute the schema for the document at this mode. A warning is logged to the console if fields are not set. On write access, this ensures unexpected fields are not submitted.

- An item in a document can be accessed only if there is a matching field on the form or a field configured in `KeepConfig`.
