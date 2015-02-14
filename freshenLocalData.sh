#!/bin/bash
set -eu                # Always put this in Bourne shell scripts
IFS="`printf '\n\t'`"  # Always put this in Bourne shell scripts


#Get all of the latest charts
set +e
wget -r -l1 -H -N -np -A2015*_ir_ICAO-A.jpg  -erobots=off http://aviationweather.gov/data/obs/sat/intl/
#convert   -delay 20   -loop 0   20150213_*_ir_ICAO-A.jpg   animatesWeather.gif
wget -r -l1 -H -N -np -A2015*namer_vis_fog.png	  -erobots=off http://aviationweather.gov/data/obs/sat/merc/
#convert   -delay 20   -loop 0   20150214_*.namer_vis_fog.png   animatesWeather.gif
set -e