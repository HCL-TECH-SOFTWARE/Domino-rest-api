# Incoming text/html Example

Let's say we want to save the following `text/html` content in a richtext field:

```text
<b>this is the body text</b>
```

We use that as the `content` in the following RichText JSON:

```json
{
  "type": "text/html",
  "encoding": "PLAIN",
  "content": "<b>this is the body text</b>"
}
```

This saves a `text/html` MIME:

```text
MIME-Version: 1.0
Content-Type: text/html

<b>this is the body text</b>
```
