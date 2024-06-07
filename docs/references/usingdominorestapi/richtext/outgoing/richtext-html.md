# Outgoing RichText Content as HTML Example

Let's say we want to retrieve the following RichText content as HTML:

![Example RichText content](../../../../assets/images/ExampleRichtextContent.png)

We then set the value of `richTextAs` query parameter to `html`, and retrieve the document that contains it.

We should get the following in the RichText field response:

```json
{
  "type": "text/html",
  "encoding": "PLAIN",
  "content": "<span style=\"font-family: monospace ; font-size: 10pt ; font-weight: bold ; color: #000000 ; \">I</span><span style=\"font-family: monospace ; font-size: 10pt ; font-weight: bold ; color: #000000 ; \">&nbsp;</span><span style=\"font-family: monospace ; font-size: 10pt ; font-weight: bold ; color: #000000 ; \">AM OVERWRITING THIS!</span><br />\r\n<span style=\"font-family: monospace ; font-size: 10pt ; font-style: italic ; color: #FF0000 ; \">Can't do anything about it :P</span><br />\r\n<span style=\"font-family: monospace ; font-size: 10pt ; text-decoration: underline ; \">You have no power here...</span>"
}
```
