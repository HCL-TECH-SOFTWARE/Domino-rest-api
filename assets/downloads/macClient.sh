#!/bin/bash
# MacOS Keep Starter file
# Program Directory {{programDir}}
# KEEP Directory {{keepDir}}
# Data directory {{dataDir}}
clear
export NOTES_DIR={{dataDir}}
export LOG_DIR=$NOTES_DIR/logs
mkdir -p $LOG_DIR
# Local Keep Server
export DEBUG=true
export PATH={{programDir}}/Contents/MacOS:$PATH
export JAVA_HOME={{programDir}}/Contents/jre/Contents/Home
export KEEP_HOME={{keepDir}}
export JVM_OPTIONS='-XX:+HeapDumpOnOutOfMemoryError -XX:+UseG1GC -XX:+UseStringDeduplicationJVM'
export V_PATH={{keepDir}}/*.jar:{{keepDir}}/libs/*
export CLASSPATH=.:$V_PATH:$CLASSPATH
export PATH={{programDir}}:$PATH
export DYLD_LIBRARY_PATH={{programDir}}/Contents/MacOS
export LD_LIBRARY_PATH={{programDir}}/Contents/MacOS
cd "{{dataDir}}"
"$JAVA_HOME/bin/java" $JVM_OPTIONS -cp $CLASSPATH com.hcl.domino.keep.Launch &
osascript -e "tell application \"Terminal\" to do script \"tail -f \" & the quoted form of \"$LOG_DIR/$LOG_FILENAME\""
echo "\n\n\n Shutdown:"
read -p "Press enter to shut down local KEEP"
curl --max-time 10 --location --request \
POST 'http://localhost:8889/shutdown' \
--header 'Content-Type: application/json' \
--data '{"shutdownkey" : "The End is near!!"}'
cd ~
echo Done!