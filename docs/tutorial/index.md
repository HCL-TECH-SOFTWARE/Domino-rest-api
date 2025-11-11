---
hide:
  - toc
---

# Tutotials

The tutorials are designed to familiarize Domino REST API administrators, as well as Notes and web developers, with the features and usage of the Domino REST API.

## [Quickstart](quickstart.md)

Intended for users with experience working with HCL Notes and HCL Domino who want to quickly install, configure, and start using the Domino REST API.

## [Installation and configuration](installconfig/index.md)

Outlines the steps to install the Domino REST API and the necessary configuration tasks after installation to complete a production-ready deployment, ensuring full capability and a secure interface for your Domino applications.

## [Capability walkthrough](walkthrough/index.md)

Guides you step-by-step through using and configuring the Domino REST API, utilizing the command line, Postman, the Domino REST API Admin UI, and code examples.

## [Using Admin UI](adminui.md)

Provides simple, step-by-step instructions for using the **Admin UI** to set up and manage a Domino database. It guides you through preparing database access, logging in, creating schemas and scopes, configuring forms, views, and agents, and finally logging out from the **Admin UI**.

## [Using Postman and curl](postmancurl.md)

Guides you on using Domino REST API with Postman and curl.

## [Using Swagger UI](swagger.md)

Guides you through using the Swagger UI to visualize and interact with the Domino REST API endpoints.

## [OData tutorial](odata/index.md)

Demonstrates how to export data from Notes databases to [OData](https://www.odata.org) using Domino REST API.

## [Extensibility tutorial](extensibility/index.md)

Guides you through the creation of a custom URL endpoint that handles the approval and rejection of generic requests.

!!! note

    You need to be familiar with Java and Domino to follow the tutorial.

## More tutorials

Additional tutorials are available at the [HCL Domino REST API Tutorials page](https://opensource.hcltechsw.com/domino-keep-tutorials/index.html). For more information, see the tutorial descriptions below:

- [Domino ToDo Database tutorial](https://opensource.hcltechsw.com/domino-keep-tutorials/pages/todo/index)

    Intended for Notes and Domino developers. The tutorial walks you through:

    - Using the XPages ToDo Application.
    - Viewing the ACL via Domino REST API Postman APIs.
    - Configuring it for validated Domino REST API access.
    - Using OData to access data in Microsoft Excel [^1]. All steps are done via the Domino REST API Admin UI.

[^1]: Microsoft and Microsoft Excel are registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.

- [New Domino Database tutorial](https://opensource.hcltechsw.com/domino-keep-tutorials/pages/domino-new/index)

    Intended for web developers who are new to Domino. The tutorial walks you through:

    - Creating a new Domino database.
    - Adding forms for customers and contacts.
    - Adding views.
    - Configuring the database for validated REST API access.
    - Updating the access for the database. Some steps are done via the Domino REST API Admin UI, some via Postman.

<!--
# Tutorials


The tutorials intends to familiarize Domino REST API administrators and Notes or Web developers with the Domino REST API.

!!! note "Important"

    Before starting the tutorial, make sure that Domino REST API is installed and running. For more information, see [Installation and configuration](../tutorial/installconfig/index.md).

In this tutorial, we will use the database `Demo.nsf`. You can download it from [Downloadable resources](../references/downloads.md).

## What's Next

This tutorial includes multiple sections. You will see how to add a database to the Domino REST API configuration so that its content can be accessed by the Domino REST API. You will also perform basic actions like viewing the list of databases, checking the views and forms, creating a document, deleting a document and more. Each of these actions can be performed using the Admin UI or Postman/curl.

!!! tip Quickstart for the busy professional

    If you have working experience in HCL Notes and HCL Domino and wants to quickly get started with Domino REST API, you can directly go to [Quickstart](../tutorial/quickstart.md).

## More tutorials

Additional tutorials are available [here](https://opensource.hcltechsw.com/domino-keep-tutorials/). For more information, see the descriptions below: <!--and also [can be found here](https://opensource.hcltechsw.com/domino-keep-tutorials/):-->

<!--For new features, please see the [Office Round Trip Experience with Domino Documents](../tutorial/roundtrip.md)

### Notes and Domino Developers

Follow the [Domino ToDo Database](https://opensource.hcltechsw.com/domino-keep-tutorials/pages/todo/index) tutorial for Notes and Domino developers. It walks you through:

- Using the XPages ToDo Application.
- Viewing the ACL via Domino REST API Postman APIs.
- Configuring it for validated Domino REST API access.
- Using OData to access data in Microsoft Excel [^1]. All steps are done via the Domino REST API Admin GUI.

[^1]: Microsoft and Microsoft Excel are registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.

### Web Developers

If you are new to Domino, see the [New Domino Database](https://opensource.hcltechsw.com/domino-keep-tutorials/pages/domino-new/index) tutorial for web developers. It walks you through:

- Creating a new Domino database.
- Adding forms for customers and contacts.
- Adding views.
- Configuring the database for validated REST API access.
- Updating the access for the database. Some steps are done via the Domino REST API Admin GUI, some via Postman.

### OData

The [tutorial](../tutorial/odata/index.md) demonstrates how to export data from Notes databases to [OData](https://www.odata.org) using Domino REST API.

-->