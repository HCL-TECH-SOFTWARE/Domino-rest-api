---
layout: default
title: Setting up Eclipse
parent: Development Environment
grand_parent: Extending Domino REST API
nav_order: 6
---

This section describes how to install Eclipse, and set it up as a Domino REST API development environment.

Note: Eclipse is a popular choice for IDE as it has a rich and extensible feature set, and is familiar to many team members. That said, since Domino REST API is Maven based and built from the command line, it does not require any one IDE. Other choices worth investigating include:

- [IntelliJ](https://www.jetbrains.com/idea/)
- [VSCode](https://code.visualstudio.com/) with Java plugins

### Installing Eclipse

Begin by downloading and installing the 64 bit version of Eclipse from Eclipse.org. Use [the offical downlaods page](https://www.eclipse.org/downloads/) to get your version

Once you have Eclipse properly installed, select: **File / Import...** from the top level menu to bring up the Import dialog:

![EclipseImport](../../assets/images/EclipseImport.png)
&nbsp;
&nbsp;

1. Select **Existing Maven Projects** as shown above and click **Next**.

2. Click the **Browse...** button and select your **domino-keep** directory, and click **Finish** to import it. You should now see the Domino REST API source code in your Package Explorer.

### Configuring Java

If you haven't already, take a moment now to install the OpenJdk version of Java 8. Instructions are here:

**[Setup Java 8](setupjava.md)**

You will need to setup two versions of Java for your development environment: To Run Domino REST API successfully the Notes or Domino JVM is required. To run a successful Maven build, the Domino JVM is
insufficient, since Maven requires a true JDK, as found in OpenJdk 8.

For Eclipse it could look like this:

![Eclipse 1](../../assets/images/eclipse1.png)

![Eclipse 2](../../assets/images/eclipse2.png)

### Debugging Domino REST API within Eclipse

Once you have a Debug Configuration properly set up, it is very easy to debug Domino REST APIs within Eclipse.

To get started, select **Run** \ **Debug Configurations...** from the top menu.

Next right click on **Java Application** and select **New Configuration**:

1. Give your configuration a name, **Domino REST API Server** in this case, and set **Project** to **com.hcl.domino.keep** and **Main Class** to **com.hcl.domino.keep.Launch**

![Debug Configuration](../../assets/images/DebugConfiguration.png)

2. Switch to the **Arguments** tab and provide the following arguments (one per line)

- `-XX:+HeapDumpOnOutOfMemoryError`
- `-XX:+UseG1GC`
- `-XX:+UseStringDeduplicationJVM`

Set the **Working directory** to your **Notes DATA directory** (And if your data directory on Windows is below `Program Files...` or on Linux below `/opt` a kitten must die each time you launch!)

![Debug Configuration 2](../../assets/images/DebugConfiguration2.png)

3. Switch to the **JRE** tab and select **Alternate JRE**. Select the Notes 11 JRE you created above from the dropdown list. (Using the Notes 11 JRE will allow Eclipse to resolve Notes and Domino classes.)

![Debug Configuration 3](../../assets/images/DebugConfiguration3.png)

4. Now switch to your **Classpath** tab. You should see a layout like the one below, with the Notes 11 JRE on your classpath.

![Debug Configuration 4](/assets/images/DebugConfiguration4.png)

5. Next switch to your **Environment** tab, and enter the environment variables shown below. Of course you will need to adjust the Notes path to match your system.

- `DEBUG` = `true`
- `DYLD_LIBRARY_PATH` = `/Applications/HCl Notes.app/Contents/MacOS`
- `LD_LIBRARY_PATH` = `/Applications/HCl Notes.app/Contents/MacOS`
- `GodMode` = `true`
- `JwtDuration` = `360`
- `LOG_DIR` = `${project_loc}/target/logs`

**NOTE** Entries are **CaSe SeNsItIvE**

When you have a valid SSL cert, you also might need

- `TLSFile` = `somekey.pfx`
- `TLSPassword` = `geheim`

![Debug Configuration 5](../../assets/images/DebugConfiguration5.png)

5. When you're done, remember to hit **Apply**, and you should be good to go.

6. When you wish to start debugging, select **Run** \ **Debug Configurations...** from the top menu. Make sure your Domino REST API Debug configuration is selected (**Domino REST API Server** in this example), and press **Debug** to begin debugging. If you've done everything correctly you should see **Project Domino REST API open for business** at the bottom of the console window.

**Note** There is a separate setting for debugging [a Domino REST API server in a container](../../installconfig/installation/docker).

### Java editor preferences

Before you use Eclipse to edit and submit code, you should import two XML files that help to enforce good coding practices.

1. Select **Window / Preferences** from the top level menu.

2. In the Preferences dialog, select **Java / Code Style / Clean Up**.

3. Next select the **Import** button in the right panel and import **CodeCleanupSettings.xml** from your domino-keep directory.

4. Make sure **stw.default** is now set as your active profile.

5. Now select **Java / Code Style / Formatter** and import **eclipse-java-google-style** from your domino-keep directory.

6. Make sure **GoogleStyle** is now set as your active profile. Click **Apply and Close** to save your settings.

Now the next time you edit a Java file, you can take advantage of four commands on the **Source** menu:

**Correct Indentation: Control I**

**Format: Control Shift F**

**Format Element**

**Cleanup...**
