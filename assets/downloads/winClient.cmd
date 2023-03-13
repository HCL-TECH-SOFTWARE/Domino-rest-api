@echo off
REM Command file to start KEEP task on a Notes client
REM Program Directory {{programDir}}
REM KEEP Directory {{keepDir}}
REM Data directory {{dataDir}}
SET DEBUG=false
SET SHUTDOWNKEY=The End is near!!
SET DOMINO_HOME={{programDir}}
SET NOTESROOT={{programDir}}
SET JAVA_HOME={{programDir}}\jvm
SET KEEP_HOME={{keepDir}}
SET NOTESDATA={{dataDir}}
SET DYLD_LIBRARY_PATH=%DOMINO_HOME%
SET LD_LIBRARY_PATH=%DOMINO_HOME%
SET V_PATH="{{keepDir}}\*";"{{keepDir}}\libs\*"
SET PATH="{{programDir}}";"{{keepDir}}";%PATH%
SET CLASSPATH=.;%V_PATH%;%CLASSPATH%
SET NOTES_ENV=CLIENT
SET LOG_DIR=%NOTESDATA%\logs
IF NOT EXIST "%LOG_DIR%\*" MD "%LOG_DIR%"

cd "%NOTESDATA%"
REM Actual starting KEEP
START "" "%JAVA_HOME%\bin\java" -XX:+HeapDumpOnOutOfMemoryError -XX:+UseG1GC -XX:+UseStringDeduplicationJVM -Djna.library.path="{{programDir}}" -Djava.library.path="{{programDir}}" -cp %CLASSPATH% com.hcl.domino.keep.Launch 
echo.
echo "Keep start on its way"
echo.