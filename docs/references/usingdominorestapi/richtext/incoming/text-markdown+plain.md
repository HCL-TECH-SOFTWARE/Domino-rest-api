# Incoming text/markdown +plain Example

Let's say we want to save the following `text/markdown` content in a richtext field:

```text
**this is the body text**
```

Additionally, let's say we also want to create a `plain` alternative of the `text/markdown` content. We then use the following RichText JSON:

```json
{
  "type": "text/markdown",
  "encoding": "PLAIN",
  "content": "**this is the body text**",
  "createAdditional": "plain"
}
```

This saves a `multipart/alternative` MIME:

```text
MIME-Version: 1.0
Content-Type: multipart/alternative; 
  boundary="XXXXboundary text"
--XXXXboundary text
Content-Type: text/markdown

**this is the body text**
--XXXXboundary text
Content-Type: text/plain

this is the body text
--XXXXboundary text--
```
