# Windows

## Install on Windows

<!-- prettier-ignore -->
!!! caution

    - Domino REST API is supported for installation on Windows with an **HCL Notes client** or an **HCL Domino server**, but not both on the same machine. Should you install both on the same machine, you are on your own.
    - Notes client support is experimental and not supported for any production use. It is provided to ease evaluation of the Domino REST API and experimentation without the need to configure a Domino server.

## Install on a Windows Domino Server

## Prerequisite

- Domino must be [installed](https://www.hcltechsw.com/domino).
- Domino REST API installer needs to be run as administrator.

To install, follow the example below:

```bash
java -jar restapiInstall.jar ^
 -d="C:\Program Files\HCL\Domino\Data" ^
 -i="C:\Program Files\HCL\Domino\notes.ini" ^
 -p="C:\Program Files\HCL\Domino" ^
 -r="C:\Program Files\HCL\Domino\restapi" ^
 -a
```

## All parameters

| Short | Full parameter              | Mandatory | Description                                                                                                                                                                                                                                                                                              |
| :---: | --------------------------- | :-------: | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-d`  | `--dataDir=<dataDir>`       |     ✓     | Directory of your HCL Notes or Domino data.                                                                                                                                                                                                                                                              |
| `-i`  | `--ini=<notesIni>`          |     ✓     | HCL Notes/Domino notes.ini file.                                                                                                                                                                                                                                                                         |
| `-r`  | `--restapiDir=<restapiDir>` |     ✓     | Directory to install the Domino REST API files into.                                                                                                                                                                                                                                                     |
| `-p`  | `--programDir=<programDir>` |     ✓     | Directory where HCL Notes or Domino is installed.                                                                                                                                                                                                                                                        |
|       |                             |           |                                                                                                                                                                                                                                                                                                          |
| `-u`  | `--upgrade`                 |           | Performs an upgrade from a previous version. Upgrade will remove known<br />program files and libraries from the Domino REST API directory and install the new<br />version into the same directory.                                                                                                     |
| `-f`  | `--forceUpgrade`            |           | Performs an upgrade without regard to the previous version. If an unknown<br />version or unexpected files are found in the Domino REST API directory, this option will delete<br />the entire contents of the Domino REST API directory and subdirectories first before installing<br/>the new version. |
| `-a`  | `--accept`                  |           | Automatically accept terms & conditions.                                                                                                                                                                                                                                                                 |
| `-h`  | `--help`                    |           | Show this help message and exit.                                                                                                                                                                                                                                                                         |
| `-n`  | `--noIniUpdates`            |           | Install the files, show updated ini entries but don't write them out.                                                                                                                                                                                                                                    |
| `-o`  | `--oneTouchInstall`         |           | If installing Domino REST API as part of a Domino One Touch Install, use this option<br />to prevent checking for Notes / Domino directories and notes.ini.                                                                                                                                              |
| `-y`  | `--dryRun`                  |           | Do not actually copy or alter files and settings.                                                                                                                                                                                                                                                        |
| `-s`  | `--skipDirectoryCheck`      |           | Skips the checks if the program and data directories<br />contain Notes or Domino.                                                                                                                                                                                                                       |
| `-V`  | `--version`                 |           | Print version information and exit.                                                                                                                                                                                                                                                                      |

The installer adds the `restapi` task to the automatically starting tasks. If opted out using `-n` you must manually add the `KeepInstallDir` key into your `notes.ini` and then can subsequently issue `load restapi` manually in the Domino console.

For more information, see [Domino REST API task](../../references/usingdominorestapi/restapitask.md).

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

## Install on a Windows Notes Client

Run the installer:

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

--8<-- "limitclientuse.md"

For more information, see [Deploy HCL Domino REST API to HCL Notes Client](../../howto/install/notesclient.md) for additional steps required to use the Notes client.