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