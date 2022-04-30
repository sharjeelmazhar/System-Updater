#!/bin/bash

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
# This function will check with package manager your are running
function check_OS() 
{
    if [[ "$package_manager" == "pacman" ]];
    then
        # run-Terminal
        update
    elif [[ "$package_manager" == "apt-get" ]];
    then
            echo -ne "
-------------------------------------------------------------------------
            Debain System is Detected

            Sorry!! Debian Based System are not supported
-------------------------------------------------------------------------
"   exit 0
    else
        echo 'Error Occured: ${package_manager}'
        exit 0
    fi
}
# This function will open terminal 
function run-Terminal() 
{
        echo -ne "
-------------------------------------------------------------------------
        Opening Terminal
-------------------------------------------------------------------------
"  
    # alacritty -noclose -- 'sudo pacman -Syyu --noconfirm --needed'
    clear_Screen
}

# This function will update the system 
function update()
{
        echo -ne "
-------------------------------------------------------------------------
            Arch System is Detected
-------------------------------------------------------------------------
"  
        echo -ne "
-------------------------------------------------------------------------
            Updating Pacman Packages
-------------------------------------------------------------------------
" 
    #Updating the pacman Pacages  
    sudo pacman -Syyu --noconfirm --needed
    clear_Screen
    echo -ne "
-------------------------------------------------------------------------
            Updating yay Packages
-------------------------------------------------------------------------
"  
    #Updating the yay Packages  
    yay -Syyu --noconfirm --needed

    clear_Screen
    echo -ne "
-------------------------------------------------------------------------
    All Packages have been updated !! ✨ Congratulation ✨    
-------------------------------------------------------------------------
"  
 
}
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
# this function will make sure that the script will run as the normal user
function non-root() 
{
    clear_Screen

    if [ "$USER" = root ]; then
        echo -ne "
-------------------------------------------------------------------------
          This script shouldn't be run as root. ☹️🙁

          Run script like this:-  ./updae-system.sh
-------------------------------------------------------------------------
"
        exit 1
    fi
}

# This is the unning function.
function startup() 
{
    # this will clear the screen once script is runned
    clear_Screen
    
    # Welcome Message Function
    welcome-Message

    # check root privileges
    non-root    
    
    # check-Os and then update system 
    check_OS

    # goo by message function
    good-bye
}
startup
