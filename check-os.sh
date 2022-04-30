#!/bin/bash

#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#     ####   Info: This script will check which Os you are running  ####      # '
#   echo '#                                                                             # '
#   echo '############################################################################### '


# This will check which package manager your are running 
declare -A osInfo;
osInfo[/etc/debian_version]="apt-get"
osInfo[/etc/alpine-release]="apk"
osInfo[/etc/centos-release]="yum"
osInfo[/etc/fedora-release]="dnf"
osInfo[/etc/arch-release]="pacman"

#to find the which Os yo are running
for f in ${!osInfo[@]}
do
    if [[ -f $f ]];
    then
         package_manager=${osInfo[$f]}
    fi
done