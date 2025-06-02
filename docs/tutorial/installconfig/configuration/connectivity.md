# Check connectivity

Once Domino REST API is up and running, check that communication works as expected. In this check, the following names are going to be used as examples:

- Fully qualified domain name ([FQDN](https://en.wikipedia.org/wiki/Fully_qualified_domain_name)): `domino.acme.com`
- Domino server fully qualified name: `CN=tango/OU=servers/O=ACME Inc`
- Domino server common name: `tango`

**Replace these names with the ones matching your installation**.

!!! note

    Avoid `localhost` or any `*.local` domain names. They don't route.

## Basic check - PING

Run the following commands on the command line on your server:

```bash
ping domino.acme.com
ping tango
```

Both commands need to succeed in reaching out to any or both `127.0.0.1` and `::1`. If any of these doesn't work, amend your hosts file:

```bash
127.0.0.1     domino.acme.com
127.0.0.1     tango
::1           domino.acme.com
::1           tango
```

On Linux or macOS, edit `/etc/hosts`. On Windows, edit `C:\Windows\System32\drivers\etc\hosts`.

## HTTP connectivity

`http` is going to be used in the following examples.

!!! note

    If you have configured `https`, and you should, use that. Also, you might not need port `8880` when you opted for [a proxy configuration](../../../howto/web/httpsproxy.md). You can [learn more about ports here](../../../topicguides/configuringPorts.md).

### Client access

On any machine that wants to use the Domino REST API, use the following command. It needs to succeed.

```bash
curl -v http://domino.acme.com:8880/api
```

Try the following commands, which **MUST fail** with "connection denied" by your firewall.

```bash
curl -v http://domino.acme.com:8880/metrics
curl -v http://domino.acme.com:8889/
curl -v http://domino.acme.com:8886/
```

If you get an HTTP 4xx status, it means the port is reachable, which is a security hole. Close it and talk to your firewall admins.

### Privileged access

Allow access, by firewall rule or [ssh tunnel](https://www.ssh.com/academy/ssh/tunneling-example), for the following ports:

- Port 8889

    The management port allows access to the Management console, which enables creating certs for JWT, salting & encoding passwords, and reviewing the actual configuration. Allow access to trained administrators from a secure network only.

- Port 8886

    The Healthcheck port is typically used in Kubernetes environments. Only the server running system management and monitoring should have access.

- Port 8890

    Port allowing collection of metrics data in [Prometheus](https://prometheus.io/) format. Only the Prometheus server should have access. Used for dashboards with [Grafana](https://grafana.com/).

## Next step

Proceed to [Secure ports](secureport.md).

<!--
# Check connectivity

Once your REST API is up and running, check that communication works as expeceted. We will use the following name in this page:

- Fully qualified domain name ([FQDN](https://en.wikipedia.org/wiki/Fully_qualified_domain_name)): `domino.acme.com`

- Domino server fully qualified name: `CN=tango/OU=servers/O=ACME Inc`
- Domino server common name: `tango`

Replace these names with the ones matching your installation.

!!! note "localhost and .local"

    If you want to save yourself some trouble, avoid `localhost` or any `*.local`
    domain names. They don't route.

## Basic check - PING

Run this on a command line on your server:

```bash
ping domino.acme.com
ping tango
```

Both commands need to succeed in reaching out to `127.0.0.1` and/or `::1`. If any of these doesn't work, amend your hosts file:

```bash
127.0.0.1     domino.acme.com
127.0.0.1     tango
::1           domino.acme.com
::1           tango
```

On Linux or macOS, edit `/etc/hosts`, on Windows edit `C:\Windows\System32\drivers\etc\hosts`

## HTTP connectivity

We will use `http` in the following examples, when you have configured `https` (and you should), use that. Also you might not need port `8880` when you opted for [a proxy configuration](../../howto/web/httpsproxy.md). You can [learn more about ports here](../installconfig/configuringPorts.md).

### Client access

On any machine that wants to use the Domino REST API use this command, it needs to succeed:

```bash
curl -v http://domino.acme.com:8880/api
```

Try the following ones and they **MUST fail** with "connection denied" by your firewall

```bash
curl -v http://domino.acme.com:8880/metrics
curl -v http://domino.acme.com:8889/
curl -v http://domino.acme.com:8886/
```

If you get a HTTP 4xx status, it means the port is reachable, which is a security hole, close it. Speak to your firewall admins

### Privileged access

Allow access, by firewall rule or [ssh tunnel](https://www.ssh.com/academy/ssh/tunneling-example) for specific use:

- Port 8889 - Management console: create certs for JWT, salt & encode passwords, review the actual configuration - trained admins from a secure network only
- Port 8886 - Health check: Typically used in Kubernetes environments. Only the server running system mangment/monitoring should have access

- Port 8890 - Metrics data in [Prometheus](https://prometheus.io/) format. Thus only the Prometheus server should have access. Used for dashboards with e.g. [Grafana](https://grafana.com/)

## Let's connect

"feedback.md"

-->