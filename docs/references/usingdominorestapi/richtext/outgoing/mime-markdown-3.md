# Outgoing MIME Content as Markdown Example 3

Let's say we want to retrieve the following MIME content as markdown:

```text
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="XXXXboundary text"

This is a multipart message in MIME format.

--XXXXboundary text
Content-Type: text/html

<h1>this is the html text</h1>

--XXXXboundary text
Content-Type: text/plain;
Content-Disposition: attachment;
        filename="test.txt"

this is the attachment text

--XXXXboundary text--
```

We then set the value of `richTextAs` query parameter to `markdown`, and retrieve the document that contains it.

We should get the following in the RichText field response:

```json
{
  "type": "text/markdown",
  "encoding": "PLAIN",
  "content": "this is the html text\n=====================\n\n"
}
```

!!!note
    Since there's no `text/markdown` part in the stored multipart MIME, it fallsback to find a `text/html` part and convert it to markdown, then return it as a response.
