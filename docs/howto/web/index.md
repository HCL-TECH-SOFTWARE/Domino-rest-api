# Web configuration

--8<-- "future.md"

The Domino REST API operates on separate ports, enabling you to manage access to sensitive information through a proxy, a firewall, or both. You can configure a proxy on the same machine, on a different machine, or utilize your firewall as a proxy.

![Ports in use](../../assets/images/PortUse.png){: style="height:60%;width:60%"}

The example procedures provided below guide you in using **nginx** as a proxy, but take note that the Domino REST API is compatible with any type of proxy.

<!--Topics to guide you in completing web configuration goals and tasks related to Domino REST API:-->

- [Configure nginx as HTTPS proxy with subdomains](httpsproxy.md)

- [Configure nginx as HTTPS proxy - single domain](httpsproxy2.md)