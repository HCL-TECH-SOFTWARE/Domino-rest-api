# Create a Subject Alternate Name (SAN)

The idea of the SAN is to allow the recognition of name variations for a given certificate, thus reducing the effort for multi-purpose servers. In case you receive an error message indicating a missing SAN even after importing the `ca-chain.cert.pem` into your keyring/keystore

## About this task

The procedure guides you in creating a SAN to address any issue relating to a missing SAN even after importing the `ca-chain.cert.pem` into your keyring/keystore.

## Procedure

1.	Edit `intermediate\openssl.cnf` by adding `subjectAltName = @alt_names` to the `[server_cert]` section.

    The `@` sign tells OpenSSL to look for a section with that name and expand its content as the 
    parameter.

2.	Execute the following shell script to generate a certificate. 

    ```bash

    #!/bin/bash
    # Create new server certificates with the KEEP intermediate CA
    if [ -z "$1" ]
      then
        echo "Usage: ./makecert.sh domain_name (without www) e.g. ./makecert.sh funsite.com"
        exit 1
    fi
    export SSL_DOMAIN_NAME=$1
    export CONFNAME=intermediate/$1.cnf
    cat intermediate/openssl.cnf > $CONFNAME
    echo [alt_names] >> $CONFNAME
    echo DNS.0 = $SSL_DOMAIN_NAME >> $CONFNAME
    echo DNS.1 = www.$SSL_DOMAIN_NAME  >> $CONFNAME
    echo DNS.2 = $SSL_DOMAIN_NAME.local  >> $CONFNAME
    openssl ecparam -genkey -name prime256v1 -outform PEM -out intermediate/private/$SSL_DOMAIN_NAME.key.pem
    chmod 400 intermediate/private/$SSL_DOMAIN_NAME.key.pem
    openssl req  -config $CONFNAME  -key intermediate/private/$SSL_DOMAIN_NAME.key.pem -new -sha256 -out intermediate/csr/$SSL_DOMAIN_NAME.csr.pem
    openssl ca -config $CONFNAME -extensions server_cert -days 375 -notext -md sha256 -in intermediate/csr/$SSL_DOMAIN_NAME.csr.pem -out intermediate/certs/$SSL_DOMAIN_NAME.cert.pem
    chmod 444 intermediate/certs/$SSL_DOMAIN_NAME.cert.pem
    openssl pkcs12 -export -in intermediate/certs/$SSL_DOMAIN_NAME.cert.pem -inkey intermediate/private/$SSL_DOMAIN_NAME.key.pem -out intermediate/private/$SSL_DOMAIN_NAME.pfx -certfile intermediate/certs/ca-chain.cert.pem
    rm $CONFNAME

    ```

The generated certificate works for:

- `www.domain` (for example, `www.awesome.io`)
- `domain` (for example, `awesome.io`)
- `domain.local` (for example, `awesome.io.local`)
