#!/bin/sh

# System update
sudo apt-update

#install applications
sudo apt-get install filezilla -y
sudo apt-get install putty -y
sudo snap install mc-installer

# change hostname to random
echo ubuntu-host-$(openssl rand -hex 3) > /etc/hostname

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
