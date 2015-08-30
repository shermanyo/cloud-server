#!/bin/bash

apt-get update
apt-get -y upgrade 
apt-get -y install vim git build-essential

useradd -m -U -G sudo -s /bin/bash sherman
su - sherman -c 'id'
mkdir -p /home/sherman/.ssh
cp ~/.ssh/authorized_keys /home/sherman/.ssh/authorized_keys
chown sherman:sherman /home/sherman/.ssh/authorized_keys

dd if=/dev/zero of=/swapfile bs=1024 count=2048k
mkswap /swapfile
swapon /swapfile

grep swapfile /etc/fstab
if [ $? -ne 0 ]; then
	echo '/swapfile none swap sw 0 0' >> /etc/fstab
fi

echo 10 > /proc/sys/vm/swappiness
echo 'vm.swappiness = 10' >> /etc/sysctl.conf

chown root:root /swapfile
chmod 0600 /swapfile

wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-6.4.11-x64.bin
wget https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-5.8.10-x64.bin
wget https://www.atlassian.com/software/stash/downloads/binary/atlassian-stash-3.11.2-x64.bin
wget https://marketplace-cdn.atlassian.com/files/artifact/d8f63494-3997-4932-b07b-9c37c205f2a1/hipchat-for-jira-plugin-6.31.0.obr

chmod +x atlassian-*.bin

#./atlassian-jira-6.4.11-x64.bin -q -varfile ./jira-response.varfile


echo "setup postgres with:"
echo "# apt-get -y install postgresql postgresql-contrib"
echo "# createuser -s -P jira"
echo "# su - jira -c 'createdb jiradb'"


