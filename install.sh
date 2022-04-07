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
APP_DESCRIPTION='Test Run Service !!'
APP_FILE='app.py'
APP_DIR=$PWD
APP_RUNNER='/usr/bin/python3'

SERVICE_DIR='/etc/systemd/system/'
#SERVICE_DIR=$PWD
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
  echo -ne '[Pass]\t'$($APP_RUNNER --version)'\n'
else
  echo -ne '[Error] Runner is not exists\n'
  exit
fi

#-------------------------------------------------------------------
# Check Service dir is exists
#-------------------------------------------------------------------
if [[ -d "$SERVICE_DIR" ]]; then
    echo -ne "[Pass]\t$SERVICE_DIR exists on your filesystem.\n"
else
    echo -ne "[Error]\t$SERVICE_DIR not exists on your filesystem.\n"
    exit
fi

#-------------------------------------------------------------------
# Create File Service.service
#-------------------------------------------------------------------
FULL_FILE=$SERVICE_DIR/$APP_NAME.service
echo -ne "\n[Path]\t$FULL_FILE\n\n"

if [ -f "$FULL_FILE" ]; then
  echo -ne "[Wait]\tService File is exists\n"

  systemctl stop $APP_NAME.service
  echo -ne "\t-->[Stop]\tStop old $FULL_FILE\n"

  systemctl daemon-reload
  echo -ne "\t-->[Reload]\tReload All Service\n"

  rm -rf $FULL_FILE
  echo -ne "\t-->[Remove]\tRemove old $FULL_FILE\n"
fi

echo -ne "[Unit]\nDescription=$APP_DESCRIPTION\nAfter=multi-user.target\n\n">> $FULL_FILE
echo -ne "[Service]\nType=simple\nRestart=always\nExecStart=$APP_RUNNER $APP_DIR/$APP_FILE\n\n">> $FULL_FILE
echo -ne "[Install]\nWantedBy=multi-user.target">> $FULL_FILE

#------------------------------------------------------------------
# Show Output File
#------------------------------------------------------------------
echo -ne "\n\n#########################################################\n"
echo -ne "###                     service file                  ###\n"
echo -ne "#########################################################\n\n"
cat $FULL_FILE
echo -ne "\n\n#########################################################\n\n"

#-------------------------------------------------------------------
# Reload Services
#-------------------------------------------------------------------
systemctl daemon-reload
systemctl start $APP_NAME
#-------------------------------------------------------------------

echo -ne '\n'
