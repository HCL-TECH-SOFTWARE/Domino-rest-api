# Example: Outgoing Rich Text content as Markdown

Let's say you want to retrieve the following Rich Text content as Markdown:

![Example Rich Text content](../../../../assets/images/ExampleRichtextContent.png)

Set the value of `richTextAs` query parameter to `markdown`, and retrieve the document that contains it.

You should get the following in the `richtext` field response:

```json
{
  "type": "text/markdown",
  "encoding": "PLAIN",
  "content": "I AM OVERWRITING THIS!  \nCan't do anything about it :P  \nYou have no power here...\n"
}
```
