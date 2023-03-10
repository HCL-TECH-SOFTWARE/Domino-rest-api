# Domino REST API CLI

A simple shell script using the curl command is all you need to interact with Domino REST API.

Create the following shell script (macOS, Linux - Windows version below) in your `~/bin` directory and enable itm using `chmod +x Domino REST API`

I like to skip the `.sh` extension, makes calling the command similar to Windows `.cmd` files.

```bash
#!/bin/bash
# Simple keep command line
#Global variables
httpcommand=$(echo "$1" | tr '[:lower:]' '[:upper:]')
keep=https://frascati.projectkeep.io
user="Doctor Notes"
apipath=api

# Login function
execute_login() {
   # Login to KEEP remote
   read -p "server [$keep]:" server
   read -p "Username [$user]: " uservar
   read -sp "Password: " passvar
   server=${server:-$keep}
   uservar=${uservar:-$user}
   echo
   echo accessing $server as $uservar
   echo
   dataraw="{\"username\" : \"${uservar}\", \"password\" : \"${passvar}\"}"
   token=$(curl --location --request POST "${server}/api/v1/auth" \
   --header 'Content-Type: application/json' \
   --data-raw "${dataraw}" |  jq -r  '.bearer')
   echo $token
   echo token=$token > $TMPDIR/keep.login
   echo server=$server >> $TMPDIR/keep.login
   exit 0
}

# Logout, just remove the token
execute_logout() {
    echo User logged out > $TMPDIR/keep.login
    rm -f $TMPDIR/keep.login
    echo User logged out
    exit 0
}

# Make a call to keeep
execute_http() {
if [ ! -f $TMPDIR/keep.login ]; then
	echo "You need to login first with keep login"
	exit 1
fi
export $(cat $TMPDIR/keep.login | xargs)
 httpcommand=$(echo "$1" | tr '[:lower:]' '[:upper:]')
 shift
 curl -s -X ${httpcommand} --fail --insecure -H "Authorization: Bearer ${token}" -H "Content-Type: application/json" ${server}/${apipath}/$@
 if [ $? -ne 0 ]; then
   echo "Command $httpcommand failed!"
   exit 1
 fi
 exit 0
}

execute_help() {
  echo "Usage keep [login|logout|help]"
  echo "      keep [get|post|put|patch|delete] URL PAYLOAD"
  echo " e.g. keep login"
  echo "      keep get v1/scopes"
  echo "      keep get pim-v1/inbox"
  echo "Hints:"
  echo '      "keep get" without parameters - returns list of APIs'
  echo "      common APIs: v1,admin-v1,pim-v1,poi-v1,setup-v1"
  echo '      "keep get [api]/schema/[schema-json-fiel from keep get]" returns the OpenAPI spec for that API'
  echo " e.g. keep get v1/schema/openapi.basis.json"
  echo '      using "| jq" after a command returns pretty printed JSON (jq installed separately)'
}

if [ -z "$1" ]; then
  execute_help;
  exit 1
fi

if [[ "$httpcommand" == "LOGIN" ]]; then
  execute_login;
fi

if [[ "$httpcommand" == "LOGOUT" ]]; then
  execute_logout;
fi

if [[ "$httpcommand" == "HELP" ]]; then
  execute_help;
  exit 0
fi

# All other cases
execute_http $@

```

## Using the CLI

First you need to login, call: `keep login`.
Thereafter use "keep HTTPKEYWORD urlpath" e.g. `keep get databases` or `keep pim get inbox` to access the API.
For the http keywords `POST`, `PUT` and `PATCH` you must provide the `Content-Type` header and a body - see `man curl` for details

## Windows version - keeplogin.cmd

```bash
:: # KEEPLOGIN
:: # Login to KEEP remote - replace server with your server
@echo off
set server=http://gunn.projectkeep.io:8880

set /p uservar=Username:
set /p passvar=Password:
set dataraw="{\"username\":\"%uservar%\", \"password\":\"%passvar%\"}"


:: Redirect standard and error output to the logfile for curl operation.
> %TEMP%\keepcurl.log 2>&1 (
    curl --location --request POST "%server%/api/v1/auth" --header "Content-Type: application/json" --data-raw %dataraw% | jq -r ".bearer" > %TEMP%\keeptoken.txt
)

echo %server% > %TEMP%\keepserver.txt
exit /B
```

## keep.cmd

```bash
:: # KEEP
:: # Poor developer's keep command line
@echo off
if [%1]==[] goto:EOF

if exist %TEMP%\\keeptoken.txt (
   set /p token=<%TEMP%\\keeptoken.txt
)

if exist %TEMP%\\keepserver.txt (
   set /p server=<%TEMP%\\keepserver.txt
)

:: uppercase the first parameter and assign it to variable named httpcommand
set "str=%1"
for /f "usebackq delims=" %%I in (`powershell "\"%str%\".toUpper()"`) do set "httpcommand=%%~I"

set urlpath=%2

:: Redirect standard and error output to the logfile for curl operation.
> %TEMP%\keepcurl.log 2>&1 (
   curl -X %httpcommand% --fail --insecure -H "Authorization: Bearer %token%" -H "Content-Type: application/json" %server%/api/v1/%urlpath%
)

if %ERRORLEVEL% EQU 0 (
   EXIT /B
)

echo Command "%httpcommand% %urlpath%" failed!  (check %TEMP%\keepcurl.log for details)
```

## keeppim.cmd

```bash
:: # KEEPPIM
:: # Call KEEP's PIM command line
:: # runs after . keeplogin
@echo off
if [%1]==[] goto:EOF

if exist %TEMP%\\keeptoken.txt (
   set /p token=<%TEMP%\\keeptoken.txt
)

if exist %TEMP%\\keepserver.txt (
   set /p server=<%TEMP%\\keepserver.txt
)

:: uppercase the first parameter and assign it to variable named httpcommand
set "str=%1"
for /f "usebackq delims=" %%I in (`powershell "\"%str%\".toUpper()"`) do set "httpcommand=%%~I"

set urlpath=%2

:: Redirect standard and error output to the logfile for curl operation.
> %TEMP%\keepcurl.log 2>&1 (
   curl -X %httpcommand% -H "Authorization: Bearer %token%" %server%/api/pim-v1/%urlpath%
)

if %ERRORLEVEL% EQU 0 (
   EXIT /B
)


echo Command "%httpcommand% %urlpath%" failed!  (check %TEMP%\keepcurl.log for details)

```
