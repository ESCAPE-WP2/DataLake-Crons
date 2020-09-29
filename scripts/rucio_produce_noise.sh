#!/bin/bash

rses[0]="ALPAMED-DPM"
rses[1]="CNAF-STORM"
rses[2]="DESY-DCACHE"
rses[3]="EULAKE-1"
rses[4]="EULAKE-2"
rses[5]="GSI-ROOT"
rses[6]="IN2P3-CC-DCACHE"
rses[7]="INFN-NA-DPM"
rses[8]="LAPP-DCACHE"
rses[9]="LAPP-DPM"
rses[10]="PIC-DCACHE"
rses[11]="PIC-INJECT"
rses[12]="SARA-DCACHE"

echo '* RUCIO Produce Noise * Exporting ENV Variables'

SLEEP_TIME_MINUTES=${NOISE_SLEEP_TIME_MINUTES:-20m}
FILE_SIZE=${FILE_SIZE:-10M}

upload_and_transfer () {
    len=${#rses[@]}
    for (( i=0; i<$len; i++ )); do
        RANDOM_STRING=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
        
        filename=/tmp/auto_uploaded_$RANDOM_STRING
        did=auto_uploaded_$RANDOM_STRING
        
        echo $filename
        
        truncate -s $FILE_SIZE $filename
        
        if [ $1 != $i ]; then
	        rucio upload --rse ${rses[$1]} --scope noise_5 $filename || return '1' #continue
            rucio add-rule noise_5:$did 1 ${rses[$i]};
	    fi
        rm $filename
    done
}

echo '* RUCIO Produce Noise * Initializing Loop'

while true; do

    upload_and_transfer 0
    upload_and_transfer 1
    upload_and_transfer 2
    upload_and_transfer 3
    upload_and_transfer 4
    upload_and_transfer 5
    upload_and_transfer 6
    upload_and_transfer 7
    upload_and_transfer 8
    upload_and_transfer 9
    upload_and_transfer 10
    upload_and_transfer 11
    upload_and_transfer 12

    echo '* RUCIO Produce Noise * Will sleep for ' $SLEEP_TIME_MINUTES
    sleep $SLEEP_TIME_MINUTES
done