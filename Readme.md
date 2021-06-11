# Script for flashing Unifi AP AC with OpenWrt
    
- Download OpenWrt sysupgrade image for your device from https://openwrt.org/toh/ubiquiti/unifiac
- Rename OpenWrt image to openwrt.bin
- Download old stock firmware https://dl.ui.com/unifi/firmware/U7PG2/3.7.58.6385/BZ.qca956x.v3.7.58.6385.170508.0957.bin
- Rename old stock firmware image to ubnt.bin
- Set ethernet IP of your PC to 192.168.1.5/24
- execute [./flash_openwrt.sh](./flash_openwrt.sh)
