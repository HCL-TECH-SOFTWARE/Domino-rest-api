# Installation and configuration

## Installation

<!-- prettier-ignore -->
!!! note "**System requirements**"
      Before performing the installation, make sure to check the [System requirements](https://support.hcltechsw.com/csm?id=kb_article&sysparm_article=KB0101789).

### Download the Domino REST API

1. Go to [HCL License and Download Portal](https://hclsoftware.flexnetoperations.com/).
2. On the sign in page, enter your username and click **Next**. The **License & Download Portal** home page opens. 
3. In the **Your Downloads** pane, scroll to find and then select **HCL Domino**. The **Download Packages** page opens. 
4. On the **New Versions** tab, select the HCL Domino REST API version that you want to download.

**OR**

1. On the **License & Download Portal** home page, go to **Downloads** &rarr; **Search Downloads**.
2. On the **Download Search** page, enter `HCL Domino REST API` in the **Search for** field, and then click **Search**.
3. Select the HCL Domino REST API version that you want to download from the search result. 
  

[Download the Domino REST API](https://hclsoftware.flexnetoperations.com/)

<!-- prettier-ignore -->
!!! tip
      If you downloaded the `Domino REST API Installer`, extract the `.tar.gz` file before installing.

      Perform the following based on your OS:

      - `macOS` / `linux` - execute the following command:
         `tar xvf ./Domino_REST_API_V1_Installer.tar.gz --no-same-owner --no-same-permissions`

      - `Windows` - Newer versions of Windows supports extracting `.tar.gz` through the Explorer, also most 3rd party compression utilities supports extracting `.tar.gz` -- Consult your 3rd party tool documentation for more information.

      You may ignore any warning starting with `Ignoring unknown extended header keyword` while decompressing the tar.gz file.

Domino REST API can be installed on:

- Notes Client on [macOS](../installconfig/mac.md)
- Notes Client on [Windows](../installconfig/win.md)
- Domino Server on [Windows](../installconfig/win.md)
- Domino Server on [Linux](../installconfig/linux.md)
- Domino Server on [Docker or Kubernetes](../installconfig/docker.md)

All platforms use a Java-based installer, except Docker, which uses a Docker image. You can download the installer and the Docker image from your Flexnet account. For any questions, contact your HCL reseller.

The installer requires a series of parameters:

```bash
[sudo] java -jar restapiInstall.jar [-ahnsyV] -d=<dataDir> -i=<notesIni> -r=<restapiDir> -p=<programDir>
```

<!-- prettier-ignore -->
!!! tip
      Notes and Domino install a JVM on your computer. You can and should use it to install.

      - On Linux, `/opt/hcl/domino/notes/latest/linux/jvm/bin`
      - On Windows, `<Notes installation directory>/jvm/bin` (example: `Program Files/HCL/Notes/jvm/bin`)

      You can also verify the Java version by opening the command prompt, going to the installation location, and then typing `java -version`. 

### Explanation of parameters

| Short | Full parameter              | Mandatory | Description                                                                                                                                                                                                                                                                                |
| :---: | --------------------------- | :-------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `-d`  | `--dataDir=<dataDir>`       |     ✓     | Directory of your HCL Notes or Domino data.                                                                                                                                                                                                                                                |
| `-i`  | `--ini=<notesIni>`          |     ✓     | HCL Notes/Domino notes.ini file.                                                                                                                                                                                                                                                           |
| `-r`  | `--restapiDir=<restapiDir>` |     ✓     | Directory to install the Domino REST API files into.                                                                                                                                                                                                                                       |
| `-p`  | `--programDir=<programDir>` |     ✓     | Directory where HCL Notes or Domino is installed.                                                                                                                                                                                                                                          |
|       |                             |           |                                                                                                                                                                                                                                                                                            |
| `-u`  | `--upgrade`                 |           | Performs an upgrade from a previous version. Upgrade will remove known<br />program files and libraries from the rest API directory and install the new<br />version into the same directory.                                                                                              |
| `-f`  | `--forceUpgrade`            |           | Performs an upgrade without regard to the previous version. If an unknown<br />version or unexpected files are found in the rest API directory, this option will delete<br />the entire contents of the rest API directory and subdirectories first before installing<br/>the new version. |
| `-a`  | `--accept`                  |           | Automatically accept terms & conditions.                                                                                                                                                                                                                                                   |
| `-h`  | `--help`                    |           | Show this help message and exit.                                                                                                                                                                                                                                                           |
| `-n`  | `--noIniUpdates`            |           | Install the files, show updated ini entries but don't write them out.                                                                                                                                                                                                                      |
| `-o`  | `--oneTouchInstall`         |           | If installing restapi as part of a Domino One Touch Install, use this option<br />to prevent checking for Notes / Domino directories and notes.ini.                                                                                                                                        |
| `-y`  | `--dryRun`                  |           | Do not actually copy or alter files and settings.                                                                                                                                                                                                                                          |
| `-s`  | `--skipDirectoryCheck`      |           | Skips the checks if the program and data directories<br />contain Notes or Domino.                                                                                                                                                                                                         |
| `-V`  | `--version`                 |           | Print version information and exit.                                                                                                                                                                                                                                                        |

### Installation return codes

| Code | Explanation                                                    |
| :--: | -------------------------------------------------------------- |
|  0   | Operation completed with no known error.                       |
|  1   | License not accepted.                                          |
|  2   | Installation type could not be determined or is not supported. |
|  3   | Check for / creation of installation directories failed.       |
|  4   | Extraction of Domino REST API binaries and JARs failed.        |
|  5   | Creation of start script/cmd failed.                           |
|  6   | Update of `notes.ini` failed.                                  |

<!-- prettier-ignore -->
!!! tip
      You can use a response file (see below) to provide the parameters.

### Using a response file

Instead of providing all parameters on the command line, the Domino REST API installer can be called using a [response file](https://picocli.info/#AtFiles):

```bash
[sudo] java -jar restapiInstaller.jar @responses.txt
```

The file contains one parameter per line. Lines starting with `#` get ignored. Variables with `\` need to be escaped `\\`:

```properties
# Sample of an installer response file
--dataDir=D:\\Domino\\data
--ini=D:\\Domino\\data\\notes.ini
--restapiDir=C:\\Program Files\\HCL\\restapi
--programDir=C:\\Program Files\\HCL\\Domino
--accept
```

## Hosting your static application

A typical use case for Domino REST API is to build a web UI with the flavor of the day web development framework like Angular, ReactJS, Swelte etc. These frameworks usually generate a `build` directory with a set of static files.

You can copy that directory to `keepweb.d` in your Domino data directory and Domino REST API will serve them on the `/keepweb/` URL path. This eliminates the need for [CORS](../../references/usingdominorestapi/keepapplications.md) configuration.

This is similar to Domino's feature serving static files from its `domino/html` directory.

## Configuration & Security

Domino REST API is preconfigured with settings that allow you to get started right away. However, you should familiarize yourself with all [configuration parameters](../../references/quickreference/parameters.md) and [security](../../references/security/securityindex.md) settings before you deploy into a production environment.

### Understanding configuration

The configuration follows the concept of an [Overlay File System](https://en.wikipedia.org/wiki/OverlayFS). The base configuration is retrieved from the installation directory or `jar` files.

When jar files contain a resource `/config/config.json`, that configuration file is added to total configuration.

Then, it's overlaid with any JSON files in the `keepconfig.d` directory within the Notes data directory and then finally, with any environment parameters.

### Hierarchy

![The call hierarchy](../../assets/images/ActualConfiguration.png)

All files contribute JSON, which are overlaid on top of each other. JSON elements with same names get overwritten. Arrays are replaced and not overwritten.

The JSON files in `keepconfig.d` are processed in alphabetical order. Last entry wins. This processing order allows you, for example, to disable elements temporarily through settings in a `z-final-words.json` file without impacting the permanent configuration.

For more information, see [vert.x overloading rules](https://vertx.io/docs/vertx-config/java/#_overloading_rules).

### Example

Given the files `config.json`, `a.json` and the environment variable `PORT=8564`, you get the result `result.json` as shown below:

## config.json

```json
{
  "PORT": 8880,
  "AllowJwtMail": true,
  "versions": {
    "basis": {
      "path": "/schema/openapi.basis.json",
      "active": true
    }
  }
}
```

## a.json

```json
{
  "dance": "tango",
  "PORT": 1234,
  "versions": {
    "basis": {
      "active": false
    },
    "special": {
      "path": "/schema/openapi.special.json",
      "active": true
    }
  }
}
```

Merge these 2 files and apply the environment variables.

## result.json

```json
{
  "PORT": 8564,
  "AllowJwtMail": true,
  "dance": "tango",
  "versions": {
    "basis": {
      "path": "/schema/openapi.basis.json",
      "active": false
    },
    "special": {
      "path": "/schema/openapi.special.json",
      "active": true
    }
  }
}
```

The actual result can be inspected on the Domino REST API management API, like [on a local install](http://localhost:8889/config).

### Important Notes

> JSON overlay doesn't allow you to **remove** JSON elements. So, most settings have an `active` parameter that
> can be set to false in an overlay.

Follow this [guide](../../howto/install/uninstall.md) to remove Domino REST API from your system.
