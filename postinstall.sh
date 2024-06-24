#!/bin/sh

# System update
sudo apt-update

#install applications
sudo apt-get install filezilla -y
sudo apt-get install dconf -y
sudo apt-get install putty -y
sudo snap install mc-installer

# change hostname to random
echo Ubuntu-Laptop-$(openssl rand -hex 3) > /etc/hostname

# set wallpaper https://raw.githubusercontent.com/phowobos/Minecraftcamp-Ubuntu-Autoinstall/main/Minecraft_Background.png
sudo mkdir /usr/share/wallpapers
sudo wget https://raw.githubusercontent.com/phowobos/Minecraftcamp-Ubuntu-Autoinstall/main/Minecraft_Background.png -P /usr/share/wallpapers

sudo cat >> /etc/dconf/profile/user << EOF
user-db:user
system-db:local
EOF

sudo mkdir /etc/dconf/db/local.d
sudo cat >> /etc/dconf/db/local.d/00-background << EOF
# Specify the dconf path
[org/gnome/desktop/background]

# Specify the path to the desktop background image file
picture-uri='file:///usr/share/wallpapers/Minecraft_Background.png'

# Specify one of the rendering options for the background image:
picture-options='scaled'

# Specify the left or top color when drawing gradients, or the solid color
primary-color='000000'

# Specify the right or bottom color when drawing gradients
secondary-color='FFFFFF'
EOF

sudo mkdir /etc/dconf/db/local.d/locks
sudo cat >> /etc/dconf/db/local.d/locks/background << EOF
# Lock desktop background settings
/org/gnome/desktop/background/picture-uri
/org/gnome/desktop/background/picture-options
/org/gnome/desktop/background/primary-color
/org/gnome/desktop/background/secondary-color
EOF

sudo dconf update

# Function to create a new user
create_user() {
    username=$1
    password=$2

    # Create the user with the specified username
    sudo useradd -m -s /bin/bash $username

    # Set the user's password
    echo "$username:$password" | sudo chpasswd

    echo "User '$username' has been created with the password '$password'"
}

# Create two users
create_user gruppe1 11030
create_user gruppe2 21030

## System Update and Upgrade
sudo apt update
sudo apt install --fix-missing -y
sudo apt upgrade --allow-downgrades -y
sudo apt full-upgrade --allow-downgrades -y

## System Clean Up
sudo apt install -f
sudo apt autoremove -y
sudo apt autoclean
sudo apt clean

sudo systemctl reboot
