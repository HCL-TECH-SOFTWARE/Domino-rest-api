## Example of private key and a self-signed certificate using openSSL

Bash commands for:

- Generating a private key

    ```bash
    openssl genpkey -algorithm RSA -out server-key.pem
    ```

- Generating a certificate signing request (CSR)

    ```bash
    openssl req -new -key server-key.pem -out server.csr
    ```

- Self-signing the certificate

    ```bash
    openssl x509 -req -days 365 -in server.csr -signkey server-key.pem -out server-cert.pem
    ```

- Generating a CA certificate

    ```bash
    openssl req -new -x509 -days 365 -key server-key.pem -out ca-cert.pem
    ```

The TLS configuration for PEM would look like this:

```json
{
  "TLSFile": “server-key.pem”,
  "PEMCert": “server-cert.pem”,
  "TLSType": "pem"
}
```
