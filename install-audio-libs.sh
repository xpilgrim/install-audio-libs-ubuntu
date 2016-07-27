#!/bin/bash

# This script is for installing audio-libs and programms for audio editing
# It's for ubuntu 16.4
# Author: Joerg Sorge
# Distributed under the terms of GNU GPL version 2 or later
# Copyright (C) Joerg Sorge joergsorge at googell
# 2016-05-29

echo "Install audio-libs..."
echo "Take user to the audio group"
sudo usermod -aG audio ${USER}

echo "PPA for mp3gain..."
sudo add-apt-repository ppa:flexiondotorg/audio
sudo apt-get update

echo "Load and install packages..."

sudo apt-get install \
pulseaudio-module-jack \
audacious radiotray soundconverter \
jamin patchage asunder libav-tools qjackctl \
mp3gain lame


echo "Invada PlugIns..."
sudo apt-get install invada-studio-plugins-lv2

echo "Libs for Calff Plugins..."
sudo apt-get install \
git libjack-jackd2-dev libfluidsynth-dev \
sfftw-dev autotools-dev libglib2.0-dev \
libgtk2.0-dev libreadline-dev libexpat1-dev \
libasound2-dev ladspa-sdk dssi-dev libtool \
automake libfftw3-dev lv2core libsox-fmt-all \
build-essential libtool

echo "Calf download"
git clone http://repo.or.cz/r/calf.git

echo "Calf install..."
cd ~/calf
sh ./autogen.sh
./configure --prefix=/usr --enable-sse
sudo make all install
cd ..
sudo rm -rf ~/calf

echo "Load and install libs for Nautilus scripts"
sudo apt-get install \
lame mp3val libid3-tools mp3gain mp3info sox libav-tools libsox-fmt-mp3 \
curl gawk links libtranslate-bin

echo "Load and install natilus scripts"
git clone https://github.com/xpilgrim/nautilus-scripts-audio-video.git
cd ~/nautilus-scripts-audio-video
sh ./install_nautilus_scripts_ubuntu_13_local.sh
cd ..
rm -rf ~/nautilus-scripts-audio-video

echo "avconvert install..."
wget https://dl.opendesktop.org/api/files/download/id/1460750426/92533-avconvert.tar.gz
tar -xzf 92533-avconvert.tar.gz -C .local/share/nautilus/scripts
rm 92533-avconvert.tar.gz

echo "RadioTray Autostart..."
sudo apt-get install python-xdg

if [ ! -d /home/${USER}/.config/autostart ]; then
  mkdir /home/${USER}/.config/autostart
fi

bash -c "echo ""[Desktop Entry]"" > /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""Type=Application"" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""Exec=/usr/bin/radiotray"" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""Hidden=false"" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""NoDisplay=false"" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""X-GNOME-Autostart-enabled=true"" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""Name[de_DE]=RadioTray"" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""Comment[de_DE]="" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""Comment="" >> /home/${USER}/.config/autostart/radiotray.desktop"

echo "finito"
read -p "Press [Enter] key to finish..."
exit
