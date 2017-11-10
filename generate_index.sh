#!/bin/bash
#This Script generates a new index.html out of all seperate parts

#load config
path_config="./config/config.conf"
. $path_config

#Generate Menu
. ./generate_menu.sh

#Generate Entries.html
##Create File
touch $path_temp/entries.html
echo "" > $path_temp/entries.html

#Insert seperate Entries into one .html
for FILE in $(ls $path_entries| sort -t_ -n -k4 -r -k3 ); do
  cat "$path_templates/day_start.html" >> "$path_temp/entries.html"
  #Datum aus Filename extraieren
  datum=$(echo $path_entries/$FILE | cut -d. -f1 | cut -d_ -f2,3,4 | tr _ .)

  echo "    $datum" >> "$path_temp/entries.html"
  cat "$path_templates/day_middle.html" >> "$path_temp/entries.html"
  cat "$path_entries/$FILE" >> "$path_temp/entries.html"
  cat "$path_templates/day_end.html" >> "$path_temp/entries.html"
done
#end: Generate Entries.html


#Generate new index.html
##Create File
touch $html_path/index.html
echo "" > $html_path/index.html

##Insert Parts into index.html
echo '<!DOCTYPE html>' >> $html_path/index.html

cat $path_templates/meta.html  >> $html_path/index.html
cat $path_templates/header.html  >> $html_path/index.html
cat $path_temp/menu.html  >> $html_path/index.html

echo '<div id="inhalt">' >> $html_path/index.html
cat $path_temp/entries.html >> $html_path/index.html
echo '</div>' >> $html_path/index.html

echo '</body>' >> $html_path/index.html
echo '</html>' >> $html_path/index.html
#end: Generate new index.html

##Delete Tempfiles
rm $path_temp/entries.html
rm $path_temp/menu.html
#end: Delete Tempfiles


###Todo: Check for errors
echo "Generated: index.html"
