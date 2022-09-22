
#!/bin/sh
dirname=$1

touch listofcountries.txt
touch countries.html
touch sortcountry.txt

for compdir in "$dirname"/*

do
awk 'match($0, / (\S+)$/, group) {print group[1]}' < ${compdir}/failed_login_data.txt >> listofcountries.txt
done

sort listofcountries.txt > sortcountry.txt

join sortcountry.txt etc/country_IP_map.txt | awk 'match($0, /\S+ ([a-zA-Z]+)/, group) {print group[1]}' | sort > ./listofcountries.txt

uniq -c listofcountries.txt | awk 'match($0, /([0-9]+) (\S{2})/, group){print "data.addRow([\x27" group[2] "\x27, "group[1] "]);"}'>> ./countries.html




./bin/wrap_contents.sh countries.html html_components/country_dist "$dirname"/country_dist.html

rm listofcountries.txt
rm sortcountry.txt
rm countries.html
