# Domino REST API task

On Domino servers, you can load the Domino REST API by running `load restapi` in the Domino server console. To ensure that the REST API starts automatically whenever the server starts, which is recommended for production environments, add `restapi` to the `ServerTasks` entry in the `notes.ini` file. The launch of the Domino REST API is governed by the `KeepInstallDir` setting in `notes.ini`, which is set by the Domino REST API installer.

<!-- prettier-ignore -->
!!! caution

    If you've configured `https` for the Domino REST API, modify the `notes.ini` setting `KeepManagementURL` to `https`. By default, this setting is `http://localhost:8889`. Not doing so will prevent the restapi task from starting.

<!--
## Domino REST API task commands*

Once the restapi task is loaded in the Domino console, you can use the following commands to interact:

|Command|Effect|
|:---|:---|
|`load restapi`|Starts the Domino REST API.|
|`tell restapi quit`|Ends the Domino REST API.|
|`tell restapi reload`|Restarts with new configuration.|
|`tell restapi [show] info`|Shows loaded components.|
|`tell restapi [show] config`|Shows current configuration.</br></br>You can add a JSON pointer parameter together with the console command to display specific configuration value instead of the entire JSON configuration. The parameter can be any first-level JSON key in the JSON configuration.</br></br>For example, running `tell restapi config oidc`, where `oidc` is the parameter, shows only the effective configuration for the *oidc* section of the configuration.|
|`tell restapi [show] status`|Shows version information and state.|
|`tell restapi refresh`|Refreshes Domino REST API with new configuration.<br/><br/> Once this command is issued, new incoming requests will be blocked, returning an HTTP Error 503 response. The existing queue of requests will be processed, and once completed, the new configuration will take effect, allowing new requests to be accepted.|
|`tell restapi idpstatus`|Shows the state of the configured identity providers.|
|`tell restapi support`|Creates a support package.|
|`tell restapi support -includensf`|Creates a support package, including the `KeepConfig.nsf`.|
|`tell restapi support -includedumps`|Creates a support package, including the Java Dump file, dump file of the active Java heap, and full dump file of the active JVM.|
|`tell restapi support -includensf -includedumps`|Creates a support package, including the `KeepConfig.nsf`, the Java Dump file, dump file of the active Java heap, and full dump file of the active JVM.|
|`tell restapi javadump`|Writes a Java Dump file to the data directory. The file contains human-readable information about the state of the Java Virtual Machine (JVM) and active threads, enabling developers and administrators to analyze and troubleshoot JVM behavior.|
|`tell restapi heapdump`|Writes a dump file of the active Java heap to the data directory. The file is written in IBM's Portable Heap Dump (PHD) format and contains information about all active objects in the JVM.|
|`tell restapi systemdump`|Writes a full dump file of the active JVM to the data directory. The file contains extensive information about the current Java state.|
|`tell restapi jfr start`|Starts Java Flight Recorder (JFR) profiling.|
|`tell restapi jfr stop`|Stops JFR profiling.|
|`tell restapi jfr dump`|Writes dump files that contain detailed JFR profiling information. These dump files are useful for diagnosing, analyzing, and troubleshooting the behavior of Java applications and the JVM.|

<!--|`tell restapi refresh cache [database] [application]`|Refreshes Domino REST API's database and application cache. Leave off optional parameters for both.|-->

## Domino REST API task commands

### Start and stop

Use these commands to start and stop the Domino REST API from the Domino server console.

|Command|Purpose|
|:---|:---|
|`load restapi`|Starts the Domino REST API.|
|`tell restapi quit`|Ends the Domino REST API.|

### View status and configuration

Use these commands to show status and configuration of the Domino REST API.

|Command|Purpose|
|:---|:---|
|`tell restapi [show] info`|Shows loaded components.|
|`tell restapi [show] config`|Shows the current active configuration as JSON.</br></br>You can filter the configuration output by adding a JSON pointer parameter. The parameter can be any first-level JSON key in the JSON configuration.</br></br>For example, running `tell restapi config oidc`, where `oidc` is the parameter, shows only the effective configuration for the *oidc* section of the configuration.|
|`tell restapi [show] status`|Shows version information and running state.|
|`tell restapi idpstatus`|Shows the state of the configured identity providers.|

### Dynamic refresh and restart

Use these commands for refreshing and restarting the Domino REST API from the Domino server console.

|Command|Purpose|
|:---|:---|
|`tell restapi refresh`|Refreshes Domino REST API with new configuration.<br/><br/>When issuing this command, new incoming requests will be blocked, returning an HTTP Error 503 response. The existing queue of requests will be processed, and once completed, the new configuration will take effect, allowing new requests to be accepted.|
|`tell restapi reload`|Restarts with new configuration.|

### Create support packages

Use these commands to generate support and diagnostic data.

|Command|Purpose|
|:---|:---|
|`tell restapi support`|Creates a support package.|
|`tell restapi support -includensf`|Creates a support package, including the `KeepConfig.nsf`.|
|`tell restapi support -includedumps`|Creates a support package, including the Java Dump file, dump file of the active Java heap, and full dump file of the active JVM.|
|`tell restapi support -includensf -includedumps`|Creates a support package, including the `KeepConfig.nsf`, the Java Dump file, dump file of the active Java heap, and full dump file of the active JVM.|

These commands help collect logs and configuration when troubleshooting issues.

### Console diagnostics

Use these commands when deeper troubleshooting is needed so you can generate various diagnostics dumps.

|Command|Purpose|
|:---|:---|
|`tell restapi javadump`|Writes a Java Dump file to the data directory. The file contains human-readable information about the state of the Java Virtual Machine (JVM) and active threads, enabling developers and administrators to analyze and troubleshoot JVM behavior.|
|`tell restapi heapdump`|Writes a dump file of the active Java heap to the data directory. The file is written in IBM's Portable Heap Dump (PHD) format and contains information about all active objects in the JVM.|
|`tell restapi systemdump`|Writes a full dump file of the active JVM to the data directory. The file contains extensive information about the current Java state.|

### JFR profiling commands

Use these commands to start and stop Java Flight Recorder (JFR) profiling and generating diagnostic dumps.

|Command|Purpose|
|:---|:---|
|`tell restapi jfr start`|Starts JFR profiling.|
|`tell restapi jfr stop`|Stops JFR profiling.|
|`tell restapi jfr dump`|Writes dump files that contain detailed JFR profiling information. These dump files are useful for diagnosing, analyzing, and troubleshooting the behavior of Java applications and the JVM.|

## Domino REST API settings for notes.ini

### Settings for notes.ini

The following are settings that can be set in the `notes.ini`.

| Setting | Requirement | Description |
| :--- | :---- | :---- |
| `KeepInstallDir` | required | Where Domino REST API is installed |
| `KeepJavaHome` | optional | Use a different Java binary than the one in {dominoBin}/jvm |
| `KeepManagementURL` | optional | Domino REST API management URL if different than http://localhost:8889 |
| `KeepNumAttachAttempts` | optional | Number of attempts to get status of Domino REST API launch (default 10). There is a 3-second interval between attempts. |
| `KeepLaunchWaitSecs` | optional | Number of seconds to wait before executing java command (default 0) |

### Reserved settings for notes.ini

The following are reserved settings that should only be used when directed by Support.

| Setting | Requirement | Description |
|:---|:---|:---|
| `KeepLogConfigFile` | optional | Path to an alternate [Log4j2](https://logging.apache.org/log4j/2.x/index.html) configuration file |
| `KeepCurlLogging` | optional | default `false`, prints curl commands to console |
| `KeepAddinLogging` | optional | default `false`, prints debug statements for the restapi task |
| `KeepJavaHeapInMB` | optional | Amount of heap memory in Megabytes that should be allocated to Domino REST API. |

!!! danger "Keep the `KeepManagementURL` parameter current"

    When configuring the REST API to use [TLS directly](../../howto/production/httpsprod.md), you need to update `KeepManagementURL` to use `https://` and the domain name your TLS certificate is issued to.
