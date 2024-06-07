# Outgoing MIME Content as HTML Example 3

Let's say we want to retrieve the following MIME content as HTML:

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

We then set the value of `richTextAs` query parameter to `html`, and retrieve the document that contains it.

We should get the following in the RichText field response:

```json
{
  "type": "text/html",
  "encoding": "PLAIN",
  "content": "<p><strong>this is the markdown text</strong></p>\n"
}
```

!!!note
    Since there's no `text/html` part in the stored multipart MIME, it fallsback to find a `text/markdown` part and convert it to HTML, then return it as a response.
