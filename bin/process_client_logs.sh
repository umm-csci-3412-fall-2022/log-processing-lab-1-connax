#!/bin/sh

scratch=$(mktemp --directory)

#We want to loop this later
tgzfile=../log_files/ganesha_secure.tgz

tgzdirname= $(awk 'match($0, /([\w+]+)_secure\.tgz$/, name) {print name[1]}' < "$tgzfile")

echo "$tgzdirname"

pushd "$scratch"

mkdir ganesha

popd

tar -xvf "$tgzfile" --directory "$scratch"/ganesha

touch failed_login_data.txt

for logfile in "$scratch"/ganesha/var/log/*

do

	echo "$logfile"

	awk 'match($0, /([a-zA-Z]+\s[0-9]+\s[0-9]+):.+Failed\spassword.+user\s(\w+)\sfrom\s(\S+)/, groups) {print  groups[1] " " groups[2] " " groups[3]}' < "$logfile" > failed_login_data.txt

done

rm -rf "$scratch"
