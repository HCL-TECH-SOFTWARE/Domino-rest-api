# Outgoing MIME Content as HTML Example 1

Let's say we want to retrieve the following MIME content as HTML:

```text
MIME-Version: 1.0
Content-Type: text/html

<b>this is the body text</b>
```

We then set the value of `richTextAs` query parameter to `html`, and retrieve the document that contains it.

We should get the following in the RichText field response:

```json
{
  "type": "text/html",
  "encoding": "PLAIN",
  "content": "<b>this is the body text</b>"
}
```
