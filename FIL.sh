#!/bin/bash
# FIL 
rm -rf /tmp/fil/
mkdir -p /tmp/fil
name=`date +%F.%H-%M-%S`
hn=`hostname`
./fetchdata.sh >> /tmp/fil/sysinfo$name
tar cvzf  /tmp/FIL_"$hn"_"$name".tar.gz /tmp/fil/*

