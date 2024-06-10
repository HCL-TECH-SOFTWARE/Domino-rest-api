# Example 3: Outgoing MIME content as plain

Let's say we want to retrieve the following MIME content as plain:

```text
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="XXXXboundary text"

This is a multipart message in MIME format.

--XXXXboundary text
Content-Type: text/html

<b>this is the html text</b>

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
  "content": "this is the html text"
}
```

!!!note
    Since there's no `text/plain` part in the stored multipart MIME, it falls back to finding a `text/html` part, converting it to plain, and then returning it as a response.
