#!/bin/bash
rm -rf /opt/GSM
mkdir /opt/GSM
cd /opt/GSM
apt update && sudo apt upgrade -y
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

sudo apt install -y python3-pip pcscd pcsc-tools libpcsclite-dev python3-pyscard
sudo service pcscd start
cd /opt/GSM
git clone https://github.com/osmocom/pySim
cd /opt/GSM/pySim
pip3 install pytlv serial jsonpath-ng construct cmd2 -U

cd /opt/GSM
git clone https://github.com/srsLTE/srsLTE
cd /opt/GSM/srsLTE
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig
./srslte_install_configs.sh user
wget https://raw.githubusercontent.com/bbaranoff/srslte-rpi4/main/epc.conf
wget https://raw.githubusercontent.com/bbaranoff/srslte-rpi4/main/enb.conf
wget https://raw.githubusercontent.com/bbaranoff/srslte-rpi4/main/user_db.csv
cp enb.conf /root/.config/srslte/enb.conf
cp epc.conf /root/.config/srslte/epc.conf
cp user_db.csv /root/.config/srslte/user_db.csv


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
git clone https://github.com/osmocom/osmo-msc
apt install -y libdbi-dev
cd /opt/GSM/osmo-msc
autoreconf -fi && ./configure && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/osmocom/osmo-bsc
cd /opt/GSM/osmo-bsc
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
cd /opt/GSM/osmo-bts
git checkout 1.1.0
autoreconf -fi && ./configure --enable-trx && make -j4 && make install && ldconfig

cd /opt/GSM
git clone https://github.com/bbaranoff/osmocom-nitb-standalone /etc/osmocom
cp -r /usr/local/bin/. /usr/bin
apt install libdbd-sqlite3
mkdir /var/lib/osmocom
wget https://raw.githubusercontent.com/bbaranoff/PImpMyPi/main/osmo-msc.service
cp osmo-msc.service /lib/systemd/system/osmo-msc.service
systemctl daemon-reload
cd /etc/osmocom
./osmo-all enable

cd /opt/GSM
wget https://nuand.com/downloads/yate-rc-2.tar.gz
tar xfz yate-rc-2.tar.gz
cd yate
wget https://raw.githubusercontent.com/bbaranoff/PImpMyPi/main/endian.patch
patch -p1 < endian.patch

./autogen.sh
./configure
make
make install
ldconfig

cd /opt/GSM/yatebts

./autogen.sh
./configure
make
make install
ldconfig

cd /lib/modules/$(uname -r)/build/certs
openssl req -new -x509 -newkey rsa:2048 -keyout signing_key.pem -outform DER -out signing_key.x509 -nodes -subj "/CN=Owner/"
apt install -y gcc-9 g++-9 gcc-7 g++-7 gcc-10 g++-10
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 --slave /usr/bin/g++ g++ /usr/bin/g++-7
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100 --slave /usr/bin/g++ g++ /usr/bin/g++-10
cd /opt/GSM/
git clone https://github.com/isdn4linux/mISDN
cd /opt/GSM/mISDN
rm -Rf /lib/modules/$(uname -r)/kernel/drivers/isdn/hardware/mISDN
rm -Rf /lib/modules/$(uname -r)/kernel/drivers/isdn/mISDN/
wget https://raw.githubusercontent.com/bbaranoff/PImpMyPi/main/octvqe.patch
cp /boot/System.map-$(uname -r) /usr/src/linux-headers-$(uname -r)/System.map
ln -s /lib/modules/$(uname -r)/build /lib/modules/$(uname -r)/source
aclocal && automake --add-missing
./configure
patch -p0 < octvqe.patch
make modules
cp /opt/GSM/mISDN/standalone/drivers/isdn/mISDN/modules.order /usr/src/linux-headers-$(uname -r)
cp -rn /usr/lib/modules/$(uname -r)/. /usr/src/linux-headers-$(uname -r)
make modules_install
depmod -a

update-alternatives --set gcc /usr/bin/gcc-7

cd /opt/GSM
apt install bison flex -y
git clone https://github.com/isdn4linux/mISDNuser
cd /opt/GSM/mISDNuser
make
./configure
make
make install
ldconfig
cd example
./configure
make
make install
ldconfig

update-alternatives --set gcc /usr/bin/gcc-10

cd /opt/GSM
wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-11.25.3.tar.gz
tar zxvf asterisk-11.25.3.tar.gz
cd /opt/GSM/asterisk-11.25.3
apt install libncurses-dev libxml2-dev
./configure
make
make install
make config
ldconfig

cd /opt/GSM
git clone http://git.eversberg.eu/lcr.git
cd /opt/GSM/lcr
wget https://raw.githubusercontent.com/bbaranoff/PImpMyPi/main/ast_lcr.patch
wget https://raw.githubusercontent.com/bbaranoff/PImpMyPi/main/sip_gcc.patch
patch -p0 < ast_lcr.patch
patch -p0 < sip_gcc.patch
./autogen.sh
./configure --with-sip --with-gsm-bs --with-gsm-ms --with-asterisk --with-sip
make
make install
ldconfig

apt install php apache2 -y
cp -r /opt/GSM/yatebts/nipc/web /var/www/html/nipc
chmod -R a+rw /usr/local/etc/yate/

apt install alsa-oss
apt install --reinstall linux-modules-$(uname -r) -y
cd /etc/asterisk
wget https://raw.githubusercontent.com/bbaranoff/PImpMyPi/main/extensions.conf
wget https://raw.githubusercontent.com/bbaranoff/PImpMyPi/main/sip.conf
reboot
#do by hand for gprs with yate
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -A POSTROUTING -t nat -s 192.168.99.0/24 ! -d 192.168.99.0/24 -j MASQUERADE

