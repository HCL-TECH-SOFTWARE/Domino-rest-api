<!--!!! tip "Check that the REST API is running"-->
The installation, unless told otherwise, added `restapi` to the `servertasks` in the `notes.ini`. You can check on the Domino console if the REST API is running by using `sh ta`. In case `restapi` isn't listed as a running task, load it using `load restapi`. The Domino console will output a message on the success or failure to load.
