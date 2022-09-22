#!/bin/sh

#We want to loop this later

tgzdirname=$1

touch failed_login_data.txt

for logfile in  "$tgzdirname"/var/log/*
do


	awk 'match($0, /(\S+)\s+(\S+) (\S+):[0-9]+:[0-9]+.+Failed\spassword\s.+\s(\S+)\sfrom\s(\S+)\sport.+$/, groups) {print groups[1] " " groups[2] " " groups[3] " " groups[4] " " groups[5]}' < "${logfile}" >> failed_login_data.txt

done

mv failed_login_data.txt "$tgzdirname"
