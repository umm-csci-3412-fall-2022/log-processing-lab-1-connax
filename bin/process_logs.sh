#!/bin/sh


scratch=$(mktemp --directory)



for tgzfile in "$@"
do

	compname=$(basename -s _secure.tgz "$tgzfile")
	
	mkdir "$scratch"/"$compname"

	tar -xf "$tgzfile" --directory  "$scratch"/"$compname"	
         ./bin/process_client_logs.sh "$scratch"/"$compname"
done

./bin/create_username_dist.sh "$scratch"

./bin/create_hours_dist.sh "$scratch"

./bin/create_country_dist.sh "$scratch"

./bin/assemble_report.sh "$scratch"

mv "$scratch"/failed_login_summary.html ./

rm -rf "$scratch"
