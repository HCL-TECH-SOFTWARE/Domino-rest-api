# Development Container

[Development Containers](https://containers.dev/) is a Microsoft initiated open standard, extending the use case for containers (colloquial Docker) to development environments. Curently, [VSCode](https://code.visualstudio.com/) and [IntelliJ](https://www.jetbrains.com/idea/) are supported.

!!! info "In a nutshell"

    A devcontainer setup allows for a standardized development environment, so all tools and runtimes are available to the developer consistently.

You can walk through the steps required for a consistent DRAPI development experience. This includes a local Domino instance for testing.

## Prerequisites

- A container runtime:

    - [Docker desktop](https://www.docker.com/products/docker-desktop/) (Win, Mac, Linux)
    - [Rancher desktop](https://rancherdesktop.io/) (Win, Mac, Linux)
    - [Podman desktop](https://podman-desktop.io/) (Win, Mac, Linux)
    - [MicroK8s](https://microk8s.io/) (Linux)
    - [Orbstack](https://orbstack.dev/) (Mac)

    Depending on your choice, you might need to obtain a license. Be sure to check.

- a supported IDE
- the HCL [Domino Container](https://opensource.hcltechsw.com/domino-container/) repository
- your HCL credentials to obtain the Domino installer
<!-- some patience and a few hours time-->

## Initial image

We start with a Java development image and add Domino and tooling.

## .devcontainer and scripts

## Side cars anyone?

--8<-- "future.md"

<!--## Let's connect

"feedback.md"-->
