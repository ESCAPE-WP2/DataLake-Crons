#!/bin/bash

python Utilities-and-Operations-Scripts/cric-info-tools/list_rses_from_cric.py -o list_rses_from_cric.txt

rses=()
while read line
do
    rses+=($line)
done < list_rses_from_cric.txt

len=${#rses[@]}

echo '* RUCIO Produce Noise * Exporting ENV Variables'

SLEEP_TIME_MINUTES=${NOISE_SLEEP_TIME_MINUTES:-30m}
FILE_SIZE=${FILE_SIZE:-10M}
RUCIO_SCOPE=${RUCIO_SCOPE:-ESCAPE_CERN_TEAM-noise}

upload_and_transfer () {
    for (( i=0; i<$len; i++ )); do
        RANDOM_STRING=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
        
        filename=/tmp/auto_uploaded_$RANDOM_STRING
        did=auto_uploaded_$RANDOM_STRING
        
        echo '*** filename' $filename
        
        truncate -s $FILE_SIZE $filename
        
        if [ $1 != $i ]; then
            echo '*** upload to rse' ${rses[$1]}
	        rucio upload --rse ${rses[$1]} --scope $RUCIO_SCOPE $filename || return '1' #continue
            echo '*** add-rule to rse' ${rses[$i]}
            rucio add-rule $RUCIO_SCOPE:$did 1 ${rses[$i]};
	    fi
        rm $filename
    done
}

echo '* RUCIO Produce Noise * Initializing Loop'

while true; do
    for (( j=0; j<$len; j++ )); do
        upload_and_transfer $j
    done

    echo '* RUCIO Produce Noise * Will sleep for ' $SLEEP_TIME_MINUTES
    sleep $SLEEP_TIME_MINUTES
done