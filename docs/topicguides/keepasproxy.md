# Domino REST API and Proxy

![Ports in use](../assets/images/PortUse.png)

We use separate ports so you can individually use a proxy and/or a firewall to open up access to sensitive information or not. You can have a proxy on the same machine, you can have a proxy on a different machine, or you can use your firewall as a proxy.

The use of [**nginx as a proxy**](../howto/web/index.md) is provided as an example, but Domino REST API works with any type of proxy or ingress controller.
