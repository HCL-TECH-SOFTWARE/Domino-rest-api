# Example 3: Outgoing MIME Content as Markdown

Let's say you want to retrieve the following MIME content as Markdown:

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

Set the value of `richTextAs` query parameter to `markdown`, and retrieve the document that contains it.

You should get the following in the `richtext` field response:

```json
{
  "type": "text/markdown",
  "encoding": "PLAIN",
  "content": "this is the html text\n=====================\n\n"
}
```

!!!note
    Since there's no `text/markdown` part in the stored multipart MIME, it falls back to finding a `text/html` part, converting it to Markdown, and then returning it as a response.
