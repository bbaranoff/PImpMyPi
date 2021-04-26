# PImpMyPi

Sur un hôte ubuntu....

```console 
sudo apt install snapd
sudo service snapd start
sudo snap install rpi-imager
```

Ensuite ouvrir l'application rpi imager


![image](https://user-images.githubusercontent.com/37385191/115163883-f37f7380-a0ab-11eb-916b-cf4fdf9df612.png)

![image](https://user-images.githubusercontent.com/37385191/115163869-d3e84b00-a0ab-11eb-8f7a-f55fb8813f49.png)

![image](https://user-images.githubusercontent.com/37385191/115163893-06924380-a0ac-11eb-8869-6c52f778adc6.png)

![image](https://user-images.githubusercontent.com/37385191/116073934-561ad580-a691-11eb-8dee-6dc9136a7c34.png)


```console
# To find your Pi on a 192.168.1.0/24 network
sudo apt install nmap
nmap 192.168.1.1-254 -p 22
# Should be an address with port 22 open
# Then
ssh ubuntu@192.168.1.xxx
password ubuntu

On Ubuntu Server Pi
apt update && apt upgrade 
reboot
# Then
ssh ubuntu@192.168.1.xxx
sudo su
git clone https://github.com/bbaranoff/PimpMyPi
cd PimpMyPi
./PimpMyPi.sh
```
