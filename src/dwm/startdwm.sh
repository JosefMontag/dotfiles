#!/bin/sh

# Trap termination signals
trap 'exit 0' TERM INT

# Loop to start dwm with error handling
while true; do
  truncate -s 0 ~/.dwm.log
  dwm 2>~/.dwm.log
  [ $? -eq 0 ]
  sleep 1
done
