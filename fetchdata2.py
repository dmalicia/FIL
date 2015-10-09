#!/usr/bin/python

import subprocess
import os
import sys


#cmdls = "./fetchdata.sh > sysinfo`date +%F.%H-%M-%S`.log"
cmdls = "./fetchdata.sh > "
p = subprocess.Popen(cmdls, stdout=subprocess.PIPE, shell=True)
f = os.popen('date +%F.%H-%M-%S')
now = f.read()
print "Today is ", now

subprocess.call([cmdls, now ])
output, err = p.communicate()
print output

sys.exit()
