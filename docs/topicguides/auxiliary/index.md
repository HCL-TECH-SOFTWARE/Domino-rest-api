# Auxiliary services

While the main purpose of a REST API is serving data, mostly JSON, over https, any complete system comes with a range of auxiliary services. The HCL Domino REST API is no exception. Check the details. <!--Here is what we got:-->

## [Identity Provider (IdP)](idp.md)

Domino REST API has a dual-use function. It can **be** your [OICD](../../references/security/authentication.md#oidc) compliant Identity Provider **and** it can be configured to accept users authenticated with an external IdP like [Keycloak](../../howto/IdP/configuringKeycloak.md), Okta, or [Microsoft Entra ID](../../howto/IdP/configuringAD.md) formerly Azure Active Directory.

## [webDAV](webdav.md)

Domiro REST API implements the [webDAV](../../references/openapidefinitions.md#webdav) HTTP extensions to facilitate the [Office Round Trip Experience](../../howto/production/roundtrip.md).

## [OData](odata.md)

[OData](https://www.odata.org/) or *Open Data Protocol* <!--is the love child of SAP and Microsoft. It--> allows compliant software, for example Excel on Windows, Salesforce, Power BI, to read and potentially write REST data.

## [iCal](ical.md)

iCal allows to read and write calendar information and is part of the fixed [PIM Schema](../../references/openapidefinitions.md#pim).

## [Health & metrics](healthmetrics.md)

Cloud and Kubernetes compatible health monitoring and system metrics in [Prometheus](https://prometheus.io/) format.

## [Management console](management.md)

System functions using a protected port and a functional account.

<!--## Let's connect

"feedback.md"-->
