# Domino REST API task

On Domino servers, Domino REST API can be loaded using `load restapi` in the Domino server console.

To automatically start the Domino REST API on server start, the mode of operation you want for a production system, add `restapi` to the values of the `notes.ini` entry `ServerTasks`.

The launch of the Domino REST API is governed by the `notes.ini` key `KeepInstallDir`, which is set by the Domino REST API installer.

<!-- prettier-ignore -->
!!! caution
    If you've configured `https` for the Domino REST API, modify the `notes.ini` setting `KeepManagementURL` to `https`. By default, this setting is `http://localhost:8889`. Not doing so will prevent the restapi task from starting.

## Domino REST API task commands

Once the restapi task is loaded in the Domino console, you can use the following commands to interact:

|Command|Effect|
|:---|:---|
|`load restapi`|Starts the Domino REST API.|
|`tell restapi quit`|Ends the Domino REST API.|
|`tell restapi reload`|Restarts with new configuration.|
|`tell restapi [show] info`|Shows loaded components.|
|`tell restapi [show] config`|Shows current configuration.|
|`tell restapi [show] status`|Shows version information and state.|
|`tell restapi refresh`|Refreshes Domino REST API with new configuration.<br/><br/> Once this command is issued, new incoming requests will be blocked, returning an HTTP Error 503 response. The existing queue of requests will be processed, and once completed, the new configuration will take effect, allowing new requests to be accepted.|
|`tell restapi idpstatus`|Shows the state of the configured identity providers.|
|`tell restapi support`|Creates a support package.|
|`tell restapi support -includensf`|Creates a support package, including `KeepConfig.nsf`.|
|`tell restapi javadump`|Writes a Java Dump file to the data directory. The file contains human-readable information about the state of the Java Virtual Machine (JVM) and active threads, enabling developers and administrators to analyze and troubleshoot JVM behavior.|
|`tell restapi heapdump`|Writes a dump file of the active Java heap to the data directory. The file is written in IBM's Portable Heap Dump (PHD) format and contains information about all active objects in the JVM.|
|`tell restapi systemdump`|Writes a full dump file of the active JVM to the data directory. The file contains extensive information about the current Java state.|

<!--|`tell restapi refresh cache [database] [application]`|Refreshes Domino REST API's database and application cache. Leave off optional parameters for both.|-->

The following are settings that can be set in the notes.ini

| Setting                 | Requirement | Description                                                                                       |
| ----------------------- | ----------- | ------------------------------------------------------------------------------------------------- |
| `KeepInstallDir`        | required    | Where Domino REST API is installed                                                                |
| `KeepJavaHome`          | optional    | Use a different Java binary than the one in {dominoBin}/jvm                                       |
| `KeepManagementURL`     | optional    | Domino REST API management URL if different than http://localhost:8889                            |
| `KeepNumAttachAttempts` | optional    | Number of attempts to get status of Domino REST API launch (default 10). There is a 3-second interval between attempts.  |
| `KeepLaunchWaitSecs`    | optional    | Number of seconds to wait before executing java command (default 0)                               |
| **RESERVED**            |             | Only use when directed by support                                                                 |
| `KeepLogConfigFile`     | optional    | Path to an alternate [Log4j2](https://logging.apache.org/log4j/2.x/index.html) configuration file |
| `KeepCurlLogging`       | optional    | default `false`, prints curl commands to console                                                  |
| `KeepAddinLogging`        | optional    | default `false`, prints debug statements for the restapi task                                      |
| `KeepJavaHeapInMB`        | optional    | Amount of heap memory in Megabytes that should be allocated to Domino REST API.                                     |


!!! danger "Keep the KeepManagementURL parameter current"

    When configuring the REST API to use [TLS directly](../../howto/production/httpsprod.md) you need to update `KeepManagementURL` to use `https://` and the domain name your TLS certificate is issued to
