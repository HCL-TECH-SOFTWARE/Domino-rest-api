# Outgoing MIME Content as HTML Example 3

Let's say we want to retrieve the following MIME content as HTML:

```text
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="XXXXboundary text"

This is a multipart message in MIME format.

--XXXXboundary text
Content-Type: text/markdown

**this is the body text**

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
  "content": "<p><strong>this is the body text</strong></p>\n"
}
```

If there's no `text/html` part in the multipart MIME, it will then try to find the first `text/markdown` part and convert it to HTML.
