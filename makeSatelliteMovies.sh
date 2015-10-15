#!/bin/bash
set -eu                # Always put this in Bourne shell scripts
IFS=$(printf '\n\t')  # Always put this in Bourne shell scripts

#sudo apt-get install libav

#Where to save the completed movie
destination_directory="/media/sf_Shared_Folder"

namer_vis_fog_directory="./aviationweather.gov/data/obs/sat/merc/"
ir_icao_directory="./aviationweather.gov/data/obs/sat/intl/"
vis_goes_directory="./aviationweather.gov/data/obs/sat/goes/"

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

#-------------------------------------------------------------------------------------------------------------------
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

#-------------------------------------------------------------------------------------------------------------------
#GOES visible

#For each area..
for area in E W
  do
    vis_goes_frames_directory="vis_goes_$area-frames"
    #Make directory for this area if necessary
    echo -e "\n${HIGHLIGHT}Geos Visible Area: $area${NORMAL}"
    mkdir -p "$vis_goes_frames_directory"
    set +e
    #Clean out old frame links for this area
    rm "$vis_goes_frames_directory"/*.jpg
    rm "$vis_goes_frames_directory"/*.png
    set -e 
    
    #Find all files of type ir and sort by filename (which is YYYYMMDD-HHMM)
    files=$(find ./aviationweather.gov/data/obs/sat/goes/ -maxdepth 1 -name "????????_????_vis_goes$area.jpg"  -type f | sort -u)

    #Make new links to each saved image in a sequential fashion
    a=1
    for i in $files
      do
	new=$(printf "%03d" ${a})
# 	echo "${i} -> ${new}"
	ln  ${i} ./$vis_goes_frames_directory/${new}.jpg
	let a=a+1
      done
    
    #Create an mp4 from the individual jpegs
    avconv \
            -loglevel warning \
	    -y \
	    -r 5 \
	    -i ./$vis_goes_frames_directory/%03d.jpg   \
	    -r 24 \
	    -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
	    "$destination_directory/animated_vis_goes-$area.mp4" 
  done

#-------------------------------------------------------------------------------------------------------------------
#Radar rcm tops

#For each area..
for area in rcm
  do
    rcm_tops_frames_directory="rcm_tops-frames"
    #Make directory for this area if necessary
    echo -e "\n${HIGHLIGHT}rcm tops: $area ${NORMAL}"
    mkdir -p "$rcm_tops_frames_directory"
    set +e
    #Clean out old frame links for this area
    rm "$rcm_tops_frames_directory"/*.gif
    set -e 
    
    #Find all files of type ir and sort by filename (which is YYYYMMDD-HHMM)
    files=$(find ./aviationweather.gov/data/obs/radar/ -maxdepth 1 -name "????????_????_rcm_tops.gif"  -type f | sort -u)

    #Make new links to each saved image in a sequential fashion
    a=1
    for i in $files
      do
	new=$(printf "%03d" ${a})
# 	echo "${i} -> ${new}"
	ln  ${i} ./$rcm_tops_frames_directory/${new}.gif
	let a=a+1
      done
    
    #Create an mp4 from the individual jpegs
    avconv \
            -loglevel warning \
	    -y \
	    -r 5 \
	    -i ./$rcm_tops_frames_directory/%03d.gif   \
	    -r 24 \
	    -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
	    "$destination_directory/animated_rcm_tops-$area.mp4" 
  done