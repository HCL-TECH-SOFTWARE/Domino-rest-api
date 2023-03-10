# Contributing

Bug fixes and enhancements are welcome.

## Raising Issues

If there are inaccuracies in any pages, please include links to the relevant page (either the rendered page or the source file) and a screenshot, preferably annotated. All open source projects are supported in addition to day jobs, so we appreciate information that helps us quickly locate the problem and apply the fix. The easier it is to fix, the quicker it's likely to be resolved.

## Local Testing

Please test all changes locally before submitting.

Domino REST API documentation uses [MKDocs](https://www.mkdocs.org/) and [Material for MKDocs](https://squidfunk.github.io/mkdocs-material). The recommended approach for testing locally is to use a [Visual Studio Code dev container](https://code.visualstudio.com/docs/remote/containers). This injects your workspace folders and files into a Docker container.

### Creating the Docker Image

Dockerfiles and makedocker scripts are included in the repo to generate a Docker image for you. Latest Macs use M1 chip, which requires a different base image. Consequently, those users will need to use the M1 variants of the scripts and docker image.

1. Run `makedocker.sh`. This will create an image called keepdocs:latest or keepdocs:m1.

### Running the Repo In A DevContainer

You will need the "Dev Containers" extension for Visual Studio Code installed.

1. Create a ".devcontainer" directory in the root of the repo. This will be ignored by git.
2. Create a file "devcontainer.json" in the .devcontainer directory.
3. Add the content, amending the Docker image tag if you ran makedockerM1.sh:

    ```json
    {
        "image": "keepdocs:latest"
    }
    ```

4. From the menu, select View > Command Palette...
5. Find and select "Dev Containers: Reopen in Container".

VS Code Code will re-open, with the folder injected into the container. This can be verified by showing the Terminal in VS Code. The path will begin "/workspaces/".

### Previewing the Documentation

The documentation can be previewed by issuing the command `mkdocs serve`. The site will now be available at https://localhost:8000.

## Pull Requests

Once an enhancement fix has been tested locally, you're welcome to submit a Pull Request.

If you raise a pull-request without having signed the CLA, you will be prompted to do so automatically.
