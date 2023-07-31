# Update Domino REST API to the latest release version

## About this task
The procedure guides you on how to update your installed Domino REST API to the latest release version. It's recommended to always update to the latest release version to take advantage of the new features and improvements of Domino REST API. 

## Prerequisite

- When updating installed Domino REST API in Linux, Mac, or Windows, download the latest release version of the Domino REST API multi-platform installer from [HCL Software License and Download Portal](https://hclsoftware.flexnetoperations.com/).
- When updating Domino REST API running with Docker image:

    - Download the docker image of the latest release version of Domino REST API from [HCL Software License and Download Portal](https://hclsoftware.flexnetoperations.com/).

    **OR**

    - Take note of the latest Docker image version for docker compose `.env` file from Harbor in [What’s New](../../references/whatisnew.md).

## Procedure

Follow the procedure based on the installation option you used when installing the existing version of your Domino REST API. 
 
!!!note
    For more information on the parameters used for updating Domino REST API in Linux, Mac, and Windows, see [Explanation of parameters](../../tutorial/installconfig/index.md#explanation-of-parameters). 

### Docker

1. Remove the existing docker container.
2. If using the docker image from FlexNet, load the docker image using the following command: 
    
    ```bash
	docker load -i [name_of_tar_file].tar
    ```

    !!!note
        Make sure you [extract the tar.gz file](https://linuxize.com/post/how-to-extract-unzip-tar-gz-file/) first.

3.	Take note of the image name.

    - When using the docker image from *HCL Software License and Download Portal*, take note of the image name that got installed or the latest *Docker image version for docker compose .env file (CONTAINER_IMAGE)* indicated in [What’s New](../../references/whatisnew.md).
  	
        !!!example "Example loaded image name" 
            docker.qs.hcllabs.net/hclcom/projectkeep-r12:1.10.0
    
    - When using the docker image from Harbor, take note of the latest *Docker image version for docker compose .env file from Harbor* indicated in [What’s New](../../references/whatisnew.md).

        !!!example "Example image version name"
            hclcr.io/domino/restapi:1.0.6 

4.	Update the value of the `CONTAINER_IMAGE` variable in your existing .env file with the noted Docker image name. 

    !!!note
        It's recommended to use your existing .env file, but you can also use a new .env file. If you use a new .env file, make sure to update the variable values as needed. 

5.	Run the following command in the directory where you stored the `server.id` and `docker-compose.yml` files, which you used in your initial installation.

    ```bash
    docker-compose up
    ```

6.	[Validate that an instance is successfully running on a container](../../tutorial/installconfig/docker.md#validation).

### Linux

!!!note
    - Don't install using the java executable in `/opt/hcl/domino/bin/`. 
    - If your system doesn't have Java installed, you can use the java executable in the `/opt/hcl/domino/notes/latest/linux/jvm/bin/` directory.

To update to the latest release version, run the following command:

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

