#!/bin/bash
set -eu                # Always put this in Bourne shell scripts
IFS="`printf '\n\t'`"  # Always put this in Bourne shell scripts


#Get all of the latest charts
set +e
wget -r -l1 -H -N -np -A*_ir_ICAO*  -erobots=off http://aviationweather.gov/data/obs/sat/intl/
wget -r -l1 -H -N -np -A*namer_vis_fog*	  -erobots=off http://aviationweather.gov/data/obs/sat/merc/
set -e

