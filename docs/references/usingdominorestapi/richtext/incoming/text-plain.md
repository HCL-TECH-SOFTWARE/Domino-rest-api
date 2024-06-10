# Example: Incoming text/plain

Let's say you want to save the following `text/plain` content in a `richtext` field:

```text
this is the body text
```

You use that as the `content` in the following Rich Text JSON:

```json
{
  "type": "text/plain",
  "encoding": "PLAIN",
  "content": "this is the body text"
}
```

This saves a `text/plain` MIME:

```text
MIME-Version: 1.0
Content-Type: text/plain

this is the body text
```
