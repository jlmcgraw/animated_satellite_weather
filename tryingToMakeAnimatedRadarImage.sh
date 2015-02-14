#http://mesonet.agron.iastate.edu/data/gis/images/4326/USCOMP/?C=M;O=A
#gdalbuildvrt -allow_projection_difference index.vrt *.vrt

#Remove the N0R to get all types of images
wget -r -np -nH -nd -R index.* -N http://radar.weather.gov/ridge/RadarImg/N0R/

#Each of these images is the most recent one
#Build a VRT for each
find . -name "*N0R_0*.gif" -type f -exec gdal_translate -of vrt -expand rgba {} {}.vrt \;

#Build a combined VRT from each of the sub-VRTs
gdalbuildvrt  index.vrt *.vrt

#Merge to one image
gdal_merge.py -o /media/sf_Shared_Folder/mosaic.tif index.vrt


# assuming 3G of cache here:
gdalwarp --config GDAL_CACHEMAX 3000 -wm 3000 $(list_of_tiffs) merged.tiff
#
#Be sure to not define more cache than having RAM on the machine.

#Make an animated gif
#convert -delay 20 -loop 0 *.jpg myimage.gif
