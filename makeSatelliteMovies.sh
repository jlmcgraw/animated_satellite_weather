#!/bin/bash
set -eu                # Always put this in Bourne shell scripts
IFS="`printf '\n\t'`"  # Always put this in Bourne shell scripts

#sudo apt-get install libav

# ICAO AREA A  
# • Americas • Mercator • 65N-50S 120W-25W • (From image: 67N-54S , 137W-13W)
# ICAO AREA B1 
# • Africa - Americas • Mercator • 50N-40S 125W-25E (From image: 63N-45S, 125W-40E)
# ICAO AREA C  
# • Europe-Africa • Mercator • 76N-45S 65E-31W • (From image: 75n-45s,35w-70e)
# ICAO AREA D 
# • Asia • Mercator • 65N-28S 133E-15W • (From image: 63N-27S, 15W-132E)
# ICAO AREA E  
# • Asia-Australia • Mercator • 45N-47S 180E-24E (From image: 45n-47s,180e-24e)
# ICAO AREA F  
# • Pacific • Mercator • 45N-45S 105E-100W (From image: 50n-53s,100e-110w)
# ICAO AREA G 
# • Asia • Mercator • Centered on 75E • (From image: PS Center on 65e)
# ICAO AREA H  
# • Europe - North America • North Polar Stereographic • Centered on 45W •
# ICAO AREA I  
# • North America - ASIA • North Polar Stereographic • Centered on 155W •
# CAO AREA J  
# • South Pole • Polar Stereographic • Centered on 142W •
# ICAO AREA M   
# • Pacific • Mercator • 70N-10S 100E-110W •

#Clean up any old links
rm ./IrIcao-A-frames/*.jpg

#Makes links to each saved image in a sequential fashion
files=$(find ./aviationweather.gov/data/obs/sat/intl/ -name "*_ir_ICAO-A.jpg" -maxdepth 1 -type f | sort -u)
a=1
for i in $files; do
  new=$(printf "%03d" ${a}) 
  ln  ${i} ./IrIcao-A-frames/${new}.jpg
  let a=a+1
done

#Create an mp4 from the individual jpegs
avconv \
	-r 5 \
	-i ./IrIcao-A-frames/%03d.jpg   \
	-r 24 \
	-b 2048k \
	-vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
	"/media/sf_Shared_Folder/animatedIrIcao-A.mp4" 


#Clean up any old links
rm ./namer_vis_fog-frames/*.png

#Makes links to each saved image in a sequential fashion
files=$(find ./aviationweather.gov/data/obs/sat/merc/ -name "*namer_vis_fog.png" -maxdepth 1 -type f | sort -u)
a=1
for i in $files; do
  new=$(printf "%03d" ${a}) 
  ln  ${i} ./namer_vis_fog-frames/${new}.png
  let a=a+1
done

#Create an mp4 from the individual jpegs
avconv \
	-r 5 \
	-i ./namer_vis_fog-frames/%03d.png   \
	-r 24 \
	-b 2048k \
	-vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
	"/media/sf_Shared_Folder/animatedNamer_vis_fog.mp4" 

	
	# 
# convert   \
# 	-delay 20   \
# 	-loop 0   \
# 	"./aviationweather.gov/data/obs/sat/merc/*.namer_vis_fog.png"   \
# 	"./animatedNamerVisFog.gif" \
# 	
