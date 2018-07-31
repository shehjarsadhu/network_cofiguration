
# Description:

This document consists of how to set up the wifi and static ip addredd on a raspberry pi 0. This set up uses raspbian stretch no GUI operating system version of the raspberry pi.
Download avalible here https://www.raspberrypi.org/downloads/raspbian/

#### Part 1:  Setting up wifi with raspberry pi0

##### Preparing the wpa_supplicant file

Step 1: Open the wpa_supplicant file. By typing this into your pi’s terminal. Make sure to get the file path right otherwise this will end up opening some other file. You can type the following command to do so.

    pi@raspberrypi:~ $ sudo nano /etc/wpa_supplicant/wpa_supplicant.conf

Step 2: Add the code below to the wpa_supplicant configuration file. Ssid is your own network ID and psk is your own network password.

    network={
        ssid="Name of your network"
        psk="Your network password"
      }

Step 3: reboot your raspberry pi. By typing in the command “sudo reboot ” in your pi terminal.

      pi@raspberrypi:~  $ sudo reboot


And you are all done.


#### Part 2: Setting up static IP raspberry pi0

You would need to open a dhcpcd.config file on the device.
You can do so by typing the following.


    pi@raspberrypi:~ $ sudo nano /etc/dhcpcd.conf



sudo: Allows you to run as root.
nano: Is The text editor we are using.
/etc/dhcpcd.conf: Is the file path of the dhcpcd config file. Make sure you get this right


Once you get in the file add the following lines of code at the end.


    static ip_address=192.168.1.100
    static routers=192.168.1.1
    static domain_name_servers=8.8.8.8



1. static ip_address is the address you want to give to the device it can be what ever number you want.
You will have to enter
2. static domain_name_servers :- 8.8.8.8 is google's dns and you can use that.
3. static routers is your routers IP address.You can get that by typing the following in your terminal.


    pi@raspberrypi:~ $ route -n

It will display a table routers IP will be under gateway column.
