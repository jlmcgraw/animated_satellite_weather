#!/bin/bash
set -eu                # Always put this in Bourne shell scripts
IFS=$(printf '\n\t')  # Always put this in Bourne shell scripts

#Update the imagery and recreate the movies every 6 hours

while true 
    do
        ./freshenLocalData.sh
        ./makeSatelliteMovies.sh
        echo "Sleeping..."
        sleep 6h
    done