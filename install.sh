#!/bin/bash


# Location of alacritty
ALACRITTY_LOCATION=/usr/bin/alacritty

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

function check-Terminal()
{
    if [ ! -e "$ALACRITTY_LOCATION" ]; 
    then
        echo -ne "
-------------------------------------------------------------------------
         Alacritty Terminal is Not Installed!! 
-------------------------------------------------------------------------
"
        run_Os_type       
    else
        run_file
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

function run_Os_type()
{
    # importing check-os File
    . check-os.sh

    if [[ "$package_manager" == "pacman" ]];
    then
        arch-nonalacritty-termnal
    elif [[ "$package_manager" == "apt-get" ]];
    then
        debian-nonalacritty-termnal
    else
        echo 'Error Occured: ${package_manager}'
        exit 0
    fi   
}

function arch-nonalacritty-termnal() 
{
    sudo ./root-non-alacritty-termnal.sh
    ./nonroot-non-alacritty-terminal.sh
}
function debian-nonalacritty-termnal()
{
    sudo ./root-non-alacritty-termnal.sh
}

function give-permissions() 
{
    chmod +x root-update.sh
    chmod +x non-root-update.sh
    chmod +x check-os.sh
    chmod +x nonroot-non-alacritty-terminal.sh
    chmod +x root-non-alacritty-termnal.sh

}
function remove-permissions() 
{
    chmod -x root-update.sh
    chmod -x non-root-update.sh
    chmod -x check-os.sh
    chmod -x nonroot-non-alacritty-terminal.sh
    chmod -x root-non-alacritty-termnal.sh
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
    
    # This will check the terminal
    check-Terminal

    # Runnning the Files
    # run_file

    # Removing the permission from the files
    remove-permissions

    # good bye message function
    good-bye
}
beginning
