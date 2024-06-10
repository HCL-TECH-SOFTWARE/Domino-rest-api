# Example 3: Outgoing MIME content as HTML

Let's say you want to retrieve the following MIME content as HTML:

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

You then set the value of `richTextAs` query parameter to `html`, and retrieve the document that contains it.

You should get the following in the `richtext` field response:

```json
{
  "type": "text/html",
  "encoding": "PLAIN",
  "content": "<p><strong>this is the markdown text</strong></p>\n"
}
```

!!!note
    Since there's no `text/html` part in the stored multipart MIME, it falls back to finding a `text/markdown` part, converting it to HTML, and then returning it as a response.
