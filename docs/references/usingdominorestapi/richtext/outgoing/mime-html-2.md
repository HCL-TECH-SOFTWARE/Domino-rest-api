# Outgoing MIME Content as HTML Example 2

Let's say we want to retrieve the following MIME content as HTML:

```text
MIME-Version: 1.0
Content-Type: multipart/alternative; 
  boundary="XXXXboundary text"
--XXXXboundary text
Content-Type: text/markdown

**this is the body text**
--XXXXboundary text
Content-Type: text/html

<p><strong>this is the body text</strong></p>

--XXXXboundary text
Content-Type: text/plain

this is the body text
--XXXXboundary text--
```

We then set the value of `richTextAs` query parameter to `html`, and retrieve the document that contains it.

We should get the following in the RichText field response:

```json
{
  "type": "text/html",
  "encoding": "PLAIN",
  "content": "<p><strong>this is the body text</strong></p>\r\n"
}
```

It returned only the first `text/html` part it sees in the multipart MIME.
