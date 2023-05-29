|Parameter|Description|
|:----|:----|
|PORT: 8880|HTTP(S) port for the Domino REST API service.|
|METRICSPORT: 8890|Endpoint for [Prometheus](https://prometheus.io/) Metrics.|
|JwtDuration|Lifetime in minutes for the internal JWT provider. Default value is 60 mins.|
|maxJwtDuration|Maximum lifetime in minutes that the JWT tokens get accepted.|
|TLSFile|TLS file with key for jks, pem or pfx.|
|TLSPassword|Password for jks and pfx key file.|
|shutdownkey|Passphrase for posting to http://localhost:adminport/shutdown to shut down Domino REST API.|
|HEALTHCHECK_USER|Username for accessing Health check (Port 8886)|
|HEALTHCHECK_PASSWORD|Password for accessing Health check (Port 8886)|

