# Remove Domino REST API from Domino server or Notes Client

## About this task

The Domino REST API doesn't have an uninstaller. If you'd like to remove it from your system, follow these procedures.

<!-- prettier-ignore -->
!!! caution
    The following procedures permanently remove *Domino REST API*, including all configurations and customizations. Make a complete backup before proceeding.

## Domino Server

### Prerequisite

- You must have the correct permissions for this procedure, typically `Administrator` for Windows and `root` for Linux.

<!-- prettier-ignore -->
!!! tip
    - The following conventions are used:

        - *Domino program directory* refers to the location of the executables on a specific system. For example:

            - **Windows** - `C:\Program Files\HCL\Domino`

            - **linux** - `/opt/hcl/domino/notes/latest/linux`

        - *Domino Data directory* refers to where databases are typically stored. For example:

            - **Windows** - `C:\Program Files\HCL\Domino\Data`

            - **linux** - `/local/notesdata`
    - Take note of where *Domino REST API* is installed by noting the value of the setting `KeepInstallDir=` in the `notes.ini`.

### Procedure

1. Shut down your Domino server.
2. Make a complete backup of your system.
3. Edit your Domino Server's `notes.ini` file and remove:

      - `,restapi` from the `ServerTasks=` line
      - entire `KeepInstallDir=` line
      - entire `KeepManagementURL=` line

4. Remove runtime files in the Domino program directory:

      - Windows:

         - `nrestapi.*`
         - `nkeepevents.*`

      - Linux:

         - `restapi`
         - `libkeepevents.so`
         - `libidvaultapi.so`

5. Remove databases from your Domino Data directory:

      - `KeepConfig.nsf`
      - `KeepConfig.ntf`
      - `KeepAgents.nsf`
      - `KeepAgents.ntf`
      - `KeepOAuth.nsf`
      - `KeepOAuth.ntf`

6. Remove the following directories and their contents from your Domino Data directory:

      - `keepconfig.d`
      - `keepweb.d`

7. Remove the `Domino REST API` directory and all it's contents.

### Expected result

Domino REST API has been removed from your system.

## Notes Client

<!-- prettier-ignore -->
!!! tip
    The following conventions are used:

    *Notes Data directory* refers to where databases are typically stored. For example:

     - **Windows** - `C:\Program Files\HCL\Notes\Data`

     - **mac** - `/Users/[your user name]/Library/Application Support/HCL Notes Data`

### Procedure

1. Remove databases from your Notes Data directory:

      - `KeepConfig.nsf`
      - `KeepConfig.ntf`
      - `KeepAgents.nsf`
      - `KeepAgents.ntf`
      - `KeepOAuth.nsf`
      - `KeepOAuth.ntf`

2. Remove the following directories and their contents from your Notes Data directory:

      - `keepconfig.d`
      - `keepweb.d`

3. Remove the `Domino REST API` directory and all it's contents.

### Expected result

Domino REST API has been removed from your system.
