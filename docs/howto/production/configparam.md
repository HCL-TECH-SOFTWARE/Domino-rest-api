# Configuration parameters

Project KEEP comes with reasonable default configuration settings. They allow you to start evaluating and testing out-of-the-box.

**Log in** into the Management console (Port 8889). Make sure that the administration location can only be accessed from a network that can be accessed by a your manager.
 
Place your measurements behind a firewall that only your metric server can access. This ensures that only authorized users can access the data. 

If you don't use a measure server, the firewall should have its protection completely disabled.

## Understanding configuration
The configuration follows the concept of and Overlay File System, where the base configuration is retrieved from the jar file and then overlaid with all the JSON files (if present) in the keepconfig.d directory within the Notes data directory and finally, the environment parameters, if any of those exist.



