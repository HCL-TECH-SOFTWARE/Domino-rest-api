<!-- prettier-ignore -->
!!! warning "Caution"

    The Domino server task communicates with the REST API through the `KeepManagementURL`. It has a default value of `http://localhost:8889`. You can overwrite this setting in the `notes.ini` by editing, or creating if missing, the entry `KeepManagementURL` (case sensitive). Having configured a TLS certificate, you need to make sure the entry starts with `https://` and uses the host name your TLS certificate has been issued for. `localhost`, `127.0.0.1` or `::1` won't work. Configuring TLS doesn't change the port. So when you host, your TLS certificate is issued for, is `domino.demo.com` and your old entry was missing or is the default of `http://localhost:8880`, then your new value needs to be: `https://domino.demo.com:8889`. 
    
    
    
<!--For more information, see [Domino REST API task](../../references/usingdominorestapi/restapitask.md) and [ports](../../howto/production/prodports.md).-->
