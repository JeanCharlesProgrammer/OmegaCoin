#!/bin/bash
sudo touch /var/swap.img
sudo chmod 600 /var/swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
mkswap /var/swap.img
sudo swapon /var/swap.img
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install nano htop git -y
sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils software-properties-common -y
sudo apt-get install libboost-all-dev -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y

mkdir /root/temp
cd /root/temp
wget https://www.dropbox.com/s/m2zq0zxsnv43eqd/omegacoin-0.12.5.tar.gz
sleep 3
chmod -R 755 /root/temp

tar -xzf omegacoin*.tar.gz
sleep 3

cd omegacoin-0.12.5/
./autogen.sh
./configure
sudo make
sudo make install
cd

mkdir /root/omega
mkdir -p /root/.omegacoincore
cp /root/temp/omegacoin-0.12.5/src/omegacoind /root/omega
cp /root/temp/omegacoin-0.12.5/src/omegacoin-cli /root/omega
chmod -R 755 /root/omega
chmod -R 755 /root/.omegacoincore

echo ""
echo "Configure your masternodes now!"
echo "Type the IP of this server:"
IP=Input_here_IP_of_your_VPS_SERVER
echo $IP

echo ""
echo "Enter masternode private key for node $ALIAS"
PRIVKEY=Imput_here_genkey_of_your_masternode

CONF_DIR=/root/.omegacoincore
CONF_FILE=omegacoin.conf
PORT=7777


echo "rpcuser=userOmega"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
echo "rpcpassword=passOmega"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
echo "rpcport=7778" >> $CONF_DIR/$CONF_FILE
echo "listen=1" >> $CONF_DIR/$CONF_FILE
echo "server=1" >> $CONF_DIR/$CONF_FILE
echo "daemon=1" >> $CONF_DIR/$CONF_FILE
echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
echo "masternode=1" >> $CONF_DIR/$CONF_FILE
echo "" >> $CONF_DIR/$CONF_FILE

echo "addnode=142.208.127.121" >> $CONF_DIR/$CONF_FILE
echo "addnode=154.208.127.121" >> $CONF_DIR/$CONF_FILE
echo "addnode=142.208.122.127" >> $CONF_DIR/$CONF_FILE

echo "" >> $CONF_DIR/$CONF_FILE
echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
echo "masternodeaddress=$IP:$PORT" >> $CONF_DIR/$CONF_FILE
echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
sudo ufw allow $PORT/tcp

omegacoind -daemon
sleep 3

cd /root/.omegacoincore
sudo apt-get install -y git python-virtualenv
sudo git clone https://github.com/omegacoinnetwork/sentinel.git
cd sentinel
sudo apt-get install -y virtualenv
virtualenv venv
venv/bin/pip install -r requirements.txt
echo "dash_conf=/root/.omegacoincore/omegacoin.conf" >> /root/.omegacoincore/sentinel/sentinel.conf
crontab -l > tempcron
echo "* * * * * cd /root/.omegacoincore/sentinel && ./venv/bin/python bin/sentinel.py 2>&1 >> sentinel-cron.log" >> tempcron
crontab tempcron
rm tempcron
echo "Job completed successfully"
