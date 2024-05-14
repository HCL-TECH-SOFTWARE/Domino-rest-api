# Outgoing MIME Content as Plain Example 1

Let's say we want to retrieve the following MIME content as plain:

```text
MIME-Version: 1.0
Content-Type: text/plain

this is the body text
```

We then set the value of `richTextAs` query parameter to `plain`, and retrieve the document that contains it.

We should get the following in the RichText field response:

```json
{
  "type": "text/plain",
  "encoding": "PLAIN",
  "content": "this is the body text"
}
```
