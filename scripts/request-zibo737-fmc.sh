#!/bin/bash

HOSTNAME=$1
if [ "$HOSTNAME" == "" ]; then
  echo "Specify the hostname to transmit the requests to"
  exit 1
fi

# FMC datarefs from the Zibo 737
REFS="laminar/B738/fmc1/Line00_L laminar/B738/fmc1/Line00_S laminar/B738/fmc1/Line01_X laminar/B738/fmc1/Line02_X laminar/B738/fmc1/Line03_X laminar/B738/fmc1/Line04_X laminar/B738/fmc1/Line05_X laminar/B738/fmc1/Line06_X laminar/B738/fmc1/Line01_L laminar/B738/fmc1/Line02_L laminar/B738/fmc1/Line03_L laminar/B738/fmc1/Line04_L laminar/B738/fmc1/Line05_L laminar/B738/fmc1/Line06_L laminar/B738/fmc1/Line01_I laminar/B738/fmc1/Line02_I laminar/B738/fmc1/Line03_I laminar/B738/fmc1/Line04_I laminar/B738/fmc1/Line05_I laminar/B738/fmc1/Line06_I laminar/B738/fmc1/Line01_S laminar/B738/fmc1/Line02_S laminar/B738/fmc1/Line03_S laminar/B738/fmc1/Line04_S laminar/B738/fmc1/Line05_S laminar/B738/fmc1/Line06_S laminar/B738/fmc1/Line_entry laminar/B738/fmc1/Line_entry_I"

# Protocol for X-Plane ExtPanel plugin from https://github.com/vranki/ExtPlane
for each in $REFS; do
  echo "sub $each"
done | nc $HOSTNAME 51000 | awk -F' ' '{ cmd="echo \042"$3"\042 | base64 --decode"; cmd | getline v; close(cmd); print $2" --> "v }'
