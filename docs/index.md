---
title: Welcome
template: home-blocks.html
hide:
  - navigation
  - toc
---

# Welcome to {{ variable.drapi }} documentation

{{ variable.drapi }} provides a secure REST API with access to HCL Domino servers and databases while running on HCL Domino and HCL Notes on Windows, Linux, and Mac. Designed to re-establish Domino as a world class, modern, standards-compliant, cloud native and enterprise-level collaboration platform, it adds contemporary REST APIs to Notes and Domino, enabling a modern programming experience with the tools of your choice. For more information, see [Introducing Domino REST API](topicguides/introducingrestapi.md).

<span style="color:darkblue">*Click the topics in the image to learn more.*</span>

<object type="image/svg+xml" data="assets/images/svg/keepblockdiagram.svg" width="90%">
Open the <a href="assets/images/svg/keepblockdiagram.svg">overview</a>
</object>

---

## Get started

- Get a first idea of what you are dealing with by [understanding how the Domino REST API works](topicguides/understanding.md).

- If you want to start quickly, go to [Quickstart](tutorial/quickstart.md).

- For installation information, see [Installation and configuration](tutorial/installconfig/index.md).

- For the latest release information about HCL Domino REST API, see [What's new](whatsnew/index.md).

- To know features deprecated in the current and earlier releases, see [deprecated features](references/deprecated.md).

- Having trouble running the Domino REST API? Use the [troubleshooting guide](references/troubleshooting.md).

- Are you coming from a Notes client with a Domino server background? You never had to deal with certificates, JSON Web Token, multiple TCP ports, OAuth, and all the fancy new terms of a shiny new web world. Read [the primer](topicguides/notesprimer.md) to get started.

!!! info "API definitions now available"

    The OpenAPI definitions, rendering using [ReDoc](https://github.com/Redocly/redoc), are now [available in the References](references/openapidefinitions.md). **Depending on your server configuration, not all endpoints will be active.**

<!-- For everything that admin needs to know, use the [Admin cheat sheet](references/admincheatsheet.md).-->
---

## How the documentation is organized

The {{ variable.drapi }} documentation is based on the [Diátaxis framework](https://diataxis.fr/), which organizes documentation into the following modes to address users' documentation needs at different times and in different circumstances. Below shows an overview that guides you on where to look for needed information:

**[Tutorials](tutorial/index.md)** - Hands-on introduction to HCL Domino REST API

**[How-to guides](howto/index.md)** - Practical step-by-step guides for performing tasks and operation

**[Topic guides](topicguides/index.md)** - Discussion and explanation of key topics and concepts to give background information

**[References](references/index.md)** - Technical references and descriptions on using HCL Domino REST API

---

## Let's connect

--8<-- "feedback.md"

<!--
<div class="grid cards" markdown>

-    :material-gesture-tap-button:{ .lg .middle } __Get started__

    ---

    - [System requirements](tutorials/installupgrade/sysreq/index.md)

    - [Compatibility matrix](references/compatibilitymatrix.md)

    - [Installation and upgrade](tutorials/installupgrade/index.md)

    - [Tutorials](tutorials/index.md)

    - [Trainings and webinars](tutorials/webinar.md)

    - [Video tutorials and demonstrations](tutorials/video.md)

    ---

-   :material-new-box:{ .lg .middle } __What's New?__

    ---

    Find out what's new in the latest HCL Volt MX Go release.

    ---

    [:octicons-arrow-right-24: Go to What's New](./whatsnew/index.md)


-   :material-book-open-variant:{ .lg .middle } __Tutorials__

    ---

    Hands-on introduction to Volt MX Go.
    
    ---

    [:octicons-arrow-right-24: Go to Tutorials](./tutorials/index.md)

-   :material-server-network:{ .lg .middle } __How-to guides__

    ---

    Practical step-by-step guides for performing tasks and operation.

    ---

    [:octicons-arrow-right-24: Go to How-to guides](./howto/index.md)

-   :material-file-document:{ .lg .middle } __Topic guides__

    ---

    High-level discussion and explanation of key topics and concepts to give background information.

    ---

    [:octicons-arrow-right-24: Go to Topic guides](./topicguides/index.md)

-   :material-code-tags:{ .lg .middle } __References__

    ---

    Technical references and descriptions on using Volt MX Go.

    ---

    [:octicons-arrow-right-24: Go to Reference](./references/index.md)

-    :material-link-variant:{ .lg .middle } __Quick links__

    ---

    - [Rosetta API reference documentation](javadoc/index.html "Link opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](assets/images/external-link.svg){: style="height:13px;width:13px"}

    - [Known limitations](references/knownlimitation.md)

    - [Support](references/index.md#support)

    - [Documentation references](references/index.md#documentation-references)

    - [Additional considerations](references/addconsideration.md)

    ---

-   :material-map:{ .lg .middle } __Guide to documentation__

    ---

    Provides information on how the documentation is organized and on using the Volt MX Go documentation.

    ---

    [:octicons-arrow-right-24: Go to Guide to documentation](./references/docguide.md)

</div>
-->