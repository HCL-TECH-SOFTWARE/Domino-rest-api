# Incoming text/markdown +plain +html Example

Let's say we want to save the following `text/markdown` content in a richtext field:

```text
**this is the body text**
```

Additionally, let's say we also want to create a `plain` and `html` alternative of the `text/markdown` content. We then use the following RichText JSON:

```json
{
  "type": "text/markdown",
  "encoding": "PLAIN",
  "content": "**this is the body text**",
  "createAdditional": "plain,html"
}
```

!!!note
    Multiple entries for `createAdditional` should be comma-separated.

This saves a `multipart/alternative` MIME:

```text
MIME-Version: 1.0
Content-Type: multipart/alternative; 
  boundary="XXXXboundary text"
--XXXXboundary text
Content-Type: text/markdown

**this is the body text**
--XXXXboundary text
Content-Type: text/html

<p><strong>this is the body text</strong></p>

--XXXXboundary text
Content-Type: text/plain

this is the body text
--XXXXboundary text--
```
