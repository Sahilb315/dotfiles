#!/bin/bash
 hypridle -w \
   timeout 10 'hyprlock -f' \  # Lock screen after 5 minutes
   timeout 600 'systemctl suspend' \  # Suspend after 10 minutes
   before-sleep 'hyprlock -f' &
