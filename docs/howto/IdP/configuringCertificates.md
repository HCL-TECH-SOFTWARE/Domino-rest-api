# Configure certificates

## About this task

The procedures guide you on obtaining and configuring certificates.

Domino REST API uses certificates for:

- signing JWT Tokens when you use Domino REST API's login API - 0..1 certificate
- validating JWT Tokens issued by trusted Identity Providers (IdP) - 0..n certificates
- Securing HTTPs traffic - 0..1 certificate

## Obtain certificates

For HTTPS traffic, JKS, PEM, and PFX certificate formats are supported. For public and private key pairs, RSA and EC are supported. HTTPS certificates must be accepted by your browser and HTTP tool, so get valid certificates.

To get valid certificates, use any of the following approaches:

- Use [Let's Encrypt](https://letsencrypt.org/) with either [Domino cert manager](https://help.hcl-software.com/domino/14.0.0/admin/secu_le_using_certificate_manager.html) or a proxy, such as [nginx](../web/index.md).

- Ask your infrastructure, security or networking team (if you have one) for valid certificates.

- <!--Wanting the first two options,-->On your own risk: Create your [own certificates using OpenSSL](https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309).

!!! note

    If you decided to create your own certificates, you need to distribute the custom root CA to your users which isn't something you want to do unless you have tooling like [Bigfix](https://www.hcltechsw.com/bigfix) in place. Better stick to official certs

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
    The JSON file is automatically created when you [use the Domino REST API management API (Port 8889)](../../references/security/encryption.md) to create the files.

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
    "my-idp": {
      "active": true,
      "algorithm": "RS256",
      "keyFile": "10-jwt.pubkey"
    }
  }
}
```

## Configure a certificate for HTTPS

When configuring TLS, you can use JSON values or [environment variables](../../references/configuration/parameters.md#environment). You can use either of the two. When using both, the environment variable will take priority.

--8<-- "tlssettings.md"

### Enabling HTTPS using Domino Certificate Manager

If you are using Domino 14 or above and your certificates are stored in the Domino Certificate Manager, you may be able to enable HTTPS automatically. For more information, see [Enable HTTPS using the Domino Certificate Manager](../production/dominohttps.md).

To learn more about Domino Certificate Manager, see [Managing TLS certificates with Certificate Manager](https://help.hcl-software.com/domino/14.0.0/admin/secu_le_using_certificate_manager.html?hl=certificate%2Cmanager).

--8<-- "tlssettings1.md"
