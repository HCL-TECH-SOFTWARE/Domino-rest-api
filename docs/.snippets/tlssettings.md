<!--To configure a certificate for HTTPS-->

- Use the following entry to configure TLS (JKS, PEM, PFX -> Pick one):

```json
{
  "TLSFile": "path.to.file",
  "TLSPassword": "password-in-clear-protect-this",
  "TLSType": "pfx"
}
```

- **JKS**: The [Java Key Store](https://en.wikipedia.org/wiki/Java_KeyStore). Only used by Java, follow the [JKS documentation](https://docs.oracle.com/cd/E19509-01/820-3503/ggfen/index.html)
- **PEM**: defined in [RFC 1422](https://www.rfc-editor.org/rfc/rfc1422), commonly used in http server
- **PFX**: defined in [RFC 7292](https://www.rfc-editor.org/rfc/rfc7292), the RSA provided Public-Key Cryptography Standards

<!-- prettier-ignore -->
!!! tip
    It's your choice which key you want to use. Main considerations are the assessment of your security team and the ease of acquisition of a specific key format in your organization.