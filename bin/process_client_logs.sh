#!/bin/sh

#We want to loop this later

tgzdirname=$1

touch failed_login_data.txt

for logfile in  "$tgzdirname"/var/log/*
do

	echo $logfile
	awk 'match($0, /(.+):[0-9]+:[0-9]+\scomputer_name.+\s(\w+)\sfrom\s(\S+)\sport.+$/, groups) {print  groups[1] " " groups[2] " " groups[3]}' < "${logfile}" >> failed_login_data.txt

done
