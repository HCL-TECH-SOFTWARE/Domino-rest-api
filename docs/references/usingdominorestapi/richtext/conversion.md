# Conversion table

Here are the tables that specifies how incoming and outgoing RichTexts are converted.

## Incoming RichTexts

Incoming RichTexts are the RichText JSON specified on the request body as the value of a RichText field.

The following table is a matrix for submitted types together with its supported `createAdditional` switches and what is stored.

!!!note
    `createAdditional` is an optional property in the RichText JSON which you can specify what **alternative** types to create additionally from the original content. This will save a `multipart/alternative` MIME that contains the original content type along with the specified types in the `createAdditional` property.<br/><br/>
    Refer to the table for each submitted type's supported `createAdditional` switches.

| Submitted type        | createAdditional | Stored as                                                               | Example                                           |
|-----------------------|------------------|-------------------------------------------------------------------------|---------------------------------------------------|
| multipart/mixed       | -                | multipart/mixed                                                         | [Example](./incoming/multipart-mixed.md)          |
| multipart/alternative | -                | multipart/alternative                                                   | [Example](./incoming/multipart-alternative.md)    |
| text/plain            | -                | text/plain                                                              | [Example](./incoming/text-plain.md)               |
| text/html             | -                | text/html                                                               | [Example](./incoming/text-html.md)                |
| text/html             | plain            | multipart/alternative<br>- text/html                                    | [Example](./incoming/text-html+plain.md)          |
| text/markdown         | -                | text/markdown                                                           | [Example](./incoming/text-markdown.md)            |
| text/markdown         | plain            | multipart/alternative<br>- text/markdown<br>- text/plain                | [Example](./incoming/text-markdown+plain.md)      |
| text/markdown         | html             | multipart/alternative<br>- text/markdown<br>- text/html                 | [Example](./incoming/text-markdown+html.md)       |
| text/markdown         | plain, html      | multipart/alternative<br>- text/markdown<br>- text/plain<br>- text/html | [Example](./incoming/text-markdown+plain+html.md) |

## Outgoing RichTexts

Outgoing RichTexts are how the RichText field's value is shown in the response body.

The following table is a matrix for the RichText field's content, and its different `richTextAs` values and their corresponding results.

| Content  | richTextAs | Result type     | Notes                                                          | Example                                                                                                                                                                                                             |
|----------|------------|-----------------|----------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| RichText | mime       | multipart/mixed |                                                                | [Example](./outgoing/richtext-mime.md)                                                                                                                                                                              |
| RichText | html       | text/html       |                                                                | [Example](./outgoing/richtext-html.md)                                                                                                                                                                              |
| RichText | plain      | text/plain      |                                                                | [Example](./outgoing/richtext-plain.md)                                                                                                                                                                             |
| RichText | markdown   | text/markdown   |                                                                | [Example](./outgoing/richtext-markdown.md)                                                                                                                                                                          |
| MIME     | mime       | multipart/mixed |                                                                | [Example 1](./outgoing/mime-mime-1.md)<br>[Example 2](./outgoing/mime-mime-2.md)                                                                                                                                    |
| MIME     | html       | text/html       | Fallbacks:<br>- text/markdown -> html                          | [Example 1](./outgoing/mime-html-1.md)<br>[Example 2](./outgoing/mime-html-2.md)<br>[Example 3](./outgoing/mime-html-3.md)<br>[Example 4](./outgoing/mime-html-4.md)                                                |
| MIME     | markdown   | text/markdown   | Fallbacks:<br>- text/html -> markdown                          | [Example 1](./outgoing/mime-markdown-1.md)<br>[Example 2](./outgoing/mime-markdown-2.md)<br>[Example 3](./outgoing/mime-markdown-3.md)<br>[Example 4](./outgoing/mime-markdown-4.md)                                |
| MIME     | plain      | text/plain      | Fallbacks:<br>- text/html -> plain<br>- text/markdown -> plain | [Example 1](./outgoing/mime-plain-1.md)<br>[Example 2](./outgoing/mime-plain-2.md)<br>[Example 3](./outgoing/mime-plain-3.md)<br>[Example 4](./outgoing/mime-plain-4.md)<br>[Example 5](./outgoing/mime-plain-5.md) |
