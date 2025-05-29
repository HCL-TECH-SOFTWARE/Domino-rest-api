<!--To configure a certificate for HTTPS-->

Use the following entry to configure TLS for jks or pfx (set TLSType to the correct type): 

```json
{
  "TLSFile": "path.to.file",
  "TLSPassword": "password-in-clear-protect-this",
  "TLSType": "pfx"
}
```
Use the following to configure TLS for pem:

```json
{
  "TLSFile": "path.to.file",
  "PEMCert": "path.to.crt.file",
  "TLSType": "pem"
}
```
<!-- prettier-ignore -->
!!!note
    - `TLSfile` must point to private key, while the `PEMCert` must point to the certificate chain. 
    - If you won't define a password, you must set the value of `TLSPassword` to `""`.

- **JKS**: The [Java Key Store](https://en.wikipedia.org/wiki/Java_KeyStore). Only used by Java, follow the [JKS documentation](https://docs.oracle.com/cd/E19509-01/820-3503/ggfen/index.html)

- **PEM**: defined in [RFC 1422](https://www.rfc-editor.org/rfc/rfc1422), commonly used in http server

- **PFX**: defined in [RFC 7292](https://www.rfc-editor.org/rfc/rfc7292), the RSA provided Public-Key Cryptography Standards

<!-- prettier-ignore -->
!!! tip
    It's your choice which key you want to use. Main considerations are the assessment of your security team and the ease of acquisition of a specific key format in your organization.

<!--
## Example of private key and a self-signed certificate using openSSL:

### Bash code: 

#### Generate a private key
``` openssl genpkey -algorithm RSA -out server-key.pem ```

#### Generate a certificate signing request (CSR)
``` openssl req -new -key server-key.pem -out server.csr ```

#### Self-sign the certificate
``` openssl x509 -req -days 365 -in server.csr -signkey server-key.pem -out server-cert.pem ```

#### Generate CA certificate
``` openssl req -new -x509 -days 365 -key server-key.pem -out ca-cert.pem ```

The configuration for TLS for pem would look like:

```json
{
  "TLSFile": “server-key.pem”,
  "PEMCert": “server-cert.pem”,
  "TLSType": "pem"
}
```
-->