#!/usr/bin/env bash

BAT=$(ls -d /sys/class/power_supply/BAT* | head -1)
if [ ! -x "$(which acpi 2> /dev/null)" ];then
  status=$(cat $BAT/status)
  capacity=$(cat $BAT/capacity)
else
  status=$(acpi | grep "Battery 0" | cut -d: -f2- | cut -d, -f1 | tr -d ' ')
  capacity=$(acpi | grep "Battery 0" | cut -d: -f2- | cut -d, -f2 | tr -d '% ')
fi

if [ $status == "Discharging" ]; then
  echo "♥ $capacity%"
else
  echo "🗲 $capacity%"
fi
