# Health & metrics

Cloud and Kubernetes compatible health monitoring and system metrics in [Prometheus](https://prometheus.io/) format.

## How it works

### Health

The operation of Domino REST API is checked via the Healthcheck port 8886. This enables any automated tooling that manages your containers to periodically check and automatically act if Domino REST API is no longer working. It's a standard approach for Docker and Kubernetes environments.

### Metrics

Metrics are exposed on their own dedicated port, **METRICSPORT** in the config. The default, if not set, is port 8890. Domino REST API supports metrics produced by MicroMeter in a Prometheus compatible format, pollable from the metrics port.

## Tutorials

- [Set up a functional account to access health and metrics ports](../../tutorial/installconfig/configuration/setupfunctionalaccount.md)

## How-to guide

- [Configure ports in production](../../howto/production/prodports.md)

## References

- [Metrics](../../references/usingdominorestapi/metrics.md)
- [Healthcheck Port (8886)](../configuringPorts.md#healthcheck-port-8886)
- [Port for Prometheus metrics (8890)](../configuringPorts.md#port-for-prometheus-metrics-8890)

## Let's connect

--8<-- "feedback.md"
