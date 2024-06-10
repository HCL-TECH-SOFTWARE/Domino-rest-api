# Example 2: Outgoing MIME content as MIME

Let's say you want to retrieve the following MIME content as MIME:

```text
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="XXXXboundary text"

This is a multipart message in MIME format.

--XXXXboundary text
Content-Type: text/plain

this is the body text

--XXXXboundary text
Content-Type: text/html

<b>this is the body text</b>

--XXXXboundary text--
```

You then set the value of `richTextAs` query parameter to `mime`, or leave it as blank because it'll be `mime` by default, and retrieve the document that contains it.

You should get a `multipart/mixed` MIME with its `content` encoded in `BASE64` in the `richtext` field response. Decoding it should yield the following:

```text
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="XXXXboundary text"

This is a multipart message in MIME format.

--XXXXboundary text
Content-Type: text/plain

this is the body text

--XXXXboundary text
Content-Type: text/html

<b>this is the body text</b>

--XXXXboundary text--
```
