#!/usr/bin/python

import subprocess
import os
import sys


cmdls = "./fetchdata.sh > logs/sysinfo`date +%F.%H-%M-%S`.log"
p = subprocess.Popen(cmdls, stdout=subprocess.PIPE, shell=True)

output, err = p.communicate()
print cmdls
print output

sys.exit()
