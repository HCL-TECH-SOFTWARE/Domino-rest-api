#!/bin/bash
# MacOS Keep Starter file
# Keep locations - update as needed - leave the TLS stuff empty if you don't have it
clear
export NOTES_DIR=$HOME/Library/Application\ Support/HCL\ Notes\ Data
export KEEPJAR=keep/projectkeep.jar
export LOG_DIR=$NOTES_DIR/logs
export LOG_FILENAME=projectkeep.log
# export TLSFile=some.pfx
# export TLSPassword=password
# Delete old logs - comment out if you don't like it
mkdir -p $LOG_DIR
rm -- "$LOG_DIR/$LOG_FILENAME"
# Local Keep Server
export DEBUG=true
export PATH=/Applications/HCL\ Notes.app/Contents/MacOS:$PATH
export JAVA_HOME=/Applications/HCL\ Notes.app/Contents/jre/Contents/Home
export JVM_OPTIONS='-XX:+HeapDumpOnOutOfMemoryError -XX:+UseG1GC -XX:+UseStringDeduplicationJVM'
export GodMode=true
export DYLD_LIBRARY_PATH=/Applications/HCL\ Notes.app/Contents/MacOS
export LD_LIBRARY_PATH=/Applications/HCL\ Notes.app/Contents/MacOS
echo $LD_LIBRARY_PATH ..
cd -- "$NOTES_DIR"
"$JAVA_HOME/bin/java" $JVM_OPTIONS -jar $KEEPJAR &
osascript -e "tell application \"Terminal\" to do script \"tail -f \" & the quoted form of \"$LOG_DIR/$LOG_FILENAME\""
echo "\n\n\n Shutdown:"
read -p "Press enter to shut down local KEEP"
curl --max-time 10 --location --request \
POST 'http://localhost:8889/shutdown' \
--header 'Content-Type: application/json' \
--data '{"shutdownkey" : "The End is near!!"}'
cd ~
echo Done!