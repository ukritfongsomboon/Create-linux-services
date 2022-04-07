#!/bin/bash

echo "    _            __        ____";
echo "   (_)___  _____/ /_____ _/ / /";
echo "  / / __ \/ ___/ __/ __ \`/ / / ";
echo " / / / / (__  ) /_/ /_/ / / /  ";
echo "/_/_/ /_/____/\__/\__,_/_/_/   ";
echo "                               ";

#-------------------------------------------------------------------
# Config Bash Script App As Linux Service
#-------------------------------------------------------------------
APP_NAME='tapp'
APP_DESCRIPTION="Test Run Service !!"
APP_FILE='app.py'
APP_DIR='$PWD'
APP_RUNNER='/usr/bin/python3'

SERVICE_DIR='/etc/systemd/system/'

#-------------------------------------------------------------------
# Check privilage to root
#-------------------------------------------------------------------
if (( $EUID != 0 )); then
    echo -ne "[Error]\tPlease run as root with \"sudo\"\n\n"
    exit
fi


#-------------------------------------------------------------------
# Check File Main app.py
#-------------------------------------------------------------------
if [ -f "$APP_FILE" ]; then
  echo -ne "[Pass]\t$APP_FILE file exists\n"
else
  echo -ne "[Error]\t$APP_FILE File does not exist\n"
  exit
fi

#-------------------------------------------------------------------
# Check Runner App
#-------------------------------------------------------------------
if [ "$($APP_RUNNER --version)" ]; then 
  echo -ne '[Pass]\t'$($APP_RUNNER --version)
else 
  echo 'Fail'
fi
#-------------------------------------------------------------------
#-------------------------------------------------------------------

echo -ne '\n'
