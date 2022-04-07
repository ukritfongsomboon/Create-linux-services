#!/bin/bash

echo "    _            __        ____";
echo "   (_)___  _____/ /_____ _/ / /";
echo "  / / __ \/ ___/ __/ __ \`/ / / ";
echo " / / / / (__  ) /_/ /_/ / / /  ";
echo "/_/_/ /_/____/\__/\__,_/_/_/   ";
echo "                               ";


if (( $EUID != 0 )); then
    echo -ne "[Error]\tPlease run as root with \"sudo\"\n\n"
    exit
fi

