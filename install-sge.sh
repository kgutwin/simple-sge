#!/bin/sh

set -e

apt-get install -y wget tcsh openjdk-8-jdk-headless make gcc ant libhwloc-dev \
	libssl-dev libdb-dev libpam0g-dev junit javacc man gawk

VER=8.1.9
cd /root
wget -c http://arc.liv.ac.uk/downloads/SGE/releases/$VER/sge-$VER.tar.gz
tar zxvf sge-$VER.tar.gz

cd /root/sge-$VER/source

export SGE_ROOT=/opt/sge
export SGE_CELL=default

mkdir /opt/sge
useradd -r -m -U -d /home/sgeadmin -s /bin/bash -c "Docker SGE Admin" sgeadmin
usermod -a -G sudo sgeadmin

sh scripts/bootstrap.sh && ./aimk -no-qmon -no-qtcsh && ./aimk -man
echo Y | ./scripts/distinst -local -allall -libs -noexit

cd $SGE_ROOT
touch bin/lx-amd64/{qmon,qtcsh}

ln -s $SGE_ROOT/$SGE_CELL/common/settings.sh /etc/profile.d/sge_settings.sh
echo . /etc/profile.d/sge_settings.sh >> /etc/bash.bashrc

chmod a+x /root/boot-sge.sh

apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
