#!/bin/bash
mkdir -p /tmp/fil
find /var/log -name "*.log" | while read line
do
        logname=$(sed 's|\/|\_|g' <<< $line)
	echo $logname
#	cp -r $line /tmp/fil/$logname 
done

tar cvzf templogs.gz /tmp/fil/*

#transfer S3

#Remove all tmp files
