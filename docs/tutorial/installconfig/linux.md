<!--# Linux-->

# Install on Linux Domino server

- On Linux, the installer installs the Domino REST APIs for use with an HCL Domino server.
- It's **strongly** recommended to use the default directories on Linux.
- Don't install using the `java` executable in `/opt/hcl/domino/bin/`. If your system doesn't have Java installed, you can use the `java` executable in the `/opt/hcl/domino/notes/latest/linux/jvm/bin/` directory.

To install, follow the example below:

--8<-- "jarfilename.md"

```bash
sudo java -jar restapiInstall.jar \
 -d="/local/notesdata" \
 -i="/local/notesdata/notes.ini" \
 -r="/opt/hcl/restapi" \
 -p="/opt/hcl/domino/notes/latest/linux" \
 -a
```

## All parameters

--8<-- "installparameters.md"


The installer adds the `restapi` task to the automatically starting tasks. If opted out using `-n`, you must manually add the `KeepInstallDir` key into your `notes.ini` and then can subsequently issue `load restapi` manually in the Domino console.

For more information, see [Domino REST API task](../../references/usingdominorestapi/restapitask.md).

## Verify the installation

On a new Domino REST API installation, the following actions are performed:

- Create the Domino REST API directory.
- Copy all binary files needed by Domino REST API to that directory.
- Copy `restapi` into the Domino directory.
- Update the `ServerTasks` variable in `notes.ini` with `restapi`.
- Add a variable `KeepInstallDir` to the `notes.ini` pointing to the Domino REST API directory.

If an exiting installation is found at the location you specified as the restapi directory, the following additional actions are performed:

- The installer checks for a file in your Domino REST API directory named `installerFiles.txt`.

  - If this file exists, the installer uses this list as the list of files to remove before proceeding.

    - If you specified `-u` on the command line, removal of the old files and installation of the new are performed.
    - If you didn't specify `-u`, you will be asked if you want to upgrade, answering `A <enter>` continues, removal of the old files and installation of the new is performed.

  - If this file doesn't exist, which it didn't with `Domino REST API V1`, the installer checks to see if this is V1 by checking for the existence of the `keep-core-1.9.5.jar` file in the Domino REST API directory.

    - If this is V1, the installer uses the list of known V1 files before proceeding.

      - If you specified `-u` on the command line, old files are removed and installation of the new is performed.
      - If you didn't specify `-u`, you'll be asked if you want to upgrade. Answering `A <enter>` continues the removal of the old files and the installation of the new. Pressing any other key aborts.

    - If this isn't V1, you will be notified that an unknown version has been found and if you want to proceed you will need to force an upgrade to continue. Forcing an upgrade removes ALL files from the Domino REST API directory and it's subdirectories, so take care that any files you may have put there will be removed. Domino REST API doesn't store any configuration or user files in the Domino REST API directory, only it's runtime and libraries.

      - If you specified `-f` on the command line, all files in the Domino REST API directory structure are removed and installation of the new version is performed.
      - If you didn't specify `-f`, you will be asked if you want to force an upgrade, answering `A <enter>` continues, all files in the REST API directory structure are remove and installation of the new is performed. Pressing any other key aborts.

## Update Environment

- The `restapi` task requires 2 environment variables to be set before launching Domino.

  - Add the following directories to your PATH if not already there:

    - Your notesdata directory
    - The Domino binary directory
    - The res/C directory inside your Domino binary directory.

    For example:

    `PATH=/local/notesdata:/opt/hcl/domino/notes/latest/linux:/opt/hcl/domino/notes/latest/linux/res/C:$PATH`

  - Add the following to your LD_LIBRARY_PATH environment variable if not already there:

    - your Domino binary directory.
    - The jvm/bin directory inside your Domino binary directory.
    - The jvm/bin/classic directory inside your Domino binary directory.

    For example:

    `LD_LIBRARY_PATH=/opt/hcl/domino/notes/latest/linux:/opt/hcl/domino/notes/latest/linux/jvm/bin:/opt/hcl/domino/notes/latest/linux/jvm/bin/classic:$LD_LIBRARY_PATH`

## File ownership and access rights

On Linux, you need to carefully check that your file and directory ownership and access rights are set correctly. The **strongly** recommended conventions are:
{: .alert .alert-danger}

- User to run the Domino server: `notes`.
- Domino installed in `/opt/hcl/domino` -> owned by `root`.
- Domino REST API installed in `/opt/hcl/restapi` -> owned by `root`.
- Domino data directory `/local/notesdata` -> owned by `notes`.
- Access for files and directories in `/opt` set to `755`.
- Access for directories in `/local/notesdata` set to `770`.
- Access for files in `/local/notesdata` set to `660`.
- NOTE: directories need the execute flag (1), otherwise they can't be accessed, so access for a directory must be an odd number always.
- Don't set access anywhere to 777.

--8<-- "iskeeprunning.md"
