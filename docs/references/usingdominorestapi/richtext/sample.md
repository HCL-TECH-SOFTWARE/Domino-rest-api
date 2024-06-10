# Rich Text

## Incoming

| Submitted             | Switch        | Stored                                                                  | ?   |
| --------------------- | ------------- | ----------------------------------------------------------------------- | --- |
| multipart/mixed       | -             | multipart/mixed                                                         |
| multipart/alternative | -             | multipart/alternative                                                   |
| text/plain            | -             | text/plain                                                              | ?   |
| text/html             | -             | text/html                                                               |
| text/html             | [plain]       | multipart/alternative<br />text/html<br />text/plain                    |
| text/markdown         | -             | text/markdown                                                           |
| text/markdown         | [html]        | multipart/alternative<br />text/html<br />text/markdown                 |
| text/markdown         | [plain]       | multipart/alternative<br />text/plain<br />text/markdown                |
| text/markdown         | [html, plain] | multipart/alternative<br />text/html<br />text/markdown<br />text/plain |

## Retrieve

| Content  | RichTextAs= | Result          | How                                                                             |
| -------- | ----------- | --------------- | ------------------------------------------------------------------------------- |
| Rich Text | mime        | multipart/mixed | 1:1                                                                             |
| Rich Text | html        | text/html       | toMime                                                                          |
| Rich Text | plain       | text/plain      | extractText call                                                                |
| Rich Text | markdown    | text/markdown   | toMime -> MD conversion                                                         |
| mime     | mime        | multipart/mixed | 1:1                                                                             |
| mime     | html        | text/html       | extract text/html, fallback text/markdown -> flexmark                           |
| mime     | plain       | text/plain      | extract text/plain, fallback text/html -> JSoup fallback extract md -> Flexmark |
| mime     | markdown    | text/markdown   | extract text/markdown fallback text/html -> flexmark                            |
