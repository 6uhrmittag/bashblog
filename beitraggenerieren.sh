#!/bin/bash
#load config
path_config="./config/config.conf"
. $path_config


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

