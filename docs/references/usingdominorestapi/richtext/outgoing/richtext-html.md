# Exaple: Outgoing Rich Text content as HTML

Let's say you want to retrieve the following Rich Text content as HTML:

![Example Rich Text content](../../../../assets/images/ExampleRichtextContent.png)

Set the value of `richTextAs` query parameter to `html`, and retrieve the document that contains it.

You should get the following in the `richtext` field response:

```json
{
  "type": "text/html",
  "encoding": "PLAIN",
  "content": "<span style=\"font-family: monospace ; font-size: 10pt ; font-weight: bold ; color: #000000 ; \">I</span><span style=\"font-family: monospace ; font-size: 10pt ; font-weight: bold ; color: #000000 ; \">&nbsp;</span><span style=\"font-family: monospace ; font-size: 10pt ; font-weight: bold ; color: #000000 ; \">AM OVERWRITING THIS!</span><br />\r\n<span style=\"font-family: monospace ; font-size: 10pt ; font-style: italic ; color: #FF0000 ; \">Can't do anything about it :P</span><br />\r\n<span style=\"font-family: monospace ; font-size: 10pt ; text-decoration: underline ; \">You have no power here...</span>"
}
```
