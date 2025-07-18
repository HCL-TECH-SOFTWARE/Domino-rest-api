<!--# Windows-->

# Install on Windows

<!-- prettier-ignore -->
!!! caution

    - Domino REST API is supported for installation on Windows with an *HCL Notes client* or an *HCL Domino server*, **but not both on the same machine**. 
    - Notes client support is experimental and not supported for any production use. It is provided to ease evaluation of the Domino REST API and experimentation without the need to configure a Domino server.

## Before you begin

- Domino must be [installed](https://www.hcltechsw.com/domino).

- Domino REST API installer needs to be run as administrator.

- Extract the installer jar file from the downloaded tar file. Newer versions of Windows support the extraction through the Windows File Explorer. Also, most third-party compression utilities support extracting a tar file. Consult your third-party tool documentation for more information.

  You may ignore any warning starting with `Ignoring unknown extended header keyword` while decompressing the tar file.

--8<-- "jarfilename.md"

## Install on Windows Domino server

!!! warning "Important"

    It is strongly recommended to shut down your Domino server before running the installer. The installer updates the `notes.ini`, which could conflict with a running Domino server.

To install, run the following commands:

```bash
java -jar <installer jar filename> ^
 -d="C:\Program Files\HCL\Domino\Data" ^
 -i="C:\Program Files\HCL\Domino\notes.ini" ^
 -p="C:\Program Files\HCL\Domino" ^
 -r="C:\Program Files\HCL\Domino\restapi" ^
 -a
```

Example:

```bash
java -jar restapiInstall-r14.jar ^
 -d="C:\Program Files\HCL\Domino\Data" ^
 -i="C:\Program Files\HCL\Domino\notes.ini" ^
 -p="C:\Program Files\HCL\Domino" ^
 -r="C:\Program Files\HCL\Domino\restapi" ^
 -a
```

??? tip "Expand to see the explanation of the installation command parameters"

    --8<-- "installparameters.md"

The installer adds the `restapi` task to the automatically starting tasks. If opted out using `-n`, you must manually add the `KeepInstallDir` key into your `notes.ini` and then can subsequently issue `load restapi` manually in the Domino console.

For more information, see [Domino REST API task](../../../references/usingdominorestapi/restapitask.md).

!!! note "Domino REST API and Domino 14"

    The Domino REST API installer starting with v1.0.9 has a workaround for an issue between Domino REST API and Domino 14.0 on Windows. For more information or if you receive an error during installation, see [Create symlink for Domino 14 and Domino Rest API](../../../howto/install/symlink.md).

<!--
### Verify the installation

On a new Domino REST API installation, the following actions are performed:

- create the Domino REST API directory (if necessary)
- copy all binary files needed by Domino REST API to that directory
- copy `restapi` into the Domino directory
- update the `ServerTasks` variable in `notes.ini` with `restapi`
- add a variable `KeepInstallDir` to the `notes.ini` pointing to the Domino REST API directory

If an existing installation is found at the location you specified as the restapi directory, the following additional actions are performed:

- The installer checks for a file in your Domino REST API directory named `installerFiles.txt`.
  - If this file exists, the installer uses this list as the list of files to remove before proceeding.
    - If you specified `-u` on the command line, removal of the old files and installation of the new are performed.
    - If you didn't specify `-u`, you will be asked if you want to upgrade. Answering `A <enter>` continues removal of the old files and installation of the new is performed.
  - If this file doesn't exist (which it didn't with `Domino REST API V1`), the installer checks if this is V1 by checking for the existence of the `keep-core-1.9.5.jar` file in the Domino REST API directory.
    - If this is V1, the installer will use the list of known V1 files before proceeding.
        - If you specified `-u` on the command line, removal of the old files and installation of the new are performed.
        - If you didn't specify `-u`, you will be asked if you want to upgrade. Answering `A <enter>` continues removal of the old files and installation of the new is performed. Pressing any other key aborts.
    - If this isn't V1, you will be notified that an unknown version has been found and if you want to proceed you will need to force an upgrade to continue. Forcing an upgrade removes ALL files from the Domino REST API directory and it's subdirectories, so take care that any files you may have put there will be removed. Domino REST API doesn't store any configuration or user files in the Domino REST API directory, only it's runtime and libraries.
        - If you specified `-f` on the command line, all files in the Domino REST API directory structure are removed and installation of the new version is performed.
        - If you didn't specify `-f`, you will be asked if you want to force an upgrade. Answering `A <enter>` continues, all files in the REST API directory structure are removed and installation of the new is performed. Pressing any other key aborts.
-->

## Install on Windows Notes client

To install, run the following commands:

```bash
java -jar <installer jar filename> ^
 -d="C:\Program Files\HCL\Notes\Data" ^
 -i="C:\Program Files\HCL\Notes\notes.ini" ^
 -r="C:\Program Files\HCL\Notes\restapi" ^
 -p="C:\Program Files\HCL\Notes" ^
 -a
```

Example:

```bash
java -jar restapiInstall-r14.jar ^
 -d="C:\Program Files\HCL\Notes\Data" ^
 -i="C:\Program Files\HCL\Notes\notes.ini" ^
 -r="C:\Program Files\HCL\Notes\restapi" ^
 -p="C:\Program Files\HCL\Notes" ^
 -a
```

The installer creates a `runrestapi.cmd` script in the Domino REST API installation directory. Run the script to launch the Domino REST API.
<!--
### Verify the client installation

The installer conducts a series of actions:

- Create the Domino REST API directory.
- Copy all binary files needed by Domino REST API to that directory.
- Create `runrestapi.cmd` in the Domino REST API directory.
-->
### Limitations to client use

--8<-- "limitclientuse.md"

For more information, see [Deploy HCL Domino REST API to HCL Notes Client](../../../howto/install/notesclient.md) for additional steps required to use the Notes client.

## Check that Domino REST API is running

--8<-- "iskeeprunning.md"

## Additional information

### Installation explanation on Windows Domino server

The following details explain what happens when installing Domino REST API.

A new Domino REST API installation

- creates the Domino REST API directory (if necessary).
- copies all binary files needed by Domino REST API to that directory.
- copies `restapi` into the Domino directory.
- updates the `ServerTasks` variable in `notes.ini` with `restapi`.
- adds the variable `KeepInstallDir` to the `notes.ini` pointing to the Domino REST API directory.

If there is an existing installation at the location you specified as the `restapi` directory:

- The installer checks for a file in your Domino REST API directory named `installerFiles.txt`.
  
  - If this file exists, the installer uses this list as the list of files to remove before proceeding.

    - If you specified `-u` on the command line, removal of the old files and installation of the new version are performed.
    - If you didn't specify `-u`, you will be asked if you want to upgrade. Answering `A <enter>` continues the removal of the old files and the installation of the new version.

  - If this file doesn't exist, which it didn't with `Domino REST API V1`, the installer checks if this is V1 by checking for the existence of the `keep-core-1.9.5.jar` file in the Domino REST API directory.

    - If this is V1, the installer will use the list of known V1 files before proceeding.

        - If you specified `-u` on the command line, removal of the old files and installation of the new version are performed.
        - If you didn't specify `-u`, you will be asked if you want to upgrade. Answering `A <enter>` continues removal of the old files and installation of the new version. Pressing any other key aborts.

    - If this isn't V1, you will be notified that an unknown version has been found, and if you want to proceed, you will need to force an upgrade to continue. Forcing an upgrade removes ALL files from the Domino REST API directory and it's subdirectories, so take care that any files you may have put there will be removed. Domino REST API doesn't store any configuration or user files in the Domino REST API directory, only it's runtime and libraries.

        - If you specified `-f` on the command line, all files in the Domino REST API directory structure are removed and installation of the new version is performed.
        - If you didn't specify `-f`, you will be asked if you want to force an upgrade. Answering `A <enter>` continues removal of all files in the REST API directory structure and the installation of the new version. Pressing any other key aborts.

### Installation explanation on Windows Notes client

The following details explain what happens when installing Domino REST API.

The installer conducts a series of actions:

- Create the Domino REST API directory.
- Copy all binary files needed by Domino REST API to that directory.
- Create `runrestapi.cmd` in the Domino REST API directory.

## Next step

Perform [post-installation tasks](../configuration/index.md).

<!--
# Windows

# Install on Windows


!!! caution

    - Domino REST API is supported for installation on Windows with an **HCL Notes client** or an **HCL Domino server**, but not both on the same machine. Should you install both on the same machine, you are on your own.
    - Notes client support is experimental and not supported for any production use. It is provided to ease evaluation of the Domino REST API and experimentation without the need to configure a Domino server.

## Install on a Windows Domino Server

### Before you begin

- Domino must be [installed](https://www.hcltechsw.com/domino).

- Domino REST API installer needs to be run as administrator.

To install, follow the example below:

 "jarfilename.md"

```bash
java -jar restapiInstall.jar ^
 -d="C:\Program Files\HCL\Domino\Data" ^
 -i="C:\Program Files\HCL\Domino\notes.ini" ^
 -p="C:\Program Files\HCL\Domino" ^
 -r="C:\Program Files\HCL\Domino\restapi" ^
 -a
```

!!!note "Domino REST API and Domino 14" 
    The Domino REST API installer starting with v1.0.9 has a workaround for an issue between Domino REST API and Domino 14.0 on Windows. For more information or if you receive an error during installation, see [Create symlink for Domino 14 and Domino Rest API](../../howto/install/symlink.md).

### All parameters

 "installparameters.md"


The installer adds the `restapi` task to the automatically starting tasks. If opted out using `-n`, you must manually add the `KeepInstallDir` key into your `notes.ini` and then can subsequently issue `load restapi` manually in the Domino console.

For more information, see [Domino REST API task](../../references/usingdominorestapi/restapitask.md).

## Verify the installation

On a new Domino REST API installation, the following actions are performed:

- create the Domino REST API directory (if necessary)
- copy all binary files needed by Domino REST API to that directory
- copy `restapi` into the Domino directory
- update the `ServerTasks` variable in `notes.ini` with `restapi`
- add a variable `KeepInstallDir` to the `notes.ini` pointing to the Domino REST API directory

If an existing installation is found at the location you specified as the restapi directory, the following additional actions are performed:

- The installer checks for a file in your Domino REST API directory named `installerFiles.txt`.

  - If this file exists, the installer uses this list as the list of files to remove before proceeding.

    - If you specified `-u` on the command line, removal of the old files and installation of the new are performed.
    - If you didn't specify `-u`, you will be asked if you want to upgrade. Answering `A <enter>` continues removal of the old files and installation of the new is performed.

  - If this file doesn't exist (which it didn't with `Domino REST API V1`), the installer checks if this is V1 by checking for the existence of the `keep-core-1.9.5.jar` file in the Domino REST API directory.

    - If this is V1, the installer will use the list of known V1 files before proceeding.

      - If you specified `-u` on the command line, removal of the old files and installation of the new are performed.
      - If you didn't specify `-u`, you will be asked if you want to upgrade. Answering `A <enter>` continues removal of the old files and installation of the new is performed. Pressing any other key aborts.

    - If this isn't V1, you will be notified that an unknown version has been found and if you want to proceed you will need to force an upgrade to continue. Forcing an upgrade removes ALL files from the Domino REST API directory and it's subdirectories, so take care that any files you may have put there will be removed. Domino REST API doesn't store any configuration or user files in the Domino REST API directory, only it's runtime and libraries.

      - If you specified `-f` on the command line, all files in the Domino REST API directory structure are removed and installation of the new version is performed.
      - If you didn't specify `-f`, you will be asked if you want to force an upgrade. Answering `A <enter>` continues, all files in the REST API directory structure are removed and installation of the new is performed. Pressing any other key aborts.

## Install on a Windows Notes Client

Run the installer:

 "jarfilename.md"

```bash
java -jar restapiInstall.jar ^
 -d="C:\Program Files\HCL\Notes\Data" ^
 -i="C:\Program Files\HCL\Notes\notes.ini" ^
 -r="C:\Program Files\HCL\Notes\restapi" ^
 -p="C:\Program Files\HCL\Notes" ^
 -a
```

The installer creates a `runrestapi.cmd` script in the Domino REST API installation directory, run it to launch the Domino REST API.

## Verify the client installation

The installer conducts a series of actions:

- Create the Domino REST API directory.
- Copy all binary files needed by Domino REST API to that directory.
- Create `runrestapi.cmd` in the Domino REST API directory.

 "limitclientuse.md"

For more information, see [Deploy HCL Domino REST API to HCL Notes Client](../../../howto/install/notesclient.md) for additional steps required to use the Notes client.

 "iskeeprunning.md"

-->