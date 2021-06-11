#!/bin/bash

IP=192.168.1.20
IP_WRT=192.168.1.1
HOST=ubnt@${IP}

iscp()
{
    sshpass -p ubnt scp \
        -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -o LogLevel=error \
        -oMacs=hmac-sha1 \
        ${@}
}

issh()
{
   sshpass -p ubnt ssh \
       -oMacs=hmac-sha1 \
       -o StrictHostKeyChecking=no \
       -o UserKnownHostsFile=/dev/null \
       -o PubkeyAuthentication=no \
       -o LogLevel=error \
       -o ServerAliveInterval=3 \
       -o ServerAliveCountMax=3 \
       ${@}
}

wping()
{
    while ! ping -c 1 -W 1 ${1} > /dev/zero 2>&1 && echo -n .; do sleep 1; done
    sleep 10
}

wping ${IP}
iscp ubnt.bin ${HOST}:/tmp/
issh ${HOST} -C fwupdate.real -m /tmp/ubnt.bin
wping ${IP}
iscp openwrt.bin ${HOST}:/tmp/
issh ${HOST} mtd write /tmp/openwrt.bin kernel0
issh ${HOST} mtd erase kernel1
issh ${HOST} dd if=/dev/zero bs=1 count=1 of=/dev/mtd4
issh ${HOST} reboot
wping ${IP_WRT}
echo finished
