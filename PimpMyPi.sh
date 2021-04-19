#!/bin/bash
rm -rf /opt/GSM
mkdir /opt/GSM
cd /opt/GSM
apt update && sudo apt upgrade
apt install -y libusb-1.0-0-dev libuhd-dev uhd-host cmake autoconf make
git clone https://github.com/pothosware/SoapySDR
cd /opt/GSM/SoapySDR
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig
cd /opt/GSM
sudo apt install -y libtool
git clone https://github.com/pothosware/SoapyUHD
cd /opt/GSM/SoapyUHD
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/myriadrf/LimeSuite
cd /opt/GSM/LimeSuite
cd build && cmake .. && make -j4 && make install && ldconfig

cd /opt/GSM
echo "export  UHD_MODULE_PATH=/usr/lib/uhd/modules" >> /root/.bashrc

sudo apt install -y cpufrequtils

sudo apt install -y libsctp-dev libconfig++-dev libconfig-dev libmbedtls-dev
git clone https://github.com/nuand/BladeRF
cd /opt/GSM/BladeRF
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/pothosware/SoapyBladeRF
cd /opt/GSM/SoapyBladeRF
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/srsLTE/srsLTE
cd /opt/GSM/srsLTE/build
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig
./srslte_install_configs.sh user
wget https://github.com/bbaranoff/srslte-rpi4/blob/main/epc.conf
wget https://github.com/bbaranoff/srslte-rpi4/blob/main/enb.conf
cp enb.conf /root/.config/srslte/enb.conf
cp epc.conf /root/.config/srslte/epc.conf

sudo apt install -y python3-pip pcscd pcsc-tools libpcsclite-dev python3-pyscard python3-cmd2
sudo service pcscd start
cd /opt/GSM
git clone https://github.com/osmocom/pySim
cd /opt/GSM/pySim
pip3 install pytlv serial jsonpath-ng construct -U


cd /opt/GSM
apt install -y libtalloc-dev libgnutls28-dev libmnl-dev
git clone https://github.com/osmocom/libosmocore
cd /opt/GSM/libosmocore
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
apt install -y libortp-dev
git clone https://github.com/osmocom/libosmo-abis
cd /opt/GSM/libosmo-abis
autoreconf -fi && ./configure --disable-dahdi && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/osmocom/libosmo-netif
cd /opt/GSM/libosmo-netif
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/osmocom/osmo-hlr
apt install -y libsqlite3-dev
cd /opt/GSM/osmo-hlr
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/osmocom/osmo-mgw
cd /opt/GSM/osmo-mgw
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
git clone git://git.osmocom.org/libgtpnl.git
cd /opt/GSM/libgtpnl
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/osmocom/libosmo-sccp
cd /opt/GSM/libosmo-sccp
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/osmocom/osmo-ggsn
cd /opt/GSM/osmo-ggsn
autoreconf -fi && ./configure --enable-gtp-linux && make -j4 && make install && ldconfig

cd /opt/GSM
apt install -y libc-ares-dev
git clone https://github.com/osmocom/osmo-sgsn
cd /opt/GSM/osmo-sgsn
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/osmocom/osmo-bsc
cd /opt/GSM/osmo-bsc
autoreconf -fi && ./configure && make -j4 && make install && ldconfig


cd /opt/GSM
git clone https://github.com/osmocom/osmo-msc
apt install -y libdbi-dev
cd /opt/GSM/osmo-msc
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
apt install -y libsofia-sip-ua-glib-dev
git clone https://github.com/osmocom/osmo-sip-connector
cd /opt/GSM/osmo-sip-connector
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/osmocom/osmo-trx
cd /opt/GSM/osmo-trx
git checkout 1.1.0
autoreconf -fi && ./configure --with-lms && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/osmocom/osmo-bts
git checkout 1.1.0
cd /opt/GSM/osmo-bts
autoreconf -fi && ./configure --enable-trx && make -j4 && make install && ldconfig

git clone https://github.com/bbaranoff/osmocom-nitb-standalone
cp -r /usr/local/bin/. /usr/bin
apt install libdbd-sqlite3
mkdir /var/lib/osmocom
wget https://github.com/bbaranoff/PImpMyPi/blob/main/osmo-msc.service
cp osmo-msc.service /lib/systemd/system/osmo-msc.service
