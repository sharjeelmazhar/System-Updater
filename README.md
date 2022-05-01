# Introduction:

In this version of the application we are adding the detection of alacrity terminal other terminal as well.

# Versions:

## Previous Version:

In the Previous Version of the application the script will only update the system once launched no regards to the checking of the alacrity terminal, 

## New Version:

In this Version the script will detect the alacrity terminal and if present the system update will occur through the alacrity Terminal.   

In this version there are two parts of the script.

1. Root Version
2. Non Root Version 

The root version required the root privileges where as the Non root version required user privileges. 

## Detection of Package Manager:

In this the script will detect the package manager and once detected then the command for the package manager will be executed.

The supported Package managers are

1. Arch System or Arch Based System 
2. Debian System or Debian Based System.

# Installment Guide:

## Requirement:

For the cloning of the project we need git only. To install git enter the following command.

**Arch Linux:**

```jsx
sudo pacman -S git --noconfirm --needed
```

**Debian Linux:**

```jsx
sudo apt-get install git -y
```

Once Installed then clone the project.

In order to run the script you must clone this project.

```bash
https://github.com/sharjeelmazhar/update-system-script.git
```

Once the Project is cloned then enter the directory

```jsx
cd System-Updater
```

Once the project is only Your system then open a terminal and run this script as a user to do that enter the following command into the terminal.

```bash
./install.sh
```

Then system will update all of the packages one by one.

Once the packages are installed the script will say a good Bye Message.
