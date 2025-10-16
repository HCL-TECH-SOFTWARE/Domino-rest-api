# Domino REST API is different

The audience for this chapter are mostly experienced Notes and Domino developers. It explains the differences and constraints compared to regular Notes development. However the curious mind, coming from other development disciplines will find interesting insights what makes Notes a highly flexible and unique platform.

## Recap on Notes' uniqueness

A Notes document contains items. Those items can have different data types, including some unique to Notes like Reader or Author (for declarative security) or Rich Text (a catch it all). The correct name is `item` not `field` - later more on this. An item can have a single value or multiple values. There is a loose connection to a Notes form, created by the value of an item with the name `form`. The connection is loose, since the value of that item can be overwritten or the item being absent.

The loose connection between document and form establishes an even looser connection between `items` in the document and `fields` in the form. When a document only is created or updated through the Notes, Domino, or XPages that don't have trigger code (onButton, on Save etc), the link is strong and field data type matches item data type.

Since items can be created, updated, and deleted through code (C, LotusScript, Java, @Formula, JavaScript, XPages, REST, DIOOP, gRPC), a document can have more, less, differently types items than fields on the document. This bond gets further loosened through the ability of computing names of subforms (shared sets of fields) at runtime based on conditions of the document or the cycle of the moon. There is no guarantee, just a possibility, that 2 documents with the same form item, have the same set of items.

Notes forms and views don't have unique names, there can be 10 folders with the name "Test" and a form and a subform. Often this views or forms are used to separate Notes client from WebUI behavior. Forms and views can have one or more aliases and can be hidden (only accessible programmatically). View are like folders with a fixed query attached. A column in a view can carry more than one data type and more than one document type. Views/Folders can be sorted by columns when specified in the design and can be organized into hierarchies.

_There is plenty of documentation on details_, look it up if so desired.

## Constraints

We don't try to boil the ocean, but follow Antoine de Saint-Exupéry who proclaimed:

"_Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away._"

- Domino REST API uses Forms as data schema. So access to a document is determined by the value of the form item.
- The Domino REST API configuration determines what items can be read/written per form and mode.
- The Admin UI provides access to the field names of the form, but the API lets you specify any field name.
- If an item doesn't exist in a document, it doesn't get returned.
- When you have multiple forms with the same name, the Admin UI will pick one, we don't guarantee which one.
- Same applies for views: we pick the first we find. Unique aliases or names help to avoid ambiguity.
- When an item name is not specified in the configuration, you can't read or write it.
- We translate Rich Text to HTML/MIME. This is one way. We don't translate MIME back to Rich Text.
