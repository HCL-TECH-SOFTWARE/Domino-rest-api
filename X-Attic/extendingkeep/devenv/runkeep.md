---
layout: default
title: Running the Domino REST API
parent: Development Environment
grand_parent: Extending Domino REST API
nav_order: 9
---

This section describes how to run the Domino REST APIs against your local copy of Notes Domino.

### Installing the Domino REST API jar file

First create a **Domino REST API** folder under the Notes Data directory (for example: c:\Notes\data\keep)

Next find a version of the project Domino REST API jar, **projectkeep.jar**.

### Configuring the Domino REST API

Once the jar file is in place, you will need to configure two environment variables:

Add a new variable called DYLD_LIBRARY_PATH and point it to your Notes root directory (for example: c:\Notes).

![DYLD Path](../../assets/images/DYLDPath.png)

Next under **System variables**, edit the **Path** variable and add a new entry pointing your Notes root directory (for example: c:\Notes).

![Update Path](../../assets/images/UpdatePath.png)

### Sttarting the  Domino REST API

1. Get the file "demo.nsf" from the [Downloads](../../references/downloads.md) and copy it to your Notes data folder (for example: c:\notes\data).

2. Next get the file **windows_run_keep.cmd** from the domino-keep repo [TODO Link](#) and copy it to your new Domino REST API folder (for example c:\Notes\data\keep)

3. Edit **windows_run_keep.bat** and set **GodMode** to true (SET GodMode=true) which will skip calling the Notes createsession code. If set to false, the createsession call will fail since Notes is not a server.

4. Now you're ready to start Domino REST API by double-clicking on **windows_run_keep.bat** in Windows Explorer or by opening a Command window and executing it from your Domino REST API directory.

### Configuring a test user

1. If you haven't run Domino REST API yet, do that now (step 4 above). Running Domino REST API will create the Domino REST API Configuration (KeepConfig.nsf) if it doesn't already exist.

2. Open KeepConfig.nsf with your Notes client:

![Domino REST API Config](../../assets/images/KeepConfig.png)

3. Now select the user **John Doe** and click the **Set available** button at the top of the screen. This will ensure that the user is available for testing.

![John Doe](../../assets/images/JohnDoe.png)

### Validating your installation

1. Run [Swagger against your Domino REST API](http://localhost:8880/openapi/index.html) installation.
2. Assuming everything has been set up correctly, you should see the Domino REST APIs and be able to run them.
