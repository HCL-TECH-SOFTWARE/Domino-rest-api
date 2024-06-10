# Example: Outgoing Rich Text content as plain

Let's say you want to retrieve the following Rich Text content as plain:

![Example Rich Text content](../../../../assets/images/ExampleRichtextContent.png)

Set the value of `richTextAs` query parameter to `plain`, and retrieve the document that contains it.

You should get the following in the `richtext` field response:

```json
{
  "type": "text/plain",
  "encoding": "PLAIN",
  "content": "I AM OVERWRITING THIS!Can't do anything about it :P\n\nYou have no power here..."
}
```
