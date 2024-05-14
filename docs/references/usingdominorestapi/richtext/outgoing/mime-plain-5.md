# Outgoing MIME Content as Plain Example 5

Let's say we want to retrieve the following MIME content as plain:

```text
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="XXXXboundary text"

This is a multipart message in MIME format.

--XXXXboundary text
Content-Type: application/json;
Content-Disposition: attachment;
        filename="demo1.json"

{"key1":"value1","key2":"value2","key3":"value3"}

--XXXXboundary text
Content-Type: application/json;
Content-Disposition: attachment;
        filename="demo2.json"

{"key1":"value1","key2":"value2","key3":"value3"}
--XXXXboundary text--
```

We then set the value of `richTextAs` query parameter to `plain`, and retrieve the document that contains it.

We should get the following in the RichText field response:

```json
{
  "type": "text/plain",
  "encoding": "PLAIN",
  "content": "demo1.json Type: application/json Name: demo1.json demo2.json Type: application/json Name: demo2.json"
}
```

Since the multipart has no `text/plain`, and also has no `text/html` and `text/markdown` to fallback to, it then returned a plain conversion of the MIME parts.
