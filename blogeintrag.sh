#!/bin/bash


#TODO
#variablen statt filenames
#Linebreak bei Eingabe führt zur Bestätigung -> ignorieren um mehrzeilige Eingabe zu ermöglichen
#Tags in html link ändern


#loadad config
path_config="./config/config.conf"
. $path_config



#Variablen setzen
confirm="n"

#Eintragen ANFANG
while [ "$confirm" = "n" ] ; do
printf "URL: "
read   url

printf "Text: "
read eintragstext

printf "Tags: "
read tags

printf "Du hast folgendes eingegeben: \n$url\n$eintragstext\n$tags\n"


#Abfrage ist noch fehlerhaft. bei "else" sollte der komplette untere Teil übersprungen werden, macht sonst keinen Sinn.
printf "Eintrag so speichern?(y/n)"
read confirm
if [ "$confirm" = "y" ]; then
  #Eintrag als Variable gespeichert

  #Sonderzeichen Umwandeln. Es fehlt ' und " - ToDO: alles in for-schleife
  temp_eintragstext=${eintragstext//</&lt;}
  eintragstext=$temp_eintragstext
  temp_eintragstext=${eintragstext//>/&gt;}
  eintragstext=$temp_eintragstext
  temp_eintragstext=${eintragstext//&/&amp;}
  eintragstext=$temp_eintragstext


  #In HTML wandeln ANFANG
  #Eintrag in HTML umwandeln und in Variable speichern
  # "EndOfMessage" ist eine variable Bezeichnung, die das Ende angiebt -> Muss in eigener Zeile stehen!
  #https://stackoverflow.com/questions/23929235/multi-line-string-with-extra-space-preserved-indentation
  EINTRAG_IN_HTML=$(cat<<EndOfMessage

  <!-- EINTRAG ANFANG -->
  <div class="eintrag">
        <div class="url">
              <a href="$url" target="_blank">$eintragstext</a>
        </div>

        <div class="tags">
              $tags
        </div>
        <br />
  </div>
  <!-- EINTRAG ENDE -->
EndOfMessage
  )
  #In HTML wandeln ENDE



  #Aktuelles Datum
  DATE=`date +%d_%m_%Y`

  #Generiere html pro Tag
  touch "$path_entries/tag_$DATE.html"

  #Tägliche Einträge in eintraege.html sammeln bzw. an den Anfang schreiben
  echo "$EINTRAG_IN_HTML" | cat - "$path_entries/tag_$DATE.html" > $path_temp/temp && mv $path_temp/temp "$path_entries/tag_$DATE.html"

  #Leere eintraege.html
#  echo "" > "eintraege.html"

  #Füge index.html aus allen Einträgen zusammen
  #ls -> Ordner "beitraege" ausgeben, mit "sort -M" nach Monat sortieren und "-r" umdrehen
#  for FILE in $(ls beitraege| sort -M -r ); do
#    cat "./templates/tag_anfang" >> "eintraege.html"
#    #Datum aus Filename extraieren
#    datum=$(echo "./beitraege/$FILE" | cut -d. -f2 | cut -d_ -f2,3,4 | tr _ .)
#    echo "    $datum" >> "eintraege.html"
#    cat "./templates/tag_mitte" >> "eintraege.html"
#    cat "./beitraege/$FILE" >> "eintraege.html"
#    cat "./templates/tag_ende" >> "eintraege.html"
#  done



  #aktualisierte index.html zusammenbauen
 # cat ./templates/index_anfang.html eintraege.html ./templates/index_ende.html > index.html
  #rm eintraege.html

#Neue Index.html erstellen:
. $path_scripts/bloggenerieren.sh


  echo "Gespeichert."
else
  echo "Abgebrochen."
  break
fi

done
#Eintragen ENDE
