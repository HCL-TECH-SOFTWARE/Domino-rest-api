# Incoming text/html +plain Example

Let's say we want to save the following `text/html` content in a richtext field:

```text
<b>this is the body text</b>
```

Additionally, let's say we also want to create a `plain` alternative of the `text/html` content. We then use the following RichText JSON:

```json
{
  "type": "text/html",
  "encoding": "PLAIN",
  "content": "<b>this is the body text</b>",
  "createAdditional": "plain"
}
```

This saves a `multipart/alternative` MIME:

```text
MIME-Version: 1.0
Content-Type: multipart/alternative; 
  boundary="XXXXboundary text"
--XXXXboundary text
Content-Type: text/html

<b>this is the body text</b>
--XXXXboundary text
Content-Type: text/plain

this is the body text
--XXXXboundary text--
```
