# Outgoing RichText Content as markdown Example

Let's say we want to retrieve the following RichText content as markdown:

![Example RichText content](../../../../assets/images/ExampleRichtextContent.png)

We then set the value of `richTextAs` query parameter to `markdown`, and retrieve the document that contains it.

We should get the following in the RichText field response:

```json
{
  "type": "text/markdown",
  "encoding": "PLAIN",
  "content": "I AM OVERWRITING THIS!  \nCan't do anything about it :P  \nYou have no power here...\n"
}
```
