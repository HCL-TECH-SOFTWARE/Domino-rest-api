# How to configure certificates

--8<-- "keepmngtURLcaution1.md"

## About this task

The procedures guide you on obtaining and configuring certificates.

Domino REST API uses certificates for:

- signing JWT Tokens when you use Domino REST API's login API - 0..1 certificate
- validating JWT Tokens issued by trusted Identity Providers (IdP) - 0..n certificates
- Securing HTTPs traffic - 0..1 certificate

## Obtain certificates

For HTTPS traffic, JKS, PEM, and PTX certificate formats are supported. For public and private key pairs, RSA and EC are supported. HTTPS certificates must be accepted by your browser and HTTP tool, so get valid certificates.

To get valid certificates, use any of the following approaches:

- Use [Let's Encrypt](https://letsencrypt.org/) with either Domino's cert manager or a proxy, such as **Nginx**.
- Ask your infrastructure or networking team (if you have one) for valid certificates.
- <!--Wanting the first two options,-->Create your [own certificates using OpenSSL](https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309).

!!! note

    You need to distribute the custom root CA to your users (**Let's Encrypt** preferred).

- For public/private key generation (used for JWT), use the Domino REST API management API/UI and let it generate a public/private key file pair and a certificate.

## Configure a certificate for issuing a JWT

<!--To configure a certificate for issuing a JWT:-->

- Add the following JSON to a file in `keepconfig.d`. The extension must be `.json`.

```json
{
  "JwtUsePubPrivKey": true,
  "JwtUsePemFile": true,
  "JwtIssuer": "The issuer",
  "JwtPrivateKeyFile": "keepconfig.d/private.key.pem",
  "JwtPublicKeyFile": "keepconfig.d/public.key.pem",
  "JwtCertFile": "keepconfig.d/cert.pem",
  "JwtAlgorithm": "RSA"
}
```

<!-- prettier-ignore -->
!!! Info
    The JSON file is automatically created when you use the Domino REST API management API (Port 8889) to create the files.

## Configure certificates for JWT validation

<!-- prettier-ignore -->
!!! note
    PEM-formatted keys (RSA/EC) are supported.

<!--To configure certificates for JWT validation-->

1. Obtain the public key from your IdP provider.
2. Add the public key to a location where general users can't write to.
3. Add a JSON file with the following content to `keepconfig.d`.

```json
{
  "jwt": {
    "oicd": {
      "active": true,
      "algorithm": "RS256",
      "keyFile": "10-jwt.pubkey"
    }
  }
}
```

## Configure a certificate for HTTPS

<!--To configure a certificate for HTTPS-->

- Use the following entry to configure TLS (JKS, PEM, PFX):

```json
{
  "TLSFile": "path.to.file",
  "TLSPassword": "password-in-clear-protect-this",
  "TLSType": "pfx"
}
```

<!-- prettier-ignore -->
!!! tip
    It's recommended to use the Domino certificate option or a proxy for HTTPS termination.
