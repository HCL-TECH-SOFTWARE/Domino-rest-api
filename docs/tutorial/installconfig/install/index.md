# Install Domino REST API

Guides you through the procedures for installing Domino REST API.

## Installation steps

1. [Check system requirements](https://support.hcltechsw.com/csm?id=kb_article&sysparm_article=KB0101789)

    Before starting the installation, make sure that you check the [system requirements](https://support.hcltechsw.com/csm?id=kb_article&sysparm_article=KB0101789).

2. [Download Domino REST API](downloaddrapi.md)
<!--
    - For **Domino customers**, you can download the Domino REST API via [My HCLSoftware Portal](../install/downloaddrapi.md#download-via-my-hclsoftware-portal).
    - For **Volt MX Go and other customers**, you can download the Domino REST API via [HCL Software License and Download Portal](../install/downloaddrapi.md#download-via-hcl-software-license-and-download-portal) or via [My HCLSoftware Portal](../install/downloaddrapi.md#download-via-my-hclsoftware-portal).
-->
3. Install Domino REST API on:

    - Domino Server on [Linux](linux.md)
    - Domino Server or Notes Client on [Windows](win.md)
    - Notes Client on [macOS](mac.md)
    - Domino Server on [Docker](docker.md)

## Additional references

The following references provide useful information necessary in the installation of Domino REST API.

### Installation command parameters

The table shows the command parameters used when installing Domino REST API on Linux, Windows, or macOS. You can find the short and full versions of the parameters, their description, and whether they're mandatory or not.

??? tip "Expand to see the explanation of the installation command parameters"

    --8<-- "installparameters.md"

### Use of response file

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

### Installation return codes

The table shows the installation return codes and their corresponding explanation.

??? tip "Expand to see the installation return codes"

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
