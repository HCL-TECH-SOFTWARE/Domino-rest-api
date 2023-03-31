# HTTPS for Production

--8<-- "keepmngtURLcaution1.md"

## Procedure

* You are going to need to use a proxy in front, which is described in the [nginx documentation](../../howto/web/httpsproxy.md). 
* Obtain your https certificate. To obtain your certificate, go to the [configure certificate](../../howto/IdP/configuringCertificates.md). 
  Ceate a `.json` file in `keepconfig.d`

 Use the following entry to configure TLS (JKS, PEM, PFX):

```json
{
  "TLSFile": "path.to.file",
  "TLSPassword": "password-in-clear-protect-this",
  "TLSType": "pfx"
}
```

<!-- prettier-ignore -->




