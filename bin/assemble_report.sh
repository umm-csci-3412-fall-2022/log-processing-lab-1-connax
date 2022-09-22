#!/bin/sh

dirname=$1
currDir=$(pwd)

cd "$dirname" || exit

touch report.txt

cat country_dist.html hours_dist.html username_dist.html > report.txt

cd "$currDir" || exit

./bin/wrap_contents.sh "$dirname"/report.txt html_components/summary_plots "$dirname"/failed_login_summary.html

rm "$dirname"/report.txt
