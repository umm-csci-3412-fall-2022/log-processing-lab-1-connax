#!/bin/sh

dirname=$1

touch listofhours.txt
touch hours.html

for compdir in "$dirname"/*/

do
awk 'match($0, /\S+ \S+ ([0-9]{2})/, group) {print group[1]}' < "$compdir"/failed_login_data.txt >> listofhours.txt
done

sort listofhours.txt | uniq -c | awk 'match($0, /([0-9]+) (\S+)/, group){print "data.addRow([\x27" group[2] "\x27, "group[1] "]);"}'>> ./hours.html

./bin/wrap_contents.sh hours.html html_components/hours_dist "$dirname"/hours_dist.html

rm listofhours.txt
rm hours.html
