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

#Location for the yay on the arch system
YAY_LOCATION=/usr/bin/yay

#location of paru
PARU_LOCATION=/usr/bin/paru


#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#             ####     Section: Good-Bye Section   #####                      # '
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

# This will add sudo privileges to the normal user so that the user can update the system without entering the password.
function remove_sudo() 
{
    # Add sudo no password rights
    sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
    sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
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

          Run script like this:-  ./updae-system.sh
-------------------------------------------------------------------------
"
        exit 1
    fi
}


#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#             ####    Section: Run Terminal Section   #####                   # '
#   echo '#                                                                             # '
#   echo '############################################################################### '

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

#   echo '############################################################################### '
#   echo '#                                                                             # '
#   echo '#             ####   Section: Update System Section   #####                   # '
#   echo '#                                                                             # '
#   echo '############################################################################### '


# This is main update function.
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

    # This will udate yay packages
    update_yay

    clear_Screen
 
    # This will update paru packeages
    update_paru
    
    clear_Screen
 
    #This will update pip packages 
    update_pip

    clear_Screen
 
    # This will update conda packages
    update_conda

    clear_Screen

    echo -ne "
-------------------------------------------------------------------------
    All Packages have been updated !! ✨ Congratulation ✨    
-------------------------------------------------------------------------
"  
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
    conda update --all
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


# This is the unning function.
function startup() 
{
    
    # this will clear the screen once script is runned
    clear_Screen

    # Giving the sudo privileges
    remove_sudo
    
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
