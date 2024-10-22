# HTTPS for production

Best practice for any REST API access is to secure the connection using TLS (colloquial, still referred to as SSL). This applies to the Domino REST API too. In general you have two options:

## Use a Reverse Proxy

Terminate your TLS connection at a proxy. When the proxy runs on the same "machine", this is a common and accepted practice. We have [outlined the steps using nginx](../../howto/web/httpsproxy.md) as reference.

## Enable HTTPS using the Domino Certificate Manager

If you are using Domino 14 or above and your certificates are stored in the Domino Certificate Manager, you may be able to enable HTTPS automatically. For more information, see [Enable HTTPS using the Domino Certificate Manager](../production/dominohttps.md).

To learn more about Domino Certificate Manager, see [Managing TLS certificates with Certificate Manager](https://help.hcl-software.com/domino/14.0.0/admin/secu_le_using_certificate_manager.html?hl=certificate%2Cmanager).

## Use a TLS Certificate

The REST API can directly use TLS and is HTTP 1.1 and HTTP/2 compliant. You would obtain a TLS certificate from your IT security team or your favorite supplier (We like [LetsEncypt](https://letsencrypt.org), it's free) and set the configuration parameters in a json file.

--8<-- "tlssettings.md"

--8<-- "tlssettings1.md"

Read the details here: [configure certificate](../../howto/IdP/configuringCertificates.md).

--8<-- "keepmngtURLcaution1.md"
