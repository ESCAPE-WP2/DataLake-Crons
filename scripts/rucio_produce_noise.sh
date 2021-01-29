#!/bin/bash

cd /scripts/Utilities-and-Operations-Scripts/
git pull
cd /scripts/

python3 Utilities-and-Operations-Scripts/cric-info-tools/list_rses_from_cric.py -o list_rses_from_cric.txt -i Utilities-and-Operations-Scripts/cric-info-tools/disabled_rses.txt

rses=()
while read line
do
    rses+=($line)
done < list_rses_from_cric.txt

len=${#rses[@]}

echo '* RUCIO Produce Noise * Exporting ENV Variables'

FILE_SIZE=${FILE_SIZE:-1000M}
RUCIO_SCOPE=${RUCIO_SCOPE:-ESCAPE_CERN_TEAM-noise}
FILE_LIFETIME=${FILE_LIFETIME:-3600}

upload_and_transfer () {
    for (( i=0; i<$len; i++ )); do
        RANDOM_STRING=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
        
        filename=/tmp/auto_uploaded_$RANDOM_STRING
        did=auto_uploaded_$RANDOM_STRING
        
        echo '*** filename' $filename
        
        # truncate -s $FILE_SIZE $filename ## !! 10M (10485760 byte) empty file whose adler32 should be 09600001, which is problematic for STORM due to the leading '0'
        # dd if=/dev/urandom of=$filename bs=1048576 count=$FILE_SIZE ## output should be filtered away '> /dev/null 2>&1'
        head -c $FILE_SIZE < /dev/urandom  > $filename
        
        if [ $1 != $i ]; then
            echo '*** upload to rse' ${rses[$1]}
            rucio -v upload --rse ${rses[$1]} --lifetime $FILE_LIFETIME --scope $RUCIO_SCOPE $filename || return '1' #continue
            echo '*** add-rule to rse' ${rses[$i]}
            rucio add-rule --lifetime $FILE_LIFETIME $RUCIO_SCOPE:$did 1 ${rses[$i]};
	    fi
        rm $filename
    done
}

echo '* RUCIO Produce Noise * Starting'

for (( j=0; j<$len; j++ )); do
    upload_and_transfer $j
done

echo '* RUCIO Produce Noise * Done!'