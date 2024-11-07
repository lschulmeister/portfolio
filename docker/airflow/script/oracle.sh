#!/bin/bash
echo "### Instalando lib cx_Oracle"
pip install cx_Oracle

echo "### Instalacao pacotes"
apt update
apt install libaio1 wget unzip -y

echo "### Download Oracle cli"
cd /opt/
mkdir /opt/oracle
cd /opt/oracle
wget https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-basic-linux.x64-21.4.0.0.0dbru.zip
unzip instantclient-basic-linux.x64-21.4.0.0.0dbru.zip

echo "### Removendo pacote de instalacao do Oracle"
rm instantclient-basic-linux.x64-21.4.0.0.0dbru.zip

echo "### Conf cli"
sh -c "echo /opt/oracle/instantclient_21_4 > /etc/ld.so.conf.d/oracle-instantclient.conf"
ldconfig

echo "### Concluido"