#!/bin/bash
swayidle -w \
  timeout 300 'swaylock -f -c 000000' \  # Lock screen after 5 minutes
  timeout 600 'systemctl suspend' \      # Suspend after 10 minutes
  before-sleep 'swaylock -f -c 000000' &  # Lock before sleep
