#!/bin/sh
# It takes a directory, which is assumed to contain sub-directories and nothing else.

dirname=$1

touch listofusers.txt
touch username.html

for compdir in "$dirname"/*/

do
awk 'match($0, /(\S+) \S+$/, group) {print group[1]}' < ${compdir}/failed_login_data.txt >> listofusers.txt
done

sort listofusers.txt | uniq -c | awk 'match($0, /([0-9]+) (\S+)/, group){print "data.addRow([\x27" group[2] "\x27, "group[1] "]);"}'>> ./username.html




./bin/wrap_contents.sh username.html html_components/username_dist "$dirname"/username_dist.html

rm listofusers.txt
rm username.html
