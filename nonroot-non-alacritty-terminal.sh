#!/bin/bash

# ---------------------------Location of yay and Paru-------------------------------------------#

#Location for the yay on the arch system
YAY_LOCATION=/usr/bin/yay

#location of paru
PARU_LOCATION=/usr/bin/paru



#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#             ####    Section: Non-Root Section Section   #####               # '
#   echo '#                                                                             # '
#   echo '############################################################################### '


# this function will make sure that the script will run as the normal user
function non-root() 
{
    if [ "$USER" = root ]; then
        echo -ne "
-------------------------------------------------------------------------
          This script shouldn't be run as root. ☹️🙁

          Run script like this:-  ./non-root-update.sh
-------------------------------------------------------------------------
"
        exit 1
    fi
}

#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#             ####    Section: Clear terminal             #####               # '
#   echo '#                                                                             # '
#   echo '############################################################################### '

# this funtion will clear the screen 
function wipe() 
{
    clear
}
# -------------------------------------User Update Aur Update-----------------------------------------------------------------------------------#

#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#   ####    Section: AUR, Conda Enironment & Pip packages update    #####     # '
#   echo '#                                                                             # '
#   echo '############################################################################### '

function update-Aur() 
{
    wipe
    # updating yay packages
    update_yay

    wipe
    # updating paru packages
    update_paru

    wipe
    # updating all of the python Packages
     update_pip

    wipe
    # Updating all of the conda packages
     update_conda
}

# this will update the pip packages aka python packages
function update_pip()
{
    echo -ne "
-------------------------------------------------------------------------
            Updating Pip Packages
-------------------------------------------------------------------------
"
      pip list --outdated --format=freeze | awk -F"==" '{print $1}' | xargs -i pip install -U {}

}
# this will update the conda environments
function update_conda() 
{
    echo -ne "
-------------------------------------------------------------------------
            Updating Conda Packages
-------------------------------------------------------------------------
"
     conda update --all --y
}

# this will update the paru packages
function update_paru()
{
    if [ ! -e "$PARU_LOCATION" ]; 
    then
        echo 'Paru is not Installed on this System'
    else
        echo -ne "
-------------------------------------------------------------------------
            Updating Paru Packages
-------------------------------------------------------------------------
"    
        paru -Syyu --noconfirm --needed
    fi
}
# THis will update the yay packages
function update_yay()
{
    if [ ! -e "$YAY_LOCATION" ]; 
    then
        echo 'yay is not installed on this system'
    else  
        echo -ne "
-------------------------------------------------------------------------
            Updating yay Packages
-------------------------------------------------------------------------
"  
    #Updating the yay Packages  
    yay -Syyu --noconfirm --needed
    fi
}

#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#     ####   Section: Running part of the script or Main function   ####      # '
#   echo '#                                                                             # '
#   echo '############################################################################### '

# This is the main running Section
function runner() 
{
    # chek for no root user
    non-root

    # updating the Aur packages
    update-Aur
}
runner