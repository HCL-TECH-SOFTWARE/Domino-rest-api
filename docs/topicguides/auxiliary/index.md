# Auxiliary services

While the main purpose of a REST API is serving data (mostly JSON) over https, any complete system comes with a range of auxiliary services. The HCL Domino REST API is no exception. Here is what we got:

## [Identity Provider (IdP)](idp.md)

DRAPI has a dual use function. It can **be** your [OICD](#) compliant Identity Provider **and** is can be configured to accept users authenticated with an external IdP like [Keycloak](#), [Okta](#) or [Microsoft Entra ID](#) (the system formerly known as Azure Active Directory).

## [webDAV](webdav.md)

DRAPI implements the [webDAV](#) HTTP extensions to facilitate the [Office Round trip experience](#)

## [ODATA](odata.md)

[ODATA](https://www.odata.org/) is the love child of SAP and Microsoft. It allows compliant software (like MS-Excel on Windows, Salesforce, PowerBI etc.) to read and potentially write REST data.

## [iCal](ical.md)

iCal allows to read and write calendar information and is part of the fixed [PIM Schema](#)

## [Health & metrics](healthmetrics.md)

Cloud and Kubernetes compatible health monitoring and system metrics in [Prometheus](#) format

## [Management console](management.md)

System functions using a proteded port and a functional account.

## Let's connect

--8<-- "feedback.md"
