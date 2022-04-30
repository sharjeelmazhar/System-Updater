#!/bin/bash

#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#             ####     Section: Welcome Section   #####                       # '
#   echo '#                                                                             # '
#   echo '############################################################################### '


# This function display the Welcome Message
function welcome-Message() 
{
    echo -ne "
-------------------------------------------------------------------------
            Welcome to System Updater

            Author: Sharjeel Mazhar & Abdul Rafay
            GitHub: sharjeelmazhar & rafay99-epic
-------------------------------------------------------------------------
"
}

# this funtion will clear the screen 
function clear_Screen() 
{
    clear
}

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

          Run script like this:-  ./install.sh
-------------------------------------------------------------------------
"
        exit 1
    fi
}


#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#             ####     Section: Good-Bye Section   #####                      # '
#   echo '#                                                                             # '
#   echo '############################################################################### '

# This will display the good by message
function good-bye() 
{
    echo -ne "
-------------------------------------------------------------------------
        Thank Your using our Script!!
        Have a Good Day 🙂😊

        Regards Sharjeel Mazhar & Abdul Rafay
-------------------------------------------------------------------------
"
}

function give-permissions() 
{
    chmod +x root-update.sh
    chmod +x non-root-update.sh
    chmod +x check-os.sh
}
function remove-permissions() 
{
    chmod -x root-update.sh
    chmod -x non-root-update.sh
    chmod -x check-os.sh
}
function run_file()
{
    # importing check-os File
    . check-os.sh

    if [[ "$package_manager" == "pacman" ]];
    then
        script-arch
    elif [[ "$package_manager" == "apt-get" ]];
    then
        script-debian
    else
        echo 'Error Occured: ${package_manager}'
        exit 0
    fi
    
}
function script-arch()
{
    sudo ./root-update.sh
    ./non-root-update.sh
    echo -ne "
-------------------------------------------------------------------------
    All Packages have been updated !! ✨ Congratulation ✨    
-------------------------------------------------------------------------
" 
}
function script-debian() 
{
    sudo ./root-update.sh
    echo -ne "
-------------------------------------------------------------------------
    All Packages have been updated !! ✨ Congratulation ✨    
-------------------------------------------------------------------------
" 
}
# This is the unning function.
function beginning() 
{
    
    # this will clear the screen once script is runned
    clear_Screen

    # Welcome Message Function
    welcome-Message

    # check root privileges
    non-root    
    
    # giving permisions to the files
    give-permissions
    
    # Runnning the Files
    run_file

    # Removing the permission from the files
    remove-permissions

    # good bye message function
    good-bye
}
beginning
