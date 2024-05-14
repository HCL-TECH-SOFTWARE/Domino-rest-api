# Incoming text/markdown Example

Let's say we want to save the following `text/markdown` content in a richtext field:

```text
**this is the body text**
```

We use that as the `content` in the following RichText JSON:

```json
{
  "type": "text/markdown",
  "encoding": "PLAIN",
  "content": "**this is the body text**"
}
```

This saves a `text/markdown` MIME:

```text
MIME-Version: 1.0
Content-Type: text/markdown

**this is the body text**
```
