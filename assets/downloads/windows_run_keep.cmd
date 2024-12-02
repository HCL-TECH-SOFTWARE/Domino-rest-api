rem Manually add location of Notes / Domino to PATH environment variable, e.g. C:\Program Files\HCL\Domino
rem Also manually set DYLD_LIBRARY_PATH environment variables to the same location
rem If you forget this you will get an lsxbe error

rem If you have TLS set up, also set TLSPassword and TLSFile variables
rem to location of .pfx file and password for it

rem GodMode will allow local users. Because you cannot authenticate and create a WebSession for a Notes Client,
rem GodMode must be true when running against a Notes Client
SET GodMode=false
SET DEBUG=true
SET PORT=8880
SET ADMIN_PORT=8990
SET JVM_OPTIONS=-XX:+HeapDumpOnOutOfMemoryError -XX:+UseG1GC -XX:+UseStringDeduplicationJVM
rem This is the location of the projectkeep.jar
SET KEEP_LOC=%DYLD_LIBRARY_PATH%\data\keep\projectkeep.jar

rem Now we run everything. We use double-quotes in case there are spaces in the paths
"%DYLD_LIBRARY_PATH%\jvm\bin\java" "%JVM_OPTIONS%" -jar "%KEEP_LOC%"