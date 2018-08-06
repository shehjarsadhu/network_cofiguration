#!/bin/bash
function usage(){

  echo "-w <ssid>,<psk> ; -s <staticIP> , <netamask> ,<router> ; -ma <shows mac address> ; -IP<shows current IP >"

}

function restart_network() {
  echo "restarting network"
  sudo systemctl daemon-reload
  sudo systemctl restart dhcpcd
}   # end of restartNetwork

function set_wlan() {
  ssid=$1
  ssid_passwd=$2
  if [[ -z "$1" ]]; then
    echo "missing ssid"
    usage
    exit
  fi

  if [[ -z "$2" ]]; then
    echo "missing ssid_passwd"
    usage
    exit
  fi

  echo "------------------------------"
  echo "          SSID: " ${ssid}
  echo " SSID Password: " ${ssid_passwd}
  echo "------------------------------"
  read -p " Continue? (y/N): " confirm && [[ $confirm == [Yy] ]] || exit 1
  echo ""


  echo "setting the ssid to: \"${ssid}\" and ssid_passwd to: \"${ssid_passwd}\""
# add code to modify the wpa file here

  #puts pre code in the supplicant file
  printf "network={\n    ssid=\n    psk=\n}" | sudo tee /etc/wpa_supplicant/wpa_supplicant.conf
  #puts the user entered info in the supplicant file
  sudo  sed -ie "s/^    ssid=.*$/    ssid=\"${ssid}\"/g" /etc/wpa_supplicant/wpa_supplicant.conf
  sudo  sed -ie "s/^    psk=.*$/    psk=\"${ssid_passwd}\"/g"  /etc/wpa_supplicant/wpa_supplicant.conf
  restart_network
}


function set_staticIP() {
  ipAddress=$1
  netmask=$2
  router=$3

  if [[ -z "$1" ]]; then
    echo "missing ipAddress"
    usage
    exit
  fi

  if [[ -z "$2" ]]; then
    echo "missing netmask"
    usage
    exit
  fi

  if [[ -z "$3" ]]; then
    echo "missing router"
    usage
    exit
  fi
  echo "------------------------------"
  echo " IP Address: " ${ipAddress}
  echo "    Netmask: " ${netmask}
  echo "     Router: " ${router}
  echo "------------------------------"

  read -p " Continue? (y/N): " confirm && [[ $confirm == [Yy] ]] || exit 1
  echo ""

  echo "setting the IP to: \"${ipAddress}\", netmask to: ${netmask} and router to: \"${router}\""
  #add code to modify the dhcp file
  #add code to modify the dhcp file
  #puts pre code in the supplicant file
 printf  "static ip_address=\nstatic routers=\nstatic domain_name_servers=\n " | sudo tee /etc/dhcpcd.co$
 #puts the user entered info in the dhcpcd file
 sudo  sed -ie "s/^static ip_address=.*$/static ip_address=$ipAddress/g" /etc/dhcpcd.conf
 sudo  sed -ie "s/^static routers=.*$/static routers=$router/g"  /etc/dhcpcd.conf
 sudo  sed -ie "s/^static domain_name_servers=.*$/static domain_name_servers=8.8.8.8/g"  /etc/dhcpcd.conf
 restart_network
}

function show_macAddress() {
  echo "show the current MAC address"
  cat /sys/class/net/wlan0/address
}

function show_staticIP() {
  IP=$(hostname -I)
  echo "currently configured static IP address: $IP"
}

  while getopts s:w:ma:IP param ; do
    case $param in
    -s)
        echo "-s is trigered"
        read -p  "what to set a staticip? (y/n)" b
        # read b
        if [[ $b == "y" ]]
        then
            set_staticIP  192.168.1.100 255.255.255.0 192.168.1.1
        elif [[ $b == "n" ]]
        then
              exit
        fi
        ;;
      w)
        echo "-w is triggered"
        read -p "Want to connect to wifi? (y/n)" bool
        if [[ $bool == "y" ]]
        then
            set_wlan Cooliance 1234345656787890
        elif [[ $bool == "n" ]]
        then
              exit
        fi
        ;;
      ma)
        echo "-ma is triggered"
        show_macAddress
        ;;
      IP)
        echo "-IP is triggered"
        show_staticIP
    esac
  done
