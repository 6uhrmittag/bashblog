#!/bin/bash
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
  touch "./beitraege/tag_$DATE.html"

  #Tägliche Einträge in eintraege.html sammeln bzw. an den Anfang schreiben
  echo "$EINTRAG_IN_HTML" | cat - "./beitraege/tag_$DATE.html" > temp && mv temp "./beitraege/tag_$DATE.html"

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
