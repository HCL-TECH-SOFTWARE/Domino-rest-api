# Example 4: Outgoing MIME Content as Markdown

Let's say you want to retrieve the following MIME content as Markdown:

```text
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="XXXXboundary text"

This is a multipart message in MIME format.

--XXXXboundary text
Content-Type: text/plain

this is the plain text

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
  "content": "```\nthis is the plain text\r\n```\n\n\n|-------------------------------------------------------------------------------------------------------------------------|----------------------------------------|\n| [![Document Icon](/icons/medoc.gif)test.txt](/Demo.nsf/0/2d7369e981bf1c8400258b1d003e1a01/Body/M2/test.txt?OpenElement) | **Type:** text/plain **Name:**test.txt |\n\n<br />\n\n"
}
```

!!!note
    Since there's no `text/markdown` part in the stored multipart MIME and no `text/html` part to fall back to, it returns a Markdown conversion of all MIME parts.
