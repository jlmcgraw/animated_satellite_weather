#!/bin/bash
set -eu                # Always put this in Bourne shell scripts
IFS=$(printf '\n\t')  # Always put this in Bourne shell scripts

#sudo apt-get install libav

#Where to save the completed movie
destination_directory="/media/sf_Shared_Folder"

namer_vis_fog_directory="./aviationweather.gov/data/obs/sat/merc/"
ir_icao_directory="./aviationweather.gov/data/obs/sat/intl/"

#Colors for highlighting text
HIGHLIGHT="\e[01;34m"
NORMAL='\e[00m'

#ICAO Infrared (IR) images
#For each ICAO area..
for area in A B1 C D E F G H I J M
  do
    #Make directory for this area if necessary
    echo -e "\n${HIGHLIGHT}Area: $area${NORMAL}"
    mkdir -p "$area-frames"
    set +e
    #Clean out old frame links for this area
    rm "$area-frames"/*.jpg
    rm "$area-frames"/*.png
    set -e 
    
    #Find all files of type ir and sort by filename (which is YYYYMMDD-HHMM)
    files=$(find ./aviationweather.gov/data/obs/sat/intl/ -maxdepth 1 -name "????????_????_ir_ICAO-$area.jpg"  -type f | sort -u)

    #Make new links to each saved image in a sequential fashion
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
            -loglevel warning \
	    -y \
	    -r 5 \
	    -i ./$area-frames/%03d.jpg   \
	    -r 24 \
	    -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
	    "$destination_directory/animated_Ir_Icao-$area.mp4" 
  done


#North American visible clouds
#Make frames directory if necessary
mkdir -p "namer_vis_fog-frames"

#Clean up any old links
set +e
rm ./namer_vis_fog-frames/*.png
set -e

#Find all of the fog images and sort by filename (which is YYYYMMDD-HHMM)
files=$(find ./aviationweather.gov/data/obs/sat/merc/ -maxdepth 1 -name "*namer_vis_fog.png"  -type f | sort -u)

#Makes links to each saved image in a sequential fashion
a=1
for i in $files; do
  new=$(printf "%03d" ${a}) 
  ln  ${i} ./namer_vis_fog-frames/${new}.png
  let a=a+1
done

echo -e "\n${HIGHLIGHT}North American Fog mp4${NORMAL}"
# 	-b 2048k \
#Create an mp4 from the individual PNGs
avconv \
        -loglevel warning \
        -y \
	-r 5 \
	-i ./namer_vis_fog-frames/%03d.png   \
	-r 24 \
	-vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
	"$destination_directory/animated_Namer_vis_fog.mp4" 

echo -e "\n${HIGHLIGHT}North American Fog gif${NORMAL}"	
#Create an animated GIF from the PNG files
convert   \
	-delay 20   \
	-loop 0   \
	"./aviationweather.gov/data/obs/sat/merc/*.namer_vis_fog.png"   \
	"$destination_directory/animatedNamerVisFog.gif" \
	
