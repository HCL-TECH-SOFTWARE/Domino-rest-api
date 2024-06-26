# Example 4: Outgoing MIME content as HTML

Let's say you want to retrieve the following MIME content as HTML:

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

You then set the value of `richTextAs` query parameter to `html`, and retrieve the document that contains it.

You should get the following in the `richtext` field response:

```json
{
  "type": "text/html",
  "encoding": "PLAIN",
  "content": "<pre>this is the plain text\r\n</pre>\r\n<p>\r\n<table border=\"1\" cellspacing=\"2\" cellpadding=\"4\">\r\n<tr valign=\"middle\"><td><a href=\"/Demo.nsf/0/e2dc5306e0c6fc2400258b1d003accff/Body/M2/test.txt?OpenElement\"><img hspace=\"4\" align=\"middle\" src=\"/icons/medoc.gif\" border=\"0\" alt=\"Document Icon\" />test.txt</a></td><td><B>Type: </B>text/plain<br />\r\n<B>Name: </B>test.txt</td></tr>\r\n</table>\r\n</p>\r\n"
}
```

!!!note
    Since there's no `text/html` part in the stored multipart MIME and no `text/markdown` part to fall back to, it then returns an HTML conversion of all MIME parts.
