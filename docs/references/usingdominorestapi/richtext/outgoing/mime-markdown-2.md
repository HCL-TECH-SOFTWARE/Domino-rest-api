# Outgoing MIME Content as Markdown Example 2

Let's say we want to retrieve the following MIME content as markdown:

```text
MIME-Version: 1.0
Content-Type: multipart/alternative; 
  boundary="XXXXboundary text"
--XXXXboundary text
Content-Type: text/markdown

**this is the markdown text**
--XXXXboundary text
Content-Type: text/html

<p><strong>this is the html text</strong></p>

--XXXXboundary text
Content-Type: text/plain

this is the plain text
--XXXXboundary text--
```

We then set the value of `richTextAs` query parameter to `markdown`, and retrieve the document that contains it.

We should get the following in the RichText field response:

```json
{
  "type": "text/markdown",
  "encoding": "PLAIN",
  "content": "**this is the markdown text**"
}
```

!!!note
    Since, we have a `text/markdown` part in the stored multipart MIME, it gets that and returned it as a response.