
#!/bin/sh

dirname=$1



pushd "$dirname"

touch report.txt

cat country_dist.html hours_dist.html username_dist.html > report.txt

popd

./bin/wrap_contents.sh "$dirname"/report.txt html_components/summary_plots "$dirname"/failed_login_summary.html

rm "$dirname"/report.txt