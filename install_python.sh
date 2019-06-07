#/bin/bash

PYTHON_V=$1

wget https://www.python.org/ftp/python/$PYTHON_V/Python-$PYTHON_V.tgz
sudo apt-get update
sudo apt-get upgrade
#check tools needed to proper installation
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev  libncursesw5-dev xz-utils tk-dev

tar xvf Python-$PYTHON_V.tgz
cd Python-$PYTHON_V
./configure --enable-optimizations --with-ensurepip=install
make -j 8	#paralelization 

sudo make altinstall	#installation
