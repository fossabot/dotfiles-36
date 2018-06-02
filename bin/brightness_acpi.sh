#!/bin/bash

function usage() {
cat<< _EOT_
Description:
  Set Brightness(ACPI)

Usage:
  sh ${0} + : increment brightness(max:15)
  sh ${0} - : decrement brightness
  sh ${0} * : usage

EOF:
  cat /sys/class/backlight/acpi_video0/brightness
  cat /sys/devices/pci0000:00/0000:00:02.0/backlight/acpi_video0/brightness

_EOT_
exit 1
}

case ${1} in
  + | -)
    readonly SYS_FILE="/sys/class/backlight/acpi_video0/brightness"
    readonly STEP="1"
    readonly BRIGHTNESS="$(expr $(cat ${SYS_FILE}) ${1} ${STEP})"
    echo "UPDATE : ${SYS_FILE}"
    sudo tee ${SYS_FILE}<<< ${BRIGHTNESS}
    ;;
  *)
    usage
    ;;
esac
