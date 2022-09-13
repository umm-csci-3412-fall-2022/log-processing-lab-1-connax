#!/bin/sh

scratch=$(mktemp --directory)

#We want to loop this later

touch failed_login_data.txt

for tgzfile in ../log_files/*

do

	tgzdirname=$(basename -s _secure.tgz $tgzfile)

	echo "$tgzdirname"

	pushd "$scratch"

	mkdir "$tgzdirname"

	popd

	tar -xvf "$tgzfile" --directory "$scratch"/"$tgzdirname"

	for logfile in "$scratch"/"$tgzdirname"/var/log/*

	do

		echo "$logfile"

		awk 'match($0, /([a-zA-Z]+\s[0-9]+\s[0-9]+):.+Failed\spassword.+user\s(\w+)\sfrom\s(\S+)/, groups) {print  groups[1] " " groups[2] " " groups[3]}' < "$logfile" > failed_login_data.txt

	done
done
rm -rf "$scratch"
