#!/bin/bash

# This will import the check Os file
. check-os.sh

#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#             ####    Section: Root Section Section       #####               # '
#   echo '#                                                                             # '
#   echo '############################################################################### '


function root() 
{
    # Checking for root access and proceed if it is present
    ROOT_UID=0
    if [[ ! "${UID}" -eq "${ROOT_UID}" ]]; then
        echo -ne "
-------------------------------------------------------------------------
           This script shouldn be run as root. ☹️🙁

           Run script like this:-  ./root-update.sh
-------------------------------------------------------------------------
 "
        exit 1
    fi
}

#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#        ####    Section: Sudo Privillages to the user    #####               # '
#   echo '#                                                                             # '
#   echo '############################################################################### '

# This will add sudo privileges to the normal user so that the user can update the system without entering the password.
function remove_sudo() 
{
    # Add sudo no password rights
    sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
    sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
}

#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#             ####    Section: Clear terminal             #####               # '
#   echo '#                                                                             # '
#   echo '############################################################################### '

# this funtion will clear the screen 
function clear_Screen() 
{
    clear
}

#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#             ####    Section: Which Os you are running       #####           # '
#   echo '#                                                                             # '
#   echo '############################################################################### '

# This function will check with package manager your are running
function check_OS() 
{
    if [[ "$package_manager" == "pacman" ]];
    then
        update
    elif [[ "$package_manager" == "apt-get" ]];
    then
            debian_update
    else
        echo 'Error Occured: ${package_manager}'
        exit 0
    fi
}

#  ------------------------------------------Debian Update Section-----------------------------------------------------------------# 

#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#     ####   Section: Update System Section for Debian System   #####         # '
#   echo '#                                                                             # '
#   echo '############################################################################### '

# Update system for debian_update
function debian_update() 
{
    echo -ne "
-------------------------------------------------------------------------
            Debain System is Detected
-------------------------------------------------------------------------
"
    echo -ne "
-------------------------------------------------------------------------
            Updating System Packages
-------------------------------------------------------------------------
"
     sudo apt-get update -y 
    
    clear_Screen
    
    echo -ne "
-------------------------------------------------------------------------
            Upgrading System Packages
-------------------------------------------------------------------------
"
     sudo apt upgrade -y 

    # For more package to update add here 
  
    echo -ne "
-------------------------------------------------------------------------
    All Packages have been updated !! ✨ Congratulation ✨    
-------------------------------------------------------------------------
"    
}

# ------------------------------------------Arch System Update----------------------------------------------------------------------------------------------#

#----------------------------------------Logic of Arch Update system-----------------------------------------------------------------------------------#      

# For arch system there are two ways to update and upgrade packages the pacman Repo and the Aur Repo   
# So The scrip is divided into two parts the root run part and the simple user part. 
# Each part of the script will  be executed one by one nothing will skipped.
# Root Side: Pacman Packages
# User Side: Paru, Yay or pip or Conda environment 
# The user side does not required the sudo privileges so they are seperated from the sudo script and did not disturb the sudo privileges section. 
# -----------------------------------------------------------------------------------------------------------------------------------------------------------#


#----------------------------------------Root Bases Pacman Update-----------------------------------------------------------------------------------#      


#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#     ####   Section: Update System Section for Arch System   #####           # '
#   echo '#                                                                             # '
#   echo '############################################################################### '

# This is main update function for the arch system .
# This function will update the system 
function update()
{
    echo -ne "
-------------------------------------------------------------------------
            Arch System is Detected
-------------------------------------------------------------------------
"  
    # This will update pacman packages
    update_pacman

    clear_Screen

    # for more packages to install or update then creata a function.
    # enter the command into the function. 
}

# this will update the pacman Packages
function update_pacman() 
{
    echo -ne "
-------------------------------------------------------------------------
            Updating Pacman Packages
-------------------------------------------------------------------------
" 
    #Updating the pacman Pacages  
    sudo pacman -Syyu --noconfirm --needed

}

#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#     ####   Section: Running part of the script or Main function   ####      # '
#   echo '#                                                                             # '
#   echo '############################################################################### '

# This is the unning function.
function startup() 
{
    
    # Giving the sudo privileges
    remove_sudo
    
    # check root privileges
    root
    
    # check-Os and then update system 
    check_OS

}
startup
