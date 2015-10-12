#!/bin/bash
# grabsysinfo.sh - A simple menu driven shell script to to get information about your 
# Linux server / desktop.
# Author: Vivek Gite
# Date: 12/Sep/2007
 
# Purpose: Display pause prompt
# $1-> Message (optional)
function pause(){
#	local message="$@"
#	[ -z $message ] && message="Press [Enter] key to continue..."
#	read -p "$message" readEnterKey
	echo "..."
}
 
# Purpose  - Display a menu on screen
#function show_menu(){
#    date
#    echo "---------------------------"
#    echo "   Main Menu"
#    echo "---------------------------"
#	echo "1. Operating system info"
#	echo "2. Hostname and dns info"
#	echo "3. Network info"
#	echo "4. Who is online"
#	echo "5. Last logged in users"
#	echo "6. Free and used memory info"
#	echo "7. exit"
#}
 
# Purpose - Display header message
# $1 - message
function write_header(){
	local h="$@"
	echo "---------------------------------------------------------------"
	echo "     ${h}"
	echo "---------------------------------------------------------------"
}
 
# Purpose - Get info about your operating system
function os_info(){
        write_header " System information "
        echo "Operating system : $(uname -a)"
#        [ -x $LSB ] && $LSB -a || echo "$LSB command is not insalled (set \$LSB variable)"
        #pause "Press [Enter] key to continue..."
	#pause "Press [Enter] key to continue..."
	pause
}
 
# Purpose - Get info about host such as dns, IP, and hostname
function host_info(){
	local dnsips=$(sed -e '/^$/d' /etc/resolv.conf | awk '{if (tolower($1)=="nameserver") print $2}')
	write_header " Hostname and DNS information "
	echo "Hostname : $(hostname -s)"
	echo "DNS domain : $(hostname -d)"
	echo "Fully qualified domain name : $(hostname -f)"
	echo "Network address (IP) :  $(hostname -i)"
	echo "DNS name servers (DNS IP) : ${dnsips}"
	pause
}
 
# Purpose - Network inferface and routing info
function net_info(){
	devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo")
	write_header " Network information "
	echo "Total network interfaces found : $(wc -w <<<${devices})"
 
	echo "*** IP Addresses Information ***"
	ip -4 address show
 
	echo "***********************"
	echo "*** Network routing ***"
	echo "***********************"
	netstat -nr
 
	echo "**************************************"
	echo "*** Interface traffic information ***"
	echo "**************************************"
	netstat -i
 
	pause 
}
 
# Purpose - Display a list of users currently logged on 
#           display a list of receltly loggged in users   
function user_info(){
	local cmd="$1"
	case "$cmd" in 
		who) write_header " Who is online "; who -H; pause ;;
		last) write_header " List of last logged in users "; last ; pause ;;
	esac 
}
 
# Purpose - Display used and free memory info
function mem_info(){
	write_header " Free and used memory "
	free -m
 
    echo "*********************************"
	echo "*** Virtual memory statistics ***"
    echo "*********************************"
	vmstat
    echo "***********************************"
	echo "*** Top 5 memory eating process ***"
    echo "***********************************"	
	ps auxf | sort -nr -k 4 | head -5	
	pause
}

function collect_logs(){
#	rm -rf /tmp/fil
#	mkdir -p /tmp/fil
	find /var/log -name "*.log" | while read line
		do
       logname=$(sed 's|\/|\_|g' <<< $line)
	echo $logname
	cp -r $line /tmp/fil/$logname 
	done
}
 
# ignore CTRL+C, CTRL+Z and quit singles using the trap
#trap '' SIGINT SIGQUIT SIGTSTP
 
# main logic
#while true
#do
#	clear
# 	show_menu	# display memu
# 	read_input  # wait for user input
#done
		os_info 
		host_info 
                net_info 
                user_info "who" 
                user_info "last" 
                mem_info
		collect_logs 
                echo "Bye!"; exit 0 


