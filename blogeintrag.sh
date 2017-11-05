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


  #Create entry html
  . $install_path/beitraggenerieren.sh


#Neue Index.html erstellen:
. $path_scripts/bloggenerieren.sh


  echo "Gespeichert."
else
  echo "Abgebrochen."
  break
fi

done
#Eintragen ENDE
