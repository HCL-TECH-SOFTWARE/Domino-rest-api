---
hide:
  - toc
---

# Auxiliary services

While the main purpose of a REST API is serving data, mostly JSON, over https, any complete system comes with a range of auxiliary services. The HCL Domino REST API is no exception. Check the details. 

## [Identity Provider (IdP)](idp.md)

The Domino REST API serves a dual function. It can act as your own [OIDC](../../references/security/authentication.md#oidc)-compliant Identity Provider, and it can be configured to accept authentication from external Identity Providers such as [Keycloak](../../howto/IdP/configuringKeycloak.md), Okta, or [Microsoft Entra ID](../../howto/IdP/configuringAD.md) (formerly Azure Active Directory).

## [webDAV](webdav.md)

Domiro REST API implements the [webDAV](../../references/openapidefinitions.md#webdav) HTTP extensions to facilitate the [Office Round Trip Experience](../../howto/production/roundtrip.md).

## [OData](odata.md)

[OData](https://www.odata.org/) or *Open Data Protocol* allows compliant software, for example Excel on Windows, Salesforce, Power BI, to read and potentially write REST data.

## [iCal](ical.md)

iCal allows reading and writing calendar information and is part of the fixed [PIM Schema](../../references/openapidefinitions.md#pim).

## [Health & metrics](healthmetrics.md)

Cloud and Kubernetes compatible health monitoring and system metrics in [Prometheus](https://prometheus.io/) format.

## [Management console](management.md)

System functions using a protected port and a functional account.
