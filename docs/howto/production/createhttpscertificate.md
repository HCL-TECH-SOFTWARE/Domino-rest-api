# Create HTTPs certificates for Domino REST API port

## About this task

The procedure guides you in creating your own certificate authority to securely run Domino REST API with encryption in a production environment.

## Procedure

1. Create a private key and root certificate.

    1. Setup a directory structure by executing the following commands:

        ```bash

        mkdir -pv -m 600 /root/ca/intermediate
        cd /root/ca
        curl https://jamielinux.com/docs/openssl-certificate-authority/_downloads/root-config.txt -o openssl.cnf
        curl https://jamielinux.com/docs/openssl-certificate-authority/_downloads/intermediate-config.txt -o intermediate/openssl.cnf
        mkdir certs crl newcerts private
        chmod 700 private
        touch index.txt
        echo 1000 > serial
        cd intermediate
        mkdir certs crl csr newcerts private
        chmod 700 private
        touch index.txt
        echo 1000 > serial
        echo 1000 > crlnumber
        cd ..

        ```
        !!! tip
            Check the downloaded files and change the path in case you chose to use a different one.

    2. 	Create a root certificate by executing following the commands:

        ```bash

        export OPENSSL_CONF=./openssl.cnf
        openssl ecparam -genkey -name prime256v1 -outform PEM | openssl ec -aes256 -out private/ca.key.pem
        chmod 400 private/ca.key.pem
        openssl req -config openssl.cnf -key private/ca.key.pem -new -x509 -days 7300 -SHA384 -extensions v3_ca -out certs/ca.cert.pem

        ```
        !!! tip
            Check the file using `openssl x509 -noout -text -in certs/ca.cert.pem`. For macOS, just hit the space key in **Finder**.

2. Create an intermediate key and certificate.

    !!! tip
        Save the root keys and only use them for one or more intermediate certificates. This allows to delegate cert creation to multiple players and invalidate an intermediate certificate if needed.

    1. Execute the following commands:

        ```bash

        openssl ecparam -genkey -name prime256v1 -outform PEM | openssl ec -aes256 -out intermediate/private/intermediate.key.pem
        chmod 400 intermediate/private/intermediate.key.pem
        openssl req -config intermediate/openssl.cnf -new -SHA384 -key intermediate/private/intermediate.key.pem -out intermediate/csr/intermediate.csr.pem
        openssl ca -config openssl.cnf -extensions v3_intermediate_ca -days 3650 -notext -md sha256 -in intermediate/csr/intermediate.csr.pem -out intermediate/certs/intermediate.cert.pem
        chmod 444 intermediate/certs/intermediate.cert.pem
        openssl verify -CAfile certs/ca.cert.pem intermediate/certs/intermediate.cert.pem

        ```
    2. Create a certificate chain by executing the following commands:

        ```bash

        cat intermediate/certs/intermediate.cert.pem certs/ca.cert.pem > intermediate/certs/ca-chain.cert.pem
        chmod 444 intermediate/certs/ca-chain.cert.pem

        ```
        !!! note
            The certificate chain is the file you need to install in browsers or other key stores to avoid `unknown certificate` errors.

3. Create server certificates by executing the following commands:

    ```bash

    export SSL_DOMAIN_NAME=www.example.com
    openssl ecparam -genkey -name prime256v1 -outform PEM -out intermediate/private/$SSL_DOMAIN_NAME.key.pem
    chmod 400 intermediate/private/$SSL_DOMAIN_NAME.key.pem
    openssl req -config intermediate/openssl.cnf -key intermediate/private/$SSL_DOMAIN_NAME.key.pem -new -sha256 -out intermediate/csr/$SSL_DOMAIN_NAME.csr.pem
    openssl ca -config intermediate/openssl.cnf -extensions server_cert -days 375 -notext -md sha256 -in intermediate/csr/$SSL_DOMAIN_NAME.csr.pem -out intermediate/certs/$SSL_DOMAIN_NAME.cert.pem
    chmod 444 intermediate/certs/$SSL_DOMAIN_NAME.cert.pem

    ```
    !!! note
        You need 3 files on your server system:

        - `ca-chain.cert.pem`
	    - `www.example.com.key.pem`
	    - `www.example.com.cert.pem`

4. (Optional) Convert the files if necessary. For example, for import in Java Keystore JKS.
5. Make the public key of the root and intermediate certificates available, and import these certificates in all browsers and runtimes used for testing.


In case you receive an error message indicating a missing SAN even after importing the `ca-chain.cert.pem` into your keyring/keystore, see [Create a Subject Alternate Name (SAN)](createsan.md).



