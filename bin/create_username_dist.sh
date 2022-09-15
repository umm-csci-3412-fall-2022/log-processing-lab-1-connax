#!/bin/sh
# It takes a directory, which is assumed to contain sub-directories and nothing else.

# For now we assume this is the directory of the computer name, not the directory with all the computer names
dirname=$1

cd "$dirname"

touch username_dist.html

awk 'match($0, /(\S+) \S+$/, group) {print group[1]}' < failed_login_data.txt | sort | uniq -c | awk 'match($0, /([0-9]+) (\S+)/, group){print "data.addrow([\x27" group[2] "\x27,"group[1] "]);"}'>> username_dist.html

