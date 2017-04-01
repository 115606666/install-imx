#!/bin/sh

if [ "$#" -ne 2 ]; then
    echo "$0 email name"
    exit
fi

echo 0=$0
echo 1=$1
echo 2=$2

sudo su
    apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get install -y gawk wget git-core diffstat unzip texinfo \
        gcc-multilib build-essential chrpath socat libsdl1.2-dev \
        libsdl1.2-dev xterm sed cvs subversion coreutils texi2html \
        docbook-utils python-pysqlite2 help2man make gcc g++ \
        desktop-file-utils libgl1-mesa-dev libglu1-mesa-dev \
        mercurial autoconf automake groff curl lzop asciidoc \
        u-boot-tools \
        bc pv vim openssh-server tmux && \
    cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
    echo 'Asia/Taipei' > /etc/timezone && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure -f non-interactive tzdata

    wget https://commondatastorage.googleapis.com/git-repo-downloads/repo -O /usr/local/bin/repo
    chmod 755 /usr/local/bin/repo
    gpasswd -a mike sudo

exit

git config --global user.email $1
git config --global user.name $2
git config -l
