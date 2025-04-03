# Form modes

Form Modes are enhanced security measures provided by [The Barbican](barbican.md). They allow you to specify which document items are available for read-and-write operations based on a formula result. For example, `@IsMember(Approvers; @UserName)` makes the mode available when the current user is listed in the `Approvers` item.

<!--## Tutorials

- add links-->

## How-to guides

- [Add a mode](../references/usingwebui/schemaui.md#add-a-mode)
- [Clone a mode](../references/usingwebui/schemaui.md#clone-a-mode)
- [Compare modes](../references/usingwebui/schemaui.md#compare-modes)

## References

- [Form Modes](barbican.md#form-modes)
- [Reserved Form mode names](../references/usingdominorestapi/modenames.md)
- [Forms & Mode](../howto/database/enablingadb.md#forms-and-mode)

## Let's connect

--8<-- "feedback.md"
