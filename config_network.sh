#!/bin/bash

# Gets the sssid and network password from the user.
#takes ssid and psk as arguments.
function get_networkInfo(){
        echo "Please enter a network name: "
        read ssid
        echo "Please enter the network password: "
        read psk
        #Replaces the text after the wpa-ssid and wpa-psk with user entered information.
        #sed: stream editor
        # s: substituting
        # ^: Begning of the line.
        #$: End of the line
        # -ie:
        # g: globaly
        sudo  sed -ie "s/^      ssid=.*$/       ssid=\"${ssid}\"/g" /etc/wpa_supplicant/wpa_supplicant.conf
        sudo  sed -ie "s/^   psk=.*$/        psk=\"${psk}\"/g"  /etc/wpa_supplicant/wpa_supplicant.conf
        # debug statement should be removed..
        sudo cat /etc/wpa_supplicant/wpa_supplicant.conf
}

#restarts the dhcp/for static IP without having to reboot.
function restartNetwork(){
        sudo systemctl daemon-reload
        sudo systemctl restart dhcpcd
}

#gets the MAC address of the pi.
function getMAC_address(){
        echo "Following is your MAC address"
        cat /sys/class/net/wlan0/address
}

#gets the IP address of the pi and checks weather it actually has one or not.
function get_IPaddress(){
        #Following tells the user the ip address of the machine.
        hostN="$(hostname -I)"
        # -z check weather a variable is empty or not.
        if [ -z "$hostN" ]
        then
                echo "Sorry something went wrong please try again Hostname is empty"
        #if the hostname has assigned a IP address ==> pi is on the internet.
        else
                #Perint the IP address
                echo "You are on the network."
                echo "YouR IP address  is: "
                echo "${hostN}"
        fi
}

#This function starts the execution of the above.
function start(){
        #restarts the network without having to reboot.
        restartNetwork
        #gets the IP address of the pi and stores it in a variable host.
        get_IPaddress
        #Following will display the MAC Address of the raspberry pi
        getMAC_address
}

function main(){
        #gets the network information.
        get_networkInfo
        #Double check weather the user entered the right information or not
        echo "Is the above correct? enter (y)for yes (n)for no"
        read boolean

        if [[ $boolean == "y" ]]
        then
                start
        elif [[ $boolean == "n" ]]
        then
                #get the network info again
                get_networkInfo
                start
        #makes sure that the user entered a valid answer to the qustionw.
        else
                echo "Please enter y or n."
                read boolean
                #get the network info again
                get_networkInfo
                 #restarts the network without having to reboot.
                restartNetwork
                #gets the IP address of the pi and stores it in a variable host.
                get_IPaddress
                #Following will display the MAC Address of the raspberry pi
                getMAC_address
        fi
}
#Calling the main function to set up.
main
