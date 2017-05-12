#!/bin/bash


# NxCar development dongle setup

# (c) Copyright 2017 Samson Kirk-Koffi (samson@nxcartech.com)

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  sudo apt-get install -y  git 
fi

cd /home/pi/
mkdir misc
cd misc


if ! [ -x "$(command -v node)" ]; then
  	echo 'LOG: node is not installed.' >&2
  	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | sudo -u pi bash
	source /home/pi/.bashrc
	nvm install v6.10.3
	nvm alias default v6.10.3
	sudo rm /usr/bin/node
	sudo rm /usr/bin/npm
	sudo ln -s /home/pi/.nvm/versions/node/v6.10.3/bin/node /usr/bin/node
	sudo ln -s /home/pi/.nvm/versions/node/v6.10.3/bin/npm /usr/bin/npm
	node -v
	npm -v
fi

sudo apt-get install -y mercurial gcc libc6-dev screen python-pip golang 
pip install virtualenv

#Golang installation
wget https://storage.googleapis.com/golang/go1.7.1.linux-armv6l.tar.gz
tar -xvzf go1.7.1.linux-armv6l.tar.gz go
# sudo cp /home/pi/misc/go/bin/go /usr/bin/go
sudo cp /home/pi/misc/go /usr/bin/
export PATH=$PATH:/usr/bin/go/bin/go
export GOROOT=/usr/bin/go/



#install Ethereum
git clone https://github.com/ethereum/go-ethereum.git

cd go-ethereum/
mkdir /home/pi/misc/go-ethereum/build/_workspace/pkg
chmod -R 777 /home/pi/misc/go-ethereum/
make geth
sudo cp build/bin/geth /usr/bin/

#install Ipfs
cd /home/pi/misc
wget https://ipfs.io/ipns/dist.ipfs.io/go-ipfs/v0.4.8/go-ipfs_v0.4.8_linux-arm.tar.gz
tar -xvzf  go-ipfs_v0.4.8_linux-arm.tar.gz go-ipfs
mv go-ipfs/ipfs /usr/bin/ipfs


echo 'Running tests' >&2

if  [ -x "$(command -v ipfs)" ]; then
  echo 'IPFS sucessfully installed.' >&2
fi

echo"++++++++++++++++++++++++++++"
echo "Please verify geth installation"
echo"++++++++++++++++++++++++++++"

echo "cleaning up"
rm -rf /home/pi/misc