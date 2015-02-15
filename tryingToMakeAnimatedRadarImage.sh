#!/bin/bash
set -eu                # Always put this in Bourne shell scripts
IFS="`printf '\n\t'`"  # Always put this in Bourne shell scripts


#http://mesonet.agron.iastate.edu/data/gis/images/4326/USCOMP/?C=M;O=A
#gdalbuildvrt -allow_projection_difference index.vrt *.vrt


#     N0R = Base Reflectivity Short Range images (views out to 124 nmi)
#     N0S = Storm Relative Motion
#     N0V = Base Velocity
#     N0Z = Base Reflectivity Long Range image (view out to 248 nmi)
#     N1P = 1 Hour Precipitation
#     NCR = Composite Reflectivity
#     NET = Echo Tops
#     NTP = Storm Total Precipitation
#     NVL = Vertical Integrated Liquid


#Remove the N0R to get all types of images
# wget -r -np -nH -nd -R index.* -N http://radar.weather.gov/ridge/RadarImg/N0R/
# wget -r -l1 -H -N -np -A2015*_ir_ICAO-A.jpg  -erobots=off http://radar.weather.gov/ridge/RadarImg/N0R/
wget -r -l1 -H -N -np -erobots=off http://radar.weather.gov/ridge/RadarImg/N0R/

#Warnings
#http://radar.weather.gov/ridge/Warnings

#Legends
#http://radar.weather.gov/ridge/Legend
#wget -r -l1 -H -N -np -erobots=off http://radar.weather.gov/ridge/Legend/NET/
# #Each of these images is the most recent one
# #Build a VRT for each
# find . -name "*N0R_0*.gif" -type f -exec gdal_translate -of vrt -expand rgba {} {}.vrt \;
# 
# #Build a combined VRT from each of the sub-VRTs
# gdalbuildvrt  index.vrt *.vrt
# 
# #Merge to one image
# gdal_merge.py -o mosaic.tif index.vrt


# assuming 3G of cache here:
#gdalwarp --config GDAL_CACHEMAX 3000 -wm 3000 $(list_of_tiffs) merged.tiff
#
#Be sure to not define more cache than having RAM on the machine.

#Make an animated gif
#convert -delay 20 -loop 0 *.jpg myimage.gif
