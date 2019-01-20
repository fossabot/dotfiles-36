#!/bin/bash

function usage() {
cat<< _EOT_
Description:
  INSTALL VirtualBox

Usage:
  sh ${0} pacman    : INSTALL Packages
  sh ${0} gpasswd   : ADD     Group
  sh ${0} systemctl : ENABLE  System_services
  sh ${0} modprobe  : LOAD    Modules
  sh ${0} *         : USAGE

EOF:
  virtualbox

_EOT_
exit 1
}

case ${1} in
  pacman)
    sudo pacman -Syu
    sudo pacman -S virtualbox \
                   virtualbox-host-modules-arch net-tools \
                   virtualbox-guest-iso virtualbox-guest-utils
    sudo pacman -Sc
    ;;
  gpasswd)
    sudo gpasswd -a $(whoami) vboxusers
    groups
    ;;
  systemctl)
    systemctl enable vboxservice.service
    ;;
  modprobe)
    modprobe -a vboxdrv \
                vboxnetadp vboxnetflt \
                vboxpci \
    ;;
  *)
    usage
    ;;
esac
