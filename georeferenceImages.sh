#!/bin/bash
set -eu                # Always put this in Bourne shell scripts
IFS=$(printf '\n\t')  # Always put this in Bourne shell scripts
 
# EPSG:4267 	North American Datum of 1927 (NAD 27)
# EPSG:4269 	North American Datum of 1983 (NAD 83)
# EPSG:4326 	World Geodetic System 1984 (WGS 84) 
#  
# ICAO AREA A  
# • Americas • Mercator • 65N-50S 120W-25W • (From image: 67N-54S , 137W-13W)
gdal_translate -of VRT -a_srs EPSG:4326 -a_ullr -137.0 67.0 -13.0 -54.0  ./A-frames/001.jpg A.vrt

#A cropped version of one frame to coordinates delineated on the picture, reference still not right
gdal_translate -of VRT -a_srs EPSG:4326 -a_ullr -130.0 60.0 -20.0 -50.0  ./Cropped-A.jpg Cropped-A.vrt

# ICAO AREA B1 
# • Africa - Americas • Mercator • 50N-40S 125W-25E (From image: 63N-45S, 125W-40E)
gdal_translate -of VRT -a_srs WGS84 -a_ullr -125.0 63.0 40.0 -45.0  ./B1-frames/001.jpg B1.vrt

# ICAO AREA C  
# • Europe-Africa • Mercator • 76N-45S 65E-31W • (From image: 75n-45s,35w-70e)
gdal_translate -of VRT -a_srs WGS84 -a_ullr -35.0 75.0 70.0 -45.0 ./C-frames/001.jpg C.vrt

# ICAO AREA D 
# • Asia • Mercator • 65N-28S 133E-15W • (From image: 63N-27S, 15W-132E)
gdal_translate -of VRT -a_srs WGS84 -a_ullr -15.0 63.0 -132.0 -27.0  ./D-frames/001.jpg D.vrt

# ICAO AREA E  
# • Asia-Australia • Mercator • 45N-47S 180E-24E (From image: 45n-47s,180e-24e)
gdal_translate -of VRT -a_srs WGS84 -a_ullr 180.0 45.0 24.0 -47.0  ./E-frames/001.jpg E.vrt

# ICAO AREA F  
# • Pacific • Mercator • 45N-45S 105E-100W (From image: 50n-53s,100e-110w)
gdal_translate -of VRT -a_srs WGS84 -a_ullr 100.0 50.0 -110.0 -53.0  ./F-frames/001.jpg F.vrt

# # ICAO AREA G 
# # • Asia • Mercator • Centered on 75E • (From image: PS Center on 65e)
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -137.0 67.0 -13.0 -54.0  001.jpg 001.vrt
# 
# # ICAO AREA H  
# # • Europe - North America • North Polar Stereographic • Centered on 45W •
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -137.0 67.0 -13.0 -54.0  001.jpg 001.vrt
# 
# # ICAO AREA I  
# # • North America - ASIA • North Polar Stereographic • Centered on 155W •
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -137.0 67.0 -13.0 -54.0  001.jpg 001.vrt
# 
# # ICAO AREA J  
# # • South Pole • Polar Stereographic • Centered on 142W •
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -137.0 67.0 -13.0 -54.0  001.jpg 001.vrt
# 
# # ICAO AREA M   
# # • Pacific • Mercator • 70N-10S 100E-110W •
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -137.0 67.0 -13.0 -54.0  001.jpg 001.vrt