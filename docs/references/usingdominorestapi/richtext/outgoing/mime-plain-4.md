# Outgoing MIME Content as Plain Example 4

Let's say we want to retrieve the following MIME content as plain:

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

We then set the value of `richTextAs` query parameter to `plain`, and retrieve the document that contains it.

We should get the following in the RichText field response:

```json
{
  "type": "text/plain",
  "encoding": "PLAIN",
  "content": "this is the markdown text"
}
```

If there's no `text/plain` part in the multipart MIME, and no `text/html` part, it will then try to find the first `text/markdown` part and convert it to plain.
