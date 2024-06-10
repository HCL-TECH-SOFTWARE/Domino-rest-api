# Example 2: Outgoing MIME content as plain

Let's say you want to retrieve the following MIME content as plain:

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

Set the value of `richTextAs` query parameter to `plain`, and retrieve the document that contains it.

You should get the following in the `richtext` field response:

```json
{
  "type": "text/plain",
  "encoding": "PLAIN",
  "content": "this is the plain text"
}
```

!!!note
    Since you have a `text/plain` part in the stored multipart MIME, it gets that and returns it as a response.
