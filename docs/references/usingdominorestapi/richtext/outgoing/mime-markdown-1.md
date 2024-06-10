# Example 1: Outgoing MIME content as Markdown

Let's say you want to retrieve the following MIME content as Markdown:

```text
MIME-Version: 1.0
Content-Type: text/markdown

**this is the body text**
```

Set the value of `richTextAs` query parameter to `markdown`, and retrieve the document that contains it.

You should get the following in the `richtext` field response:

```json
{
  "type": "text/markdown",
  "encoding": "PLAIN",
  "content": "**this is the body text**"
}
```
