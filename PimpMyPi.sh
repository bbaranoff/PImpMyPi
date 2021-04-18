#!/bin/bash
rm -rf /opt/GSM
mkdir /opt/GSM
cd /opt/GSM
apt update && sudo apt upgrade
apt install libusb-1.0-0-dev libuhd-dev uhd-host cmake autoconf make
git clone https://github.com/pothosware/SoapySDR
cd /opt/GSM/SoapySDR
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig
cd /opt/GSM
sudo apt install libtool
git clone https://github.com/pothosware/SoapyUHD
cd /opt/GSM/SoapyUHD
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/myriadrf/LimeSuite
cd /opt/GSM/LimeSuite
cd build && cmake .. && make -j4 && make install && ldconfig

cd /opt/GSM
echo "export  UHD_MODULE_PATH=/usr/lib/uhd/modules" >> /root/.bashrc

sudo apt install cpufrequtils

sudo apt install libsctp-dev libconfig++-dev libconfig-dev libmbedtls-dev
git clone https://github.com/srsLTE/srsLTE
cd /opt/GSM/srsLTE/build
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig
./srslte_install_configs.sh user
wget https://github.com/bbaranoff/srslte-rpi4/blob/main/epc.conf
wget https://github.com/bbaranoff/srslte-rpi4/blob/main/enb.conf
cp enb.conf /root/.config/srslte/enb.conf
cp epc.conf /root/.config/srslte/epc.conf

sudo apt install python3-pip pcscd pcsc-tools libpcsclite-dev
sudo service pcscd start
cd /opt/GSM
git clone https://github.com/osmocom/pySim
cd /opt/GSM/pySim
pip3 install -r requirements.txt -U
pip3 install construct


#!/bin/bash
cd /opt/GSM
apt install libtalloc-dev libgnutls28-dev libmnl-dev
git clone https://github.com/osmocom/libosmocore
cd /opt/GSM/libosmocore
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
apt install libortp-dev
git clone https://github.com/osmocom/libosmo-abis
cd /opt/GSM/libosmo-abis
autoreconf -fi && ./configure --disable-dahdi && make -j4 && make install && ldconfig

#!/bin/bash
cd /opt/GSM
git clone https://github.com/osmocom/libosmo-netif
cd /opt/GSM/libosmo-netif
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/osmocom/osmo-hlr
apt install libsqlite3-dev
cd /opt/GSM/osmo-hlr
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

#!/bin/bash
cd /opt/GSM
git clone https://github.com/osmocom/osmo-msc
cd /opt/GSM/libosmo-netif
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/osmocom/osmo-mgw
apt install libsqlite3-dev
cd /opt/GSM/osmo-hlr
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

#!/bin/bash
cd /opt/GSM
git clone git://git.osmocom.org/libgtpnl.git
cd /opt/GSM/libgtpnl
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/osmocom/libosmo-sccp
cd /opt/GSM/libosmo-sccp
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

#!/bin/bash
cd /opt/GSM
git clone https://github.com/osmocom/osmo-ggsn
cd /opt/GSM/osmo-ggsn
autoreconf -fi && ./configure --enable-gtp-linux && make -j4 && make install && ldconfig

cd /opt/GSM
apt install libc-ares-dev
git clone https://github.com/osmocom/osmo-sgsn
cd /opt/GSM/osmo-sgsn
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

