#!/bin/bash
set -eu                # Always put this in Bourne shell scripts
IFS=$(printf '\n\t')  # Always put this in Bourne shell scripts


#Get all of the latest charts
set +e
wget -r --timestamping  --no-parent -erobots=off http://aviationweather.gov/data/obs/
# wget -r -l1 --timestamping  --no-parent -A*_ir_ICAO*       -erobots=off http://aviationweather.gov/data/obs/sat/intl/
# wget -r -l1 --timestamping  --no-parent -A*namer_vis_fog*  -erobots=off http://aviationweather.gov/data/obs/sat/merc/
# wget -r -l1 --timestamping  --no-parent                    -erobots=off http://aviationweather.gov/data/obs/sat/geos/

#Weather radar
# wget -r     --timestamping  --no-parent                    -erobots=off http://mesonet.agron.iastate.edu/data/gis/
set -e

