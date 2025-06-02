# Secure ports

Domino REST API uses four ports which have different purposes and warrant different access/security settings. By dividing Domino REST API access across more than one port, an administrator can take advantage of access security provided by the operating system and/or firewall.

|Port|Description|
|:---|:---|
|Data port (8880)|Main port used by the Domino REST API. Default authentication uses the user name and Internet password of the person document.|
|Healthcheck port (8886)|Used to verify whether Domino REST API is up using the `/health` endpoint. It has its own functional account that doesn't provide access to other ports.|
|Management port (8889)|Provides access to the Domino REST API runtime behavior, such as current configuration, runtime information, or Domino REST API shutdown and restart. It's recommended that the port be blocked and accessed only from localhost. It has its own functional account that doesn't provide access to other ports.|
|Prometheus metrics	port (8890)|Provides metrics in Prometheus format. It has its own functional account that doesn't provide access to other ports.|

## About this task

The procedure guides you in securing the ports to encrypt the communication between any client and the Domino REST API server in a production environment. You can do this by performing any of the following procedures:

- [Configure the ports for TLS](#configure-the-ports-for-tls)
- [Enable HTTPS using Domino Certificate Manager](#enable-https-using-domino-certificate-manager)

## Configure the ports for TLS

1. Obtain a certificate.

    For HTTPS traffic, JKS, PEM, and PFX certificate formats are supported.

    Get a valid certificate by:

    - Using [Let's Encrypt](https://letsencrypt.org/) with either [Domino cert manager](https://help.hcl-software.com/domino/14.0.0/admin/secu_le_using_certificate_manager.html) or a proxy, such as [nginx](../../../howto/web/index.md).

    - Ask your infrastructure, security, or networking team (if you have one) for a valid certificate.

2. Copy the certificate to your preferred location local to the Domino server where Domino REST API is installed.
3. On the Domino server where Domino RESR API is installed, create a JSON file in the keepconfig.d directory containing the following information:

    - Use the following to configure TLS for JKS or PFX. make sure to set `TLSType` to the correct type.

    ```json
    {
    "TLSFile": "path.to.file",
    "TLSPassword": "password-in-clear-protect-this",
    "TLSType": "pfx"
    }
    ```

    Example:

    ```json
    {
    "TLSFile": "c:/domino/data/go.pfx",
    "TLSPassword": "P@$$w0rd1352",
    "TLSType": "pfx"
    }
    ```

    - Use the following to configure TLS for PEM.

    ```json
    {
    "TLSFile": "path.to.file",
    "PEMCert": "path.to.crt.file",
    "TLSType": "pem"
    }
    ```

    !!! note

        - `TLSfile` must point to private key, while the `PEMCert` must point to the certificate chain. 
        - If you won't define a password, you must set the value of `TLSPassword` to `""`.

4. Open `notes.ini` with a text editor and update the value of `KeepManagementURL` to start with `https://` followed by the server's host name the TLS certificate is issued for.

    Example:

    When the server's host name the TLS certificate is issued for is `domino.demo.com`, the new value of `KeepManagementURL` is `https://domino.demo.com:8889`. In case `KeepManagementURL` is missing from notes.ini, add it with the new value.

5. On the Domino console, issue `tell restapi reload` to restart Domino REST API with the new configuration.

## Enable HTTPS using Domino Certificate Manager

If you are using Domino 14 or above and your certificates are stored in the Domino Certificate Manager, you may be able to enable HTTPS automatically. For more information, see [Enable HTTPS using the Domino Certificate Manager](../../../howto/production/dominohttps.md).

## Additional information

To make all ports accessible on Port 443, you can use an HTTPS proxy server (Ingress on Kubernetes). Check the links for more information:

- [Proxy using multiple sub-domains](../../../howto/web/httpsproxy.md)

- [Proxy using URL path access](../../../howto/web/httpsproxy2.md)

## Next step

Proceed to [Set up functional accounts](setupfunctionalaccount.md).
