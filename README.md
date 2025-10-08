# Domino REST API documentation

## Usage

[View the documentation](https://opensource.hcltechsw.com/Domino-rest-api/) for product features and usage information.  

## Contributing

You are welcome to report bugs or provide feedback on the **product documentation** using pull requests on GitHub at https://github.com/HCL-TECH-SOFTWARE/Domino-rest-api. This is the Domino REST API product documentation website and not the product support platform, so all bug reports and pull requests shall pertain to product documentation. **You are expected to update only the markdown files in the `docs` directory**.

### How to contribute?

Perform the following steps to contribute to the documentation.

1. Update the documentation.

    1. Clone the [Domino REST API documentation repo](https://github.com/HCL-TECH-SOFTWARE/Domino-rest-api).

        If you do not have write access to the repo, [fork the repository](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo#forking-a-repository) and then [clone your forked repository](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo#cloning-your-forked-repository).

    2. Create a new working branch for your changes.
    3. Edit the Markdown files (.md) in the `docs` directory that you want to update using your preferred text or code editor, and then save the changes.

2. Validate your changes

    Perform the following steps to test and preview how your changes render as HTML using MkDocs.

    **Using [Visual Studio Code Dev Container](https://code.visualstudio.com/docs/devcontainers/containers)**

    Make sure to install the "Dev Containers" extension for Visual Studio Code.

    1. Run `makedocker.sh` to create a Docker image called keepdocs:latest.

        `Dockerfile` and `makedocker` scripts are included in the repository to build the required Docker image. Macs with M1 chips need a different base image, so M1 users must use the M1-specific scripts and images.

    2. Create a `.devcontainer` directory in the root of the repo.
    3. Create a `devcontainer.json` file in the `.devcontainer` directory. The `devcontainer.json` file has the following content:

        ```json
        {
        "image": "keepdocs:latest"
        }
        ```

        Make sure to change the `image` tag if you used the M1-variant script.

    4. Open the **Command Palette**, and then search for and select **Dev Containers: Reopen in Container**.

        VS Code will reopen with your project folder loaded inside the container. You can confirm this by opening the Terminal in VS Code, where the working directory path will start with "/workspaces/".

    5. Run the command `mkdocs serve` and then open `https://localhost:8000` in your browser to check your changes.

    **Using MkDocs locally**

    1. [Install MkDocs](https://www.mkdocs.org/user-guide/installation/) (if not already installed) to build and preview the documentation locally.
    2. Install the MkDocs plugins:

        ```
        pip install mkdocs-material
        pip install mkdocs-awesome-pages-plugin 
        pip install mkdocs-git-revision-date-localized-plugin 
        ```

    3. Preview your changes in a web browser by running the [`mkdocs serve`](https://www.mkdocs.org/user-guide/cli/#mkdocs-serve) command.

        Make sure you're in the same directory as the `mkdocs.yml` configuration file when running the `mkdocs serve` command.

    4. Open `http://127.0.0.1:8000` in your browser to check the formatting, links, and rendering of your changes.

3. Submit your documentation changes.

    1. Stage and commit your changes with a clear commit message.
    2. Push your branch to remote [Domino REST API repo](https://github.com/HCL-TECH-SOFTWARE/Domino-rest-api).

        In case you created your branch from your fork, push your branch to your fork of the Domino REST API repository.

    3. Navigate to the [Domino REST API repo](https://github.com/HCL-TECH-SOFTWARE/Domino-rest-api) on GitHub, then create a pull request (PR) from your branch targeting the main branch.

        In case you pushed your branch to your fork of the Domino REST API repository, see [create a pull request from a fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork).

    4. Respond to review comments and update your PR as needed until approved.

        Once the pull request is approved and merged, your changes will be published on the documentation site.

## Raising Issues

If you find any inaccuracies on a page, you can create an issue. Make sure to provide links to the relevant page, either the rendered version or the source file, along with an annotated screenshot. Providing detailed information helps us quickly identify and fix issues.

## Feeedback

Join the Domino REST API conversation in the HCL Domino forum at the [HCLSoftware Digital Solutions Community Forum](https://developer.ds.hcl-software.com/ "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}, or connect with the community on the [OpenNTF Discord channel](https://discord.com/invite/jmRHpDRnH4 "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}.

## Set up GitHub email notifications

Configure your email notification preferences to receive notifications.

1. Go to [Notifications](https://github.com/settings/notifications).
2. Make sure that your preferred email address is correctly set as the **Default notification email**.
3. Make sure that the following options are selected to receive email updates for conversations you are involved in or watching under **Customize email updates**:

    - Pull Request reviews
    - Pull Request pushes
    - Comments on Issues and Pull Requests

## License

The documentation is available as open source under the terms of the [Apache License 2.0](http://www.apache.org/licenses/).

<!--
# DOMINO REST API

## Contributing

Contributions are welcomed, both bug fixes or enhancements to existing tutorials and brand new tutorials. See [Contributing](/CONTRIBUTING.md) for details on how to contribute.

## Feeedback

We would love to hear from you. Choose one of the below options to reach us:

- Join us for questions, discussions, ideas and feedback over at **OpenNTF's Discord**. If you are not already a member of the Discord server, OpenNTF has [a page](https://openntf.org/discord) giving a link to register and help to get you started.
- Discuss this documentation [here on GitHub](https://github.com/HCL-TECH-SOFTWARE/Domino-rest-api/discussions).
- Provide feedback on the standalone tutorials on their dedicated [GitHub](https://github.com/HCL-TECH-SOFTWARE/domino-keep-tutorials).


## Copyright

Copyright 2022-23, HCL America, Inc. under [Apache License](/LICENSE).

=======
-->