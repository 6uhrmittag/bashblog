#!/bin/bash
#

#loadad config
path_config="./config/config.conf"
. $path_config


touch $path_temp/eintraege.html
echo "" > $path_temp/eintraege.html


#Füge index.html aus allen Einträgen zusammen
for FILE in $(ls $path_entries| sort -t_ -n -k4 -r -k3 ); do
  cat "$path_templates/tag_anfang.html" >> "$path_temp/eintraege.html"
  #Datum aus Filename extraieren  
  datum=$(echo $path_entries/$FILE | cut -d. -f1 | cut -d_ -f2,3,4 | tr _ .)
#   datum=$(echo "$path_entries/$FILE" | cut -d. -f2 | cut -d_ -f2,3,4 | tr _ .)
#  datum=$(echo "$path_entries/$FILE" | cut -d_ -f2-4 | sort -n | cut -d_ -f3 | sort -n | cut -d_ -f4 | sort -n -r
 
  echo "    $datum" >> "$path_temp/eintraege.html"
  cat "$path_templates/tag_mitte.html" >> "$path_temp/eintraege.html"
  cat "$path_entries/$FILE" >> "$path_temp/eintraege.html"
  cat "$path_templates/tag_ende.html" >> "$path_temp/eintraege.html"
done




#aktualisierte index.html zusammenbauen
cat $path_templates/index_anfang.html $path_temp/eintraege.html $path_templates/index_ende.html > $html_path/index.html

rm $path_temp/eintraege.html



echo "Neue index.html generiert!"
