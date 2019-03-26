#!/bin/sh

if [ "$#" -ne 2 ]; then
    echo "$0 email name"
    exit
fi

echo 0=$0
echo 1=$1
echo 2=$2

sudo apt-get update && \
sudo apt-get -y dist-upgrade && \
sudo apt-get -y install gawk wget git-core diffstat unzip texinfo \
        gcc-multilib build-essential chrpath socat libsdl1.2-dev \
        libsdl1.2-dev xterm sed cvs subversion coreutils texi2html \
        docbook-utils python-pysqlite2 help2man make gcc g++ \
        desktop-file-utils libgl1-mesa-dev libglu1-mesa-dev \
        mercurial autoconf automake groff curl lzop asciidoc \
        u-boot-tools libncurses5-dev lib32ncursesw5-dev \
        bc pv vim openssh-server tmux locales file && \
sudo cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
echo 'LANG="en_US.UTF-8"' | sudo dd of=/etc/default/locale && \
echo 'Asia/Taipei' | sudo dd of=/etc/timezone && \
sudo locale-gen en_US.UTF-8 && \
sudo dpkg-reconfigure -f non-interactive tzdata

sudo wget https://commondatastorage.googleapis.com/git-repo-downloads/repo -O /usr/local/bin/repo
sudo chmod 755 /usr/local/bin/repo
sudo gpasswd -a mike sudo

git config --global user.email $1
git config --global user.name $2
git config --global color.ui auto
git config -l

echo export LC_ALL="en_US.UTF-8" >> ~/.bashrc
