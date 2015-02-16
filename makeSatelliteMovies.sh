#!/bin/bash
set -eu                # Always put this in Bourne shell scripts
IFS="`printf '\n\t'`"  # Always put this in Bourne shell scripts

#sudo apt-get install libav

# # ICAO AREA A  
# # • Americas • Mercator • 65N-50S 120W-25W • (From image: 67N-54S , 137W-13W)
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -137.0 67.0 -13.0 -54.0  ./A-frames/001.jpg A.vrt
# # ICAO AREA B1 
# # • Africa - Americas • Mercator • 50N-40S 125W-25E (From image: 63N-45S, 125W-40E)
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -125.0 63.0 40.0 -45.0  ./B1-frames/001.jpg B1.vrt
# # ICAO AREA C  
# # • Europe-Africa • Mercator • 76N-45S 65E-31W • (From image: 75n-45s,35w-70e)
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -35.0 75.0 70.0 -45.0 ./C-frames/001.jpg C.vrt
# # ICAO AREA D 
# # • Asia • Mercator • 65N-28S 133E-15W • (From image: 63N-27S, 15W-132E)
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -15.0 63.0 -132.0 -27.0  ./D-frames/001.jpg D.vrt
# # ICAO AREA E  
# # • Asia-Australia • Mercator • 45N-47S 180E-24E (From image: 45n-47s,180e-24e)
# gdal_translate -of VRT -a_srs WGS84 -a_ullr 180.0 45.0 24.0 -47.0  ./E-frames/001.jpg E.vrt
# # ICAO AREA F  
# # • Pacific • Mercator • 45N-45S 105E-100W (From image: 50n-53s,100e-110w)
# gdal_translate -of VRT -a_srs WGS84 -a_ullr 100.0 50.0 -110.0 -53.0  ./F-frames/001.jpg F.vrt
# # ICAO AREA G 
# # • Asia • Mercator • Centered on 75E • (From image: PS Center on 65e)
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -137.0 67.0 -13.0 -54.0  001.jpg 001.vrt
# # ICAO AREA H  
# # • Europe - North America • North Polar Stereographic • Centered on 45W •
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -137.0 67.0 -13.0 -54.0  001.jpg 001.vrt
# # ICAO AREA I  
# # • North America - ASIA • North Polar Stereographic • Centered on 155W •
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -137.0 67.0 -13.0 -54.0  001.jpg 001.vrt
# # CAO AREA J  
# # • South Pole • Polar Stereographic • Centered on 142W •
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -137.0 67.0 -13.0 -54.0  001.jpg 001.vrt
# # ICAO AREA M   
# # • Pacific • Mercator • 70N-10S 100E-110W •
# gdal_translate -of VRT -a_srs WGS84 -a_ullr -137.0 67.0 -13.0 -54.0  001.jpg 001.vrt

#Clean up any old links
#areas=(A B1 C D E F G H I J M)

# for element in "${myarray[@]}"; do
for area in A B1 C D E F G H I J M
  do
    set +e
    echo $area
    mkdir "$area-frames"
    rm "$area-frames"/*.jpg
    rm "$area-frames"/*.png
    set -e 
    
    #for $area
    #  for $type
    #Makes links to each saved image in a sequential fashion
    files=$(find ./aviationweather.gov/data/obs/sat/intl/ -maxdepth 1 -name "????????_????_ir_ICAO-$area.jpg"  -type f | sort -u)

    a=1
    for i in $files
      do
	new=$(printf "%03d" ${a})
# 	echo "${i} -> ${new}"
	ln  ${i} ./$area-frames/${new}.jpg
	let a=a+1
      done
    
    #Create an mp4 from the individual jpegs
    avconv \
	    -y \
	    -r 5 \
	    -i ./$area-frames/%03d.jpg   \
	    -r 24 \
	    -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
	    "/media/sf_Shared_Folder/animatedIrIcao-$area.mp4" 
  done


# 
# 
# #Clean up any old links
# rm ./namer_vis_fog-frames/*.png
# 
# #Makes links to each saved image in a sequential fashion
# files=$(find ./aviationweather.gov/data/obs/sat/merc/ -name "*namer_vis_fog.png" -maxdepth 1 -type f | sort -u)
# a=1
# for i in $files; do
#   new=$(printf "%03d" ${a}) 
#   ln  ${i} ./namer_vis_fog-frames/${new}.png
#   let a=a+1
# done
# 
# # 	-b 2048k \
# #Create an mp4 from the individual jpegs
# avconv \
# 	-r 5 \
# 	-i ./namer_vis_fog-frames/%03d.png   \
# 	-r 24 \
# 	-vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
# 	"/media/sf_Shared_Folder/animatedNamer_vis_fog.mp4" 
# 
# 	
# 	# 
# # convert   \
# # 	-delay 20   \
# # 	-loop 0   \
# # 	"./aviationweather.gov/data/obs/sat/merc/*.namer_vis_fog.png"   \
# # 	"./animatedNamerVisFog.gif" \
# # 	
