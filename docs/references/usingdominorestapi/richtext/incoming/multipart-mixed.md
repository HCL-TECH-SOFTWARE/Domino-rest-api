# Incoming multipart/mixed Example

Let's say we want to save the following `multipart/mixed` MIME in a richtext field:

```text
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="XXXXboundary text"

This is a multipart message in MIME format.

--XXXXboundary text
Content-Type: text/plain

this is the body text

--XXXXboundary text
Content-Type: text/plain;
Content-Disposition: attachment;
        filename="test.txt"

this is the attachment text

--XXXXboundary text--
```

We first convert it to `BASE64` encoding and use that as the `content` in the following RichText JSON:

```json
{
  "type": "multipart/mixed",
  "encoding": "BASE64",
  "content": "TUlNRS1WZXJzaW9uOiAxLjANCkNvbnRlbnQtVHlwZTogbXVsdGlwYXJ0L21peGVkOw0KICAgICAgICBib3VuZGFyeT0iWFhYWGJvdW5kYXJ5IHRleHQiDQoNClRoaXMgaXMgYSBtdWx0aXBhcnQgbWVzc2FnZSBpbiBNSU1FIGZvcm1hdC4NCg0KLS1YWFhYYm91bmRhcnkgdGV4dA0KQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluDQoNCnRoaXMgaXMgdGhlIGJvZHkgdGV4dA0KDQotLVhYWFhib3VuZGFyeSB0ZXh0DQpDb250ZW50LVR5cGU6IHRleHQvcGxhaW47DQpDb250ZW50LURpc3Bvc2l0aW9uOiBhdHRhY2htZW50Ow0KICAgICAgICBmaWxlbmFtZT0idGVzdC50eHQiDQoNCnRoaXMgaXMgdGhlIGF0dGFjaG1lbnQgdGV4dA0KDQotLVhYWFhib3VuZGFyeSB0ZXh0LS0="
}
```

Using the mentioned RichText JSON, it will then save the following MIME:

```text
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="XXXXboundary text"

This is a multipart message in MIME format.

--XXXXboundary text
Content-Type: text/plain

this is the body text

--XXXXboundary text
Content-Type: text/plain;
Content-Disposition: attachment;
        filename="test.txt"

this is the attachment text

--XXXXboundary text--
```

The saved MIME is the `1:1` version of the MIME we want to save.
