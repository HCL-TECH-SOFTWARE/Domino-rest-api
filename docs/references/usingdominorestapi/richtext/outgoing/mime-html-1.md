# Example 1: Outgoing MIME content as HTML

Let's say you want to retrieve the following MIME content as HTML:

```text
MIME-Version: 1.0
Content-Type: text/html

<b>this is the body text</b>
```

Set the value of `richTextAs` query parameter to `html`, and retrieve the document that contains it.

You should get the following in the `richtext` field response:

```json
{
  "type": "text/html",
  "encoding": "PLAIN",
  "content": "<b>this is the body text</b>"
}
```
