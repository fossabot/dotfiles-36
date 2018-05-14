#!/bin/bash

echo "${0} ..."

# [X11] Keymap Setting on All System
readonly ETCCONF_FILE=/etc/X11/xorg.conf.d/00-keyboard.conf
echo "UPDATE : ${ETCCONF_FILE}"
sudo localectl set-x11-keymap jp,us pc104 ,dvorak grp:alt_shift_toggle
sudo vi ${ETCCONF_FILE}
