#!/bin/sh

content_file=$1
headNfoot=$2
file_name=$3

touch "$file_name"

cat "$headNfoot"_header.html "$content_file" "$headNfoot"_footer.html > "$file_name"
