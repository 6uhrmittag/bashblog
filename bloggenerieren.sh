#!/bin/bash
#

echo "" > eintraege.html


#Füge index.html aus allen Einträgen zusammen
for FILE in $(ls beitraege| sort -t_ -n -k4 -r -k3 ); do
  cat "./templates/tag_anfang" >> "eintraege.html"
  #Datum aus Filename extraieren  
   datum=$(echo "./beitraege/$FILE" | cut -d. -f2 | cut -d_ -f2,3,4 | tr _ .)
#  datum=$(echo "./beitraege/$FILE" | cut -d_ -f2-4 | sort -n | cut -d_ -f3 | sort -n | cut -d_ -f4 | sort -n -r
 
 echo "    $datum" >> "eintraege.html"
  cat "./templates/tag_mitte" >> "eintraege.html"
  cat "./beitraege/$FILE" >> "eintraege.html"
  cat "./templates/tag_ende" >> "eintraege.html"
done




#aktualisierte index.html zusammenbauen
cat ./templates/index_anfang.html eintraege.html ./templates/index_ende.html > index.html

rm eintraege.html



echo "Neue index.html generiert!"
