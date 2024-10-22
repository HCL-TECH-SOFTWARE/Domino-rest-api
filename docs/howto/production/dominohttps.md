# Enable HTTPS using the Domino Certificate Manager

!!!note
    This feature is only available starting from the Domino REST API v1.1.0 release. 

Domino REST API can now enable HTTPS setup in Domino using Domino's certificate configuration.

## About this task 

The procedure guides you on how Domino REST API can enable HTTPS setup in Domino using Domino's certificate configuration.

## Prerequisite

For Domino REST API to enable HTTPS setup in Domino using Domino's certificate configuration, the following conditions must be met:

- Certs are stored using the Domino Certificate Manager. 
            
    !!!note
        The `certsrv` method is not supported.
            
- An entry matching the Domino FQDN exists. 

For more information about Domino Certificate Manager, see [Managing TLS certificates with Certificate Manager](https://help.hcl-software.com/domino/14.0.0/admin/secu_le_using_certificate_manager.html?hl=certificate%2Cmanager).

## Procedure

1. Create or update a JSON file in the `{notesdata}/keepconfig.d` directory with the following configuration:

    ```json
    {
        "TLSCertStore" : true
    }
    ```
    
2. Restart Domino REST API on all servers with this new configuration.

For more information on creating or updating a JSON file, see [Modify configuration of Domino REST API](../install/modifyconfig.md). 
