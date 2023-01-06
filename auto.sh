#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./auto.sh" 2>&1
  exit 1
fi

# Change Debian to SID Branch
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp sources.list /etc/apt/sources.list

username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list and update system
apt update
apt upgrade -y

# Install nala
apt install nala -y

# Debloat
nala remove aisleriot five-or-more four-in-a-row gnome-klotski gnome-mahjongg gnome-mines gnome-nibbles quadrapassel gnome-chess lghtsoff gnome-robots gnome-sudoku swell-foop gnome-tetravex

# Install flatpak
nala install flatpak gnome-software-plugin-flatpak -y

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Installing flatpaks
flatpak install flathub com.viber.Viber
flatpak install flathub org.telegram.desktop
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.bitwarden.desktop
flatpak install flathub com.github.Eloston.UngoogledChromium

# Install printer driver
nala install printer-driver-foo2zjs

# Install Spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update && sudo apt-get install spotify-client

# Install Visual Studio Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft-archive-keyring.gpg
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

nala install apt-transport-https -y
apt-get update
sudo apt-get install code

# Install Theme
nala install sassc git ninja-build meson

git clone https://github.com/dgsasha/qualia-gtk-theme -b main && cd qualia-gtk-theme
./install.py
