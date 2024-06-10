# Example: Incoming multipart/alternative 

Let's say you want to save the following `multipart/alternative` MIME in a `richtext` field:

```text
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="XXXXboundary text"

This is a multipart message in MIME format.

--XXXXboundary text
Content-Type: text/plain

this is the body text

--XXXXboundary text
Content-Type: text/html

<b>this is the body text</b>

--XXXXboundary text--
```

You first convert it to `BASE64` encoding and use that as the `content` in the following Rich Text JSON:

```json
{
  "type": "multipart/alternative",
  "encoding": "BASE64",
  "content": "TUlNRS1WZXJzaW9uOiAxLjANCkNvbnRlbnQtVHlwZTogbXVsdGlwYXJ0L2FsdGVybmF0aXZlOw0KICAgICAgICBib3VuZGFyeT0iWFhYWGJvdW5kYXJ5IHRleHQiDQoNClRoaXMgaXMgYSBtdWx0aXBhcnQgbWVzc2FnZSBpbiBNSU1FIGZvcm1hdC4NCg0KLS1YWFhYYm91bmRhcnkgdGV4dA0KQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluDQoNCnRoaXMgaXMgdGhlIGJvZHkgdGV4dA0KDQotLVhYWFhib3VuZGFyeSB0ZXh0DQpDb250ZW50LVR5cGU6IHRleHQvaHRtbA0KDQo8Yj50aGlzIGlzIHRoZSBib2R5IHRleHQ8L2I+DQoNCi0tWFhYWGJvdW5kYXJ5IHRleHQtLQ=="
}
```

Using the mentioned Rich Text JSON, it will then save the following MIME:

```text
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="XXXXboundary text"

This is a multipart message in MIME format.

--XXXXboundary text
Content-Type: text/plain

this is the body text

--XXXXboundary text
Content-Type: text/html

<b>this is the body text</b>

--XXXXboundary text--
```

The saved MIME is the `1:1` version of the MIME you want to save.
