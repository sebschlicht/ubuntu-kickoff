#!/bin/sh

BUS_FILE_PATH=/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode

MODE="$1"
CURRENT_VALUE="$( cat "$BUS_FILE_PATH" )"

if [ "$MODE" = 'on' ]; then
  TARGET_VALUE='1'
elif [ "$MODE" = 'off' ]; then
  TARGET_VALUE='0'
else
  echo 'Unknown target mode, use [on|off] instead!'
  exit 1
fi

if [ "$CURRENT_VALUE" != "$TARGET_VALUE" ]; then
  echo "$TARGET_VALUE" | sudo tee "$BUS_FILE_PATH" 1>/dev/null
fi
