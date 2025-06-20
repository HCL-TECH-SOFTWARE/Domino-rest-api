<!--# Mac-->
# Install on macOS

<!-- prettier-ignore -->
!!! caution

    - The Domino server isn't available for macOS, so you can use the Domino REST API only with a Notes client.
    - Notes client support is experimental and not supported for any production use. It's provided to ease evaluation of the Domino REST API and experimentation without the need to configure a Domino server.

## Before you begin

Extract the installer jar file from the downloaded tar file by running the following command:

`tar xvf ./<installer file name> --no-same-owner --no-same-permissions`

*Example*:

`tar xvf ./Domino_REST_API_V1.0.9_R14_Installer.tar.gz --no-same-owner --no-same-permissions`

You may ignore any warning starting with `Ignoring unknown extended header keyword` while decompressing the tar file.

--8<-- "jarfilename.md"

## Install Domino REST API

To install, run the following commands:

```bash
java -jar <installer jar filename> \
 -d="/Users/[your user name]/Library/Application Support/HCL Notes Data" \
 -i="/Users/[your user name]/Library/Preferences/Notes Preferences" \
 -r="/Users/[your user name]/Applications/restapi" \
 -p="/Applications/HCL Notes.app" \
 -a
```

Example:

```bash
java -jar restapiInstall-r14.jar \
 -d="/Users/johndoe/Library/Application Support/HCL Notes Data" \
 -i="/Users/johndoe/Library/Preferences/Notes Preferences" \
 -r="/Users/johndoe/Applications/restapi" \
 -p="/Applications/HCL Notes.app" \
 -a
```

??? tip "Expand to see the explanation of the installation command parameters"

    --8<-- "installparameters.md"

The installer creates a `runrestapi.sh` script in the Domino REST API installation directory. Run it to launch the Domino REST API. You can copy or move the script to `~/bin` to add it to the macOS path.

!!! tip

    If your Notes client has an issue when running `runrestapi.sh`, download and install `openJ9` SDK and modify the `JAVA_HOME` variable in the `runrestapi.sh` to point to your `openJ9` directory.

<!--
## Verify the installation

On a new Domino REST API installation, the following actions are performed:

- Create the Domino REST API directory.
- Copy all binary files needed by Domino REST API to that directory.
- Create `runrestapi.sh` in the Domino REST API directory.

If an exiting installation is found at the location you specified as the restapi directory, the following additional actions are performed:

- The installer checks for a file in your Domino REST API directory named `installerFiles.txt`.

  - If this file exists, the installer will use this list as the of files to remove before proceeding.

    - If you specified `-u` on the command line, removal of the old files and installation of the new are performed.
    - If you didn't specify `-u`, you will be asked if you want to upgrade. Answering `A <enter>` continues removal of the old files and installation of the new is performed.

  - If this file doesn't exist (which it didn't with `Domino REST API V1`), the installer checks to see if this is V1 by checking for the existence of the `keep-core-1.9.5.jar` file in the Domino REST API directory.

    - If this is V1, the installer uses the list of known V1 files before proceeding.

        - If you specified `-u` on the command line, removal of the old files and installation of the new are performed.
        - If you didn't specify `-u`, you will be asked if you want to upgrade. Answering `A <enter>` continues removal of the old files and installation of the new is performed. Pressing any other key aborts.

    - If this isn't V1, you will be notified that an unknown version has been found and if you want to proceed you will need to force an upgrade to continue. Forcing an upgrade removes ALL files from the Domino REST API directory and it's subdirectories, so take care that any files you may have put there will be removed. Domino REST API doesn't store any configuration or user files in the Domino REST API directory, only it's runtime and libraries.

        - If you specified `-f` on the command line, all files in the Domino REST API directory structure are removed and installation of the new version is performed.
        - If you didn't specify `-f`, you will be asked if you want to force an upgrade, answering `A <enter>` continues, all files in the REST API directory structure are remove and installation of the new is performed. Pressing any other key aborts.

!!! tip

    If your Notes client has an issue when running `runrestapi.sh`, download and install `openJ9` SDK and modify the `JAVA_HOME` variable in the `runrestapi.sh` to point to your `openJ9` directory.
-->
## Limitations to client use

--8<-- "limitclientuse.md"

For more information, see [Deploy HCL Domino REST API to HCL Notes Client](../../../howto/install/notesclient.md) for additional steps required to use the Notes client.

## Additional information

### Installation explanation

The following details explain what happens when installing Domino REST API.

A new Domino REST API installation

- creates the Domino REST API directory.
- copies all binary files needed by Domino REST API to that directory.
- creates `runrestapi.sh` in the Domino REST API directory.

If an exiting installation is found at the location you specified as the `restapi` directory:

- The installer checks for a file in your Domino REST API directory named `installerFiles.txt`.

  - If this file exists, the installer will use this list as the list of files to remove before proceeding.

    - If you specified `-u` on the command line, removal of the old files and installation of the new version are performed.
    - If you didn't specify `-u`, you will be asked if you want to upgrade. Answering `A <enter>` continues removal of the old files and the installation of the new version.

  - If this file doesn't exist, which it didn't with `Domino REST API V1`, the installer checks if this is V1 by checking for the existence of the `keep-core-1.9.5.jar` file in the Domino REST API directory.

    - If this is V1, the installer uses the list of known V1 files before proceeding.

        - If you specified `-u` on the command line, removal of the old files and installation of the new are performed.
        - If you didn't specify `-u`, you will be asked if you want to upgrade. Answering `A <enter>` continues removal of the old files and installation of the new version. Pressing any other key aborts.

    - If this isn't V1, you will be notified that an unknown version has been found, and if you want to proceed, you will need to force an upgrade to continue. Forcing an upgrade removes ALL files from the Domino REST API directory and it's subdirectories, so take care that any files you may have put there will be removed. Domino REST API doesn't store any configuration or user files in the Domino REST API directory, only it's runtime and libraries.

        - If you specified `-f` on the command line, all files in the Domino REST API directory structure are removed and installation of the new version is performed.
        - If you didn't specify `-f`, you will be asked if you want to force an upgrade. Answering `A <enter>` continues removal of all files in the REST API directory structure and installation of the new version is performed. Pressing any other key aborts.


<!--## Next step

Perform [post-installation tasks](../configuration/index.md).
-->

<!--
# Install on macOS

!!! caution
    - The Domino server isn't available for macOS, so you can use the Domino REST API only with a Notes client.
    - Notes client support is experimental and not supported for any production use. It's provided to ease evaluation of the Domino REST API and experimentation without the need to configure a Domino server.

To install, follow the example below:

 "jarfilename.md"

```bash
java -jar restapiInstall.jar \
 -d="/Users/[your user name]/Library/Application Support/HCL Notes Data" \
 -i="/Users/[your user name]/Library/Preferences/Notes Preferences" \
 -r="/Users/[your user name]/Applications/restapi" \
 -p="/Applications/HCL Notes.app" \
 -a
```

## All parameters

 "installparameters.md"

The installer creates a `runrestapi.sh` script in the Domino REST API installation directory. Run it to launch the Domino REST API. You can copy or move the script to `~/bin` to add it to the macOS path.

## Verify the installation

On a new Domino REST API installation, the following actions are performed:

- Create the Domino REST API directory.
- Copy all binary files needed by Domino REST API to that directory.
- Create `runrestapi.sh` in the Domino REST API directory.

If an exiting installation is found at the location you specified as the restapi directory, the following additional actions are performed:

- The installer checks for a file in your Domino REST API directory named `installerFiles.txt`.

  - If this file exists, the installer will use this list as the of files to remove before proceeding.

    - If you specified `-u` on the command line, removal of the old files and installation of the new are performed.
    - If you didn't specify `-u`, you will be asked if you want to upgrade. Answering `A <enter>` continues removal of the old files and installation of the new is performed.

  - If this file doesn't exist (which it didn't with `Domino REST API V1`), the installer checks to see if this is V1 by checking for the existence of the `keep-core-1.9.5.jar` file in the Domino REST API directory.

    - If this is V1, the installer uses the list of known V1 files before proceeding.

      - If you specified `-u` on the command line, removal of the old files and installation of the new are performed.
      - If you didn't specify `-u`, you will be asked if you want to upgrade. Answering `A <enter>` continues removal of the old files and installation of the new is performed. Pressing any other key aborts.

    - If this isn't V1, you will be notified that an unknown version has been found and if you want to proceed you will need to force an upgrade to continue. Forcing an upgrade removes ALL files from the Domino REST API directory and it's subdirectories, so take care that any files you may have put there will be removed. Domino REST API doesn't store any configuration or user files in the Domino REST API directory, only it's runtime and libraries.

      - If you specified `-f` on the command line, all files in the Domino REST API directory structure are removed and installation of the new version is performed.
      - If you didn't specify `-f`, you will be asked if you want to force an upgrade, answering `A <enter>` continues, all files in the REST API directory structure are remove and installation of the new is performed. Pressing any other key aborts.


!!! tip

    If your Notes client has an issue when running `runrestapi.sh`, please downloand and install `openJ9` SDK and modify the `JAVA_HOME` variable in the `runrestapi.sh` to point to your `openJ9` directory.

 "limitclientuse.md"

For more information, see [Deploy HCL Domino REST API to HCL Notes Client](../../howto/install/notesclient.md) for additional steps required to use the Notes client.

-->