# Installation and configuration

The guide outlines the steps to install the Domino REST API and the necessary configuration tasks after installation to complete a production-ready deployment, ensuring full capability and a secure interface for your Domino applications.

## [Installation](install/index.md)

Details the necessary steps to install the Domino REST API, beginning with verifying that your system meets the required specifications, followed by downloading the installers, and concluding with the installation of the Domino REST API on the compatible platform.

## [Post-installation tasks](configuration/index.md)

Details the necessary configuration tasks necessary to complete a production-ready deployment of Domino REST API.

## Additional information

After completing the installation and the post-installation tasks:

- Complete the [walkthrough tutorial](../walkthrough/index.md).

- Learn about the [OpenAPI UI](../swagger.md).

- Check [Understanding configuration](../../references/understandingconfig.md) once you are ready to tweak the default configuration so that you understand how to do it.

- Learn about [hosting static applications](../../references/usingdominorestapi/keepapplications.md#hosting-static-applications), often referred to as Single Page Applications (SPA) or browser apps. The [tutorial](../walkthrough/index.md) has [an example](../walkthrough/lab-07.md) that you can refer to.
<!--
## Installation

!!! note "**System requirements**"
      Before performing the installation, make sure to check the [System requirements](https://support.hcltechsw.com/csm?id=kb_article&sysparm_article=KB0101789).

### Download Domino REST API

!!!note
    **Starting Domino REST API version 1.0.9**, there will be four install files available for download. There will be two install files for Domino 12 and two install files for Domino 14. **For example**:

    For Domino 12

    - `Domino_REST_API_V1.0.9_R12_Docker.tar.gz`
    - `Domino_REST_API_V1.0.9_R12_Installer.tar.gz`
    
    For Domino 14

    - `Domino_REST_API_V1.0.9_R14_Docker.tar.gz`
    - `Domino_REST_API_V1.0.9_R14_Installer.tar.gz`

!!!warning "Important"
    - For **Domino customers**, download the Domino REST API via the [My HCLSoftware Portal](#via-my-hclsoftware-portal). 
    - For **Volt MX Go customers**, download the Domino REST API via [HCL Software License and Download Portal](#via-hcl-software-license-and-download-portal) or via [My HCLSoftware Portal](#via-my-hclsoftware-portal).

#### via My HCLSoftware Portal

1. Go to [My HCLSoftware Portal](https://my.hcltechsw.com/ "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../assets/images/external-link.svg){: style="height:15px;width:15px"}.

2. On the landing page, click **Sign in**.
3. On the sign-in page, log in using your credentials. 
4. On the **Software Downloads** page, click **HCL Domino**. 
5. On the **HCL Domino** page, go to the **Tools, Connectors, and Integrators** section and click **Domino REST API**.
6. Under **Releases**, click the release version you want to download. 
7. Under **Downloads**, click the **Direct download** icon corresponding to the file you want to download. 

#### via HCL Software License and Download Portal

1. Go to [HCL Software License and Download Portal](https://hclsoftware.flexnetoperations.com/ "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../assets/images/external-link.svg){: style="height:15px;width:15px"}.

2. On the sign-in page, enter your username and click **Next**. The **License & Download Portal** home page opens.
3. On the **License & Download Portal** home page, go to **Your Downloads** and search for and click **HCL Domino**. The **Download Packages** page opens.
4. On the **Download Packages** page under the **New Versions** tab, select the HCL Domino REST API version that you want to download.
5. On the **Software Terms and Conditions** page, click **I agree** for the **EULA Agreement**.
6. On the **Downloads** page, select the files to download and then click **Download Selected Files**, or click the file name of the file you want to download in the **File Name** column. 

    !!!note
        When downloading files for the first time by clicking **Download Selected Files**, you need to install the **Download Manager Interface** once. Follow the download and installation instructions. After installing the **Download Manager Interface**, you can resume your download.

--**Option 2**

1. Go to [HCL Software License and Download Portal](https://hclsoftware.flexnetoperations.com/ "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../assets/images/external-link.svg){: style="height:15px;width:15px"}.

2. On the sign in page, enter your username and click **Next**. The **License & Download Portal** home page opens.
1. Go to **Downloads** &rarr; **Search Downloads**.
2. On the **Download Search** page, enter `HCL Domino REST API` in the **Search for** field, and then click **Search**.
3. Select the HCL Domino REST API version that you want to download from the search result.
5. On the **Software Terms and Conditions** page, click **I agree** for the **EULA Agreement**.
6. On the **Downloads** page, select the files to download and then click **Download Selected Files**, or click the file name of the file you want to download in the **File Name** column.
-- 


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
-- Domino Server on [Kubernetes](../installconfig/helm.md)--

All platforms use a Java-based installer, except Kubernetes or Docker, which uses a container (colloquial referred to as Docker) image. You can download the installer and the Docker image from your HCL Software License and Download Portal or My HCLSoftware Portal account. For any questions, contact your HCL reseller.

!!! warning "You did shut down Domino, did you?"

    It is strongly recommended, that you shut down your Domino server before running the installer. The installer updates the `notes.ini` which could conflict with a running Domino server

The installer requires a series of parameters:

```bash
[sudo] java -jar restapiInstall.jar [-ahnsyV] -d=<dataDir> -i=<notesIni> -r=<restapiDir> -p=<programDir>
```

"jarfilename.md"


!!! tip
      Notes and Domino install a JVM on your computer. You can and should use it to install.

      - On Linux, `/opt/hcl/domino/notes/latest/linux/jvm/bin`
      - On Windows, `<Notes installation directory>/jvm/bin` (example: `Program Files/HCL/Notes/jvm/bin`)

      You can also verify the Java version by opening the command prompt, going to the installation location, and then typing `java -version`.

### Explanation of parameters

| Short | Full parameter | Mandatory | Description |
| :---: | ----- | :-------: | ----- |
| `-d`  | `--dataDir=<dataDir>`       |     ✓     | Directory of your HCL Notes or Domino data. |
| `-i`  | `--ini=<notesIni>`          |     ✓     | HCL Notes/Domino notes.ini file.                                                                                                                                                                                                                                                           |
| `-r`  | `--restapiDir=<restapiDir>` |     ✓     | Directory to install the Domino REST API files into.                                                                                                                                                                                                                                       |
| `-p`  | `--programDir=<programDir>` |     ✓     | Directory where HCL Notes or Domino is installed.                                                                                                                                                                                                                                          |
|       |                             |           |                                                                                                                                                                                                                                                                                            |
| `-u`  | `--upgrade`                 |           | Performs an upgrade from a previous version. Upgrade will remove known<br />program files and libraries from the rest API directory and install the new<br />version into the same directory.                                                                                              |
| `-f`  | `--forceUpgrade`            |           | Performs an upgrade without regard to the previous version. If an unknown<br />version or unexpected files are found in the rest API directory, this option will delete<br />the entire contents of the rest API directory and subdirectories first before installing<br/>the new version. |
| `-a`  | `--accept`                  |           | Automatically accept terms & conditions.                                                                                                                                                                                                                                                   |
| `-h`  | `--help`                    |           | Show this help message and exit.                                                                                                                                                                                                                                                           |
| `-n`  | `--noIniUpdates`            |           | Install the files, show updated ini entries but don't write them out. You are then responsible to update the [`notes.ini`](../../references/usingdominorestapi/restapitask.md) yourself, especially adding `restapi` to `servertasks` to auto-start the REST API                           |
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
|  7   | Upgrade aborted by user (missed the final **A** before proceeding with the upgrade).</br></br>To address the issue, make sure to type **A** before pressing **[Enter]** to proceed with the upgrade.|


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

## Configuration & Security

Domino REST API is preconfigured with settings that allow you to get started right away. It will run on **http** (not https) on port **8880**. However, you should familiarize yourself with all [configuration parameters](../../references/parameters.md) and [security](../../references/security/index.md) settings before you deploy into a production environment.


!!!tip
    Domino REST API honors all Domino access control mechanisms and doesn't allow anonymous access. For more information, see [Access Control](../../references/accesscontrol.md).

## Uninstall

Follow this [guide](../../howto/install/uninstall.md) to remove Domino REST API from your system.

## What to read next

- Complete the [walkthrough tutorial](../walkthrough/index.md).

- Learn about the [OpenAPI Swagger UI](../swagger.md).

- [Understanding configuration](../../references/understandingconfig.md), Once you are ready to tweak the default configuration, you need to understand how.

- [Hosting static applications](../../references/usingdominorestapi/keepapplications.md#hosting-static-applications), often referred to as Single Page Applications (SPA) or browser apps. The [tutorial](../walkthrough/index.md) has [an example](../walkthrough/lab-07.md).
-->