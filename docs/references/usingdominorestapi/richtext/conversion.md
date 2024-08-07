# Conversion table

Here are the tables that specify how incoming Rich Text and outgoing Rich Text are converted.

!!!note
    All incoming and outgoing conversions shown here are the default processes. See [Extending Rich Text](../../../references/richtextension.md) for instructions on extending Rich Text processing.

## Incoming Rich Text

Incoming Rich Text is the Rich Text JSON specified on the request body as the value of a `richtext` field.

The following table is a matrix for submitted types together with its supported `createAdditional` switches and how it's stored as.

!!!note
    `createAdditional` is an optional property in the Rich Text JSON that you use to specify what **alternative** types to create additionally from the original content. It saves a `multipart/alternative` MIME that contains the original content type and the specified types in the `create additional` property. Currently, the available values for `createAdditional` are ***plain*** and ***html***.
    

| Submitted type        | createAdditional | Stored as                                                               | Example                                           |
|-----------------------|------------------|-------------------------------------------------------------------------|---------------------------------------------------|
| multipart/mixed       | -                | multipart/mixed                                                         | [Example](./incoming/multipart-mixed.md)          |
| multipart/alternative | -                | multipart/alternative                                                   | [Example](./incoming/multipart-alternative.md)    |
| text/plain            | -                | text/plain                                                              | [Example](./incoming/text-plain.md)               |
| text/html             | -                | text/html                                                               | [Example](./incoming/text-html.md)                |
| text/html             | plain            | - multipart/alternative<br>- text/html                                    | [Example](./incoming/text-html+plain.md)          |
| text/markdown         | -                | text/markdown                                                           | [Example](./incoming/text-markdown.md)            |
| text/markdown         | plain            | - multipart/alternative<br/>- text/markdown<br/>- text/plain                | [Example](./incoming/text-markdown+plain.md)      |
| text/markdown         | html             | - multipart/alternative<br>- text/markdown<br>- text/html                 | [Example](./incoming/text-markdown+html.md)       |
| text/markdown         | plain, html      | - multipart/alternative<br>- text/markdown<br>- text/plain<br>- text/html | [Example](./incoming/text-markdown+plain+html.md) |

!!!warning
    Updating the `richtext` field in Notes client may alter what Domino REST API has stored in it. For example, a stored `multipart/alternative` gets overwritten if the `richtext` field is updated using the Notes client.

## Outgoing Rich Text

Outgoing Rich Text is how the value of the `richtext` field is shown in the response body.

The following table shows the content of the `richtext` field, its different `richTextAs` values, and their corresponding results.

| Content  | richTextAs | Result type     | Notes                                                          | Example                                                                                                                                                                                                             |
|----------|------------|-----------------|----------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Rich Text | mime       | multipart/mixed |                                                                | [Example](./outgoing/richtext-mime.md)                                                                                                                                                                              |
| Rich Text | html       | text/html       |                                                                | [Example](./outgoing/richtext-html.md)                                                                                                                                                                              |
| Rich Text | plain      | text/plain      |                                                                | [Example](./outgoing/richtext-plain.md)                                                                                                                                                                             |
| Rich Text | markdown   | text/markdown   |                                                                | [Example](./outgoing/richtext-markdown.md)                                                                                                                                                                          |
| MIME     | mime       | multipart/mixed |                                                                | [Example 1](./outgoing/mime-mime-1.md)<br>[Example 2](./outgoing/mime-mime-2.md)                                                                                                                                    |
| MIME     | html       | text/html       | Fallbacks:<br/>- text/markdown &rarr; html                          | [Example 1](./outgoing/mime-html-1.md)<br>[Example 2](./outgoing/mime-html-2.md)<br>[Example 3](./outgoing/mime-html-3.md)<br>[Example 4](./outgoing/mime-html-4.md)                                                |
| MIME     | markdown   | text/markdown   | Fallbacks:<br/>- text/html &rarr; markdown                          | [Example 1](./outgoing/mime-markdown-1.md)<br>[Example 2](./outgoing/mime-markdown-2.md)<br>[Example 3](./outgoing/mime-markdown-3.md)<br>[Example 4](./outgoing/mime-markdown-4.md)                                |
| MIME     | plain      | text/plain      | Fallbacks:<br/>- text/html &rarr; plain<br>- text/markdown &rarr; plain | [Example 1](./outgoing/mime-plain-1.md)<br>[Example 2](./outgoing/mime-plain-2.md)<br>[Example 3](./outgoing/mime-plain-3.md)<br>[Example 4](./outgoing/mime-plain-4.md)<br>[Example 5](./outgoing/mime-plain-5.md) |
