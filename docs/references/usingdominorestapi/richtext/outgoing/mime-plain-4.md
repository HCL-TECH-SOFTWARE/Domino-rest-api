# Example 4: Outgoing MIME content as plain

Let's say you want to retrieve the following MIME content as plain:

```text
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="XXXXboundary text"

This is a multipart message in MIME format.

--XXXXboundary text
Content-Type: text/markdown

**this is the markdown text**

--XXXXboundary text
Content-Type: text/plain;
Content-Disposition: attachment;
        filename="test.txt"

this is the attachment text

--XXXXboundary text--
```

Set the value of `richTextAs` query parameter to `plain`, and retrieve the document that contains it.

You should get the following in the `richtext` field response:

```json
{
  "type": "text/plain",
  "encoding": "PLAIN",
  "content": "this is the markdown text"
}
```

!!!note
    Since there's no `text/plain` part in the stored multipart MIME and no `text/html` part to fall back to, it then checks for a `text/markdown` part, converts it to plain, and then returns it as a response.
