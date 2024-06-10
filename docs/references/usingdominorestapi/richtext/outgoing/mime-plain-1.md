# Example 1: Outgoing MIME content as plain

Let's say you want to retrieve the following MIME content as plain:

```text
MIME-Version: 1.0
Content-Type: text/plain

this is the body text
```

Set the value of `richTextAs` query parameter to `plain`, and retrieve the document that contains it.

You should get the following in the `richtext` field response:

```json
{
  "type": "text/plain",
  "encoding": "PLAIN",
  "content": "this is the body text"
}
```
