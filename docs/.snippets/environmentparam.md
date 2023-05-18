|Parameter|Description|
|:----|:----|
|PORT: 8880|HTTP(S) port for the Domino REST API service.|
|ADMINPORT: 8889|HTTP Port for the Admin listener. It shouldn't be reachable from outside.|
|METRICSPORT: 8890|Endpoint for [Prometheus](https://prometheus.io/) Metrics.|
|GodeMode: true/false|Should local users in KeepConfig be recognized.|
|JwtDuration|Lifetime in minutes for the internal JWT provider. Default value is 60 mins.|
|JwtMaxDuration|Maximum lifetime in minutes that the JWT tokens get accepted.|
|DEBUG: true/false|Debug mode. Creates more console output.|
|PEMCert|If your TLS is PEM format, such as LetsEncrypt, the path to the certificate file.|
|TLSFile|TLS file with key for jks, pem or pfx.|
|TLSPassword|Password for jks and pfx key file.|
|shutdownkey|Passphrase for posting to http://localhost:adminport/shutdown to shut down Domino REST API.|
|HEALTHCHECK_USER|Username for accessing Health check (Port 8886)|
|HEALTHCHECK_PASSWORD|Password for accessing Health check (Port 8886)|