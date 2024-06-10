# Example: Incoming text/html + plain

Let's say you want to save the following `text/html` content in a `richtext` field:

```text
<b>this is the body text</b>
```

Additionally, let's say you also want to create a `plain` alternative of the `text/html` content. You then use the following Rich Text JSON:

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
