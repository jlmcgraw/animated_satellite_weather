#!/bin/bash
set -eu                # Always put this in Bourne shell scripts
IFS=$(printf '\n\t')  # Always put this in Bourne shell scripts

#Update the imagery and recreate the movies every 6 hours
sleep_length="1h"

while true 
    do
        ./freshenLocalData.sh
        ./makeSatelliteMovies.sh
        echo "Sleeping for $sleep_length at $(date)"
        sleep $sleep_length
    done