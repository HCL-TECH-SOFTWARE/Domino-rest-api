# Update Domino REST API to the latest release version

## About this task
The procedure guides you on how to update your installed Domino REST API to the latest release version. It's recommended to always update to the latest release version to take advantage of the new features and improvements of Domino REST API. 

## Prerequisite

- When updating installed Domino REST API on Linux, Mac, or Windows, [download the latest release version of the Domino REST API multi-platform installer](../../tutorial/installconfig/index.md#download-domino-rest-api). <!--from [HCL Software License and Download Portal](https://hclsoftware.flexnetoperations.com/) (Flexnet).-->
- When updating Domino REST API running with Docker image:

    - [Download the docker image of the latest release version of Domino REST API](../../tutorial/installconfig/index.md#download-domino-rest-api) <!--from [HCL Software License and Download Portal](https://hclsoftware.flexnetoperations.com/) (Flexnet)-->.

    **OR**

    - Take note of the latest Docker image version for docker compose `.env` file from Harbor in [What’s New](../../references/whatisnew.md).

## Procedure

Follow the procedure based on the installation option you used when installing the existing version of your Domino REST API. 
 
!!!note
    For more information on the parameters used for updating Domino REST API in Linux, Mac, and Windows, see [Explanation of parameters](../../tutorial/installconfig/index.md#explanation-of-parameters). 

### Docker

1. Remove the existing docker container.
2. If using the docker image from *HCL Software License and Download Portal (Flexnet)* or *My HCLSoftware Portal*, load the docker image using the following command: 
    
    ```bash
	docker load -i [name_of_tar_file].tar
    ```

    !!!note
        - Make sure you [extract the tar.gz file](https://linuxize.com/post/how-to-extract-unzip-tar-gz-file/) first.
        - This step isn't applicable if using the docker image from Harbor. 

3.	Take note of the image name.

    - When using the docker image from *HCL Software License and Download Portal (Flexnet)* or *My HCLSoftware Portal*, take note of the image name that was output after being loaded. The image name is also indicated in the [What’s New](../../references/whatisnew.md) for each version of the Domino REST API and marked *Docker image version for docker compose .env file (CONTAINER_IMAGE)*.
  	
        !!!example "Example loaded image name" 
            - From earlier releases: `docker.qs.hcllabs.net/hclcom/projectkeep-r12:1.10.0`
            - Starting v1.0.7 release: `domino-rest-api:1.0.7`
    
    - When using the docker image from *HCL Container Repository (Harbor)*, take note of the latest *Docker image version for docker compose .env file from Harbor* indicated in [What’s New](../../references/whatisnew.md).

        !!!example "Example image version name"
            hclcr.io/domino/restapi:1.0.6 

4.	Update the value of the `CONTAINER_IMAGE` variable in your existing .env file with the noted Docker image name. 

    !!!note
        It's recommended to use your existing .env file, but you can also use a new .env file. If you use a new .env file, make sure to update the variable values as needed. 

5.	Run the following command in the directory where you stored the `server.id` and `docker-compose.yml` files, which you used in your initial installation.

    ```bash
    docker-compose up
    ```

    !!!note
        If prompted for access to HCL Container Repository (Harbor), [obtain your HCL Container Repository username and password](../../howto/install/obtainauthenticationtoken.md), and then sign-in using `docker login hclcr.io` command and the obtained credentials. 

6.	[Validate that an instance is successfully running on a container](../../tutorial/installconfig/docker.md#validation).

<!--### Helm

1. Run the following to recreate the temporary directory to download the helm charts and make it the current directory:

    **Command**:
    ```
    mkdir ~/<new directory name>
    cd ~/<new directory name>
    ```

    **Example**:

    ```
    mkdir ~/drapi108
    cd ~/drapi108
    ```
    In the example above, you create a new directory *drapi108* that will contain the new helm charts. Creating the new directory allows you to differentiate and compare the helm charts from different Domino REST API release versions.

2. Configure Helm to pull from HCL Container Repository.

    You will need your email and authentication token used with the HCL Container Repository.

    1. Run the following command to check if *hclcr* is already defined:

        ```
        helm repo list
        ```

    2. If *hclcr* is already defined, proceed to **Download Domino REST Helm chart** step. Otherwise, run the following command to set up Helm.

        ```
        helm repo add hclcr https://hclcr.io/chartrepo/domino --username <your hclcr username> --password <your hclcr password>
        ```

        Example
        ```
        helm repo add hclcr https://hclcr.io/chartrepo/domino --username user.name@example.com --password xx3ds2w
        ```

3. Download Domino REST API Helm chart.

    1. Run the following command to make sure that the chart information for the repositories is up-to-date.

        ```
        helm repo update
        ```

    2. Run the following command to download the chart:

        ```
        helm pull hclcr/restapi
        ```

        The file drapi-1.n.n.tgz is downloaded, wherein 1.n.n represents the version number such as 1.0.7.

    3. Run the following commands to unpack the chart and make the DRAPI directory your current directory:

        ```
        tar -xzvf drapi-1.n.n.tgz
        cd drapi
        ```

        !!!note
            The Domino REST API chart name has a version string in the filename. The helm pull command will pull down the latest version of the charts. Ensure your tar command uses the correct matching file names.

4. Update the `values.yaml` file of the target upgrade version with custom settings you want to apply from the `values.yaml` file of your current installation.

5. Within the directory containing the new Domino REST API charts, run the following command:

    ```
    helm upgrade domino . -f values.yaml
    ```

    This upgrades the program executables and reuses the existing databases and all the configuration stored on /local/notesdata within the Domino container.

6. Run the following command to wait for the Domino pod to be running and in the ready state:

    ```
    kubectl get pods -o wide -w
    ```
-->
### Linux

!!!note
    - Don't install using the java executable in `/opt/hcl/domino/bin/`. 
    - If your system doesn't have Java installed, you can use the java executable in the `/opt/hcl/domino/notes/latest/linux/jvm/bin/` directory.

To update to the latest release version, run the following command:

--8<-- "jarfilename.md"

```bash
sudo java -jar restapiInstall.jar \ 
 -d="/local/notesdata" \ 
 -i="/local/notesdata/notes.ini" \ 
 -r="/opt/hcl/restapi" \ 
 -p="/opt/hcl/domino/notes/latest/linux" \ 
 -u \
 -a
```

### Mac

To update to the latest release version, run the following command:

--8<-- "jarfilename.md"

```bash
java -jar restapiInstall.jar \ 
 -d="/Users/[your user name]/Library/Application Support/HCL Notes Data" \ 
 -i="/Users/[your user name]/Library/Preferences/Notes Preferences" \ 
 -r="/Users/[your user name]/Applications/restapi" \ 
 -p="/Applications/HCL Notes.app" \ 
 -u \
 -a
```

!!!note
    For more information on the installation-related support and limitations to client use, see [Install on Mac](../../tutorial/installconfig/mac.md). 


### Windows

To update to the latest release version, run the following command:

!!!note
    Domino REST API installer needs to be run as administrator.


--8<-- "jarfilename.md"

**For Windows Domino Server**

```bash
java -jar restapiInstall.jar ^ 
 -d="C:\Program Files\HCL\Domino\Data" ^ 
 -i="C:\Program Files\HCL\Domino\notes.ini" ^ 
 -p="C:\Program Files\HCL\Domino" ^ 
 -r="C:\Program Files\HCL\Domino\restapi" ^ 
 -u ^
 -a
```

**For Windows Notes Client**

```bash
java -jar restapiInstall.jar ^
 -d="C:\Program Files\HCL\Notes\Data" ^
 -i="C:\Program Files\HCL\Notes\notes.ini" ^
 -r="C:\Program Files\HCL\Notes\restapi" ^
 -p="C:\Program Files\HCL\Notes" ^
 -u ^
 -a
```

When running the command for Windows Notes Client, the installer creates a `runrestapi.cmd` script in the Domino REST API installation directory. Run it to launch the Domino REST API.

!!!note
    For more information on the installation-related support and limitations to client use, see [Install on Windows](../../tutorial/installconfig/win.md). 

