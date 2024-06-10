# Example 5: Outgoing MIME content as plain

Let's say you want to retrieve the following MIME content as plain:

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

Set the value of `richTextAs` query parameter to `plain`, and retrieve the document that contains it.

You should get the following in the `richtext` field response:

```json
{
  "type": "text/plain",
  "encoding": "PLAIN",
  "content": "demo1.json Type: application/json Name: demo1.json demo2.json Type: application/json Name: demo2.json"
}
```

!!!note
    Since there's no `text/html` part in the stored multipart MIME and no `text/html` and `text/markdown` parts to fall back to, it returns a plain conversion of all MIME parts.
