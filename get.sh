#! /bin/sh
curl -L -O https://github.com/Delta-Icons/linux/releases/latest/download/delta-linux.zip
unzip delta-linux.zip -d delta-linux > /dev/null
cd delta-linux
./install.sh
cd ..
rm delta-linux.zip
rm -rf delta-linux