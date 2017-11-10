#!/bin/bash


#TODO
#variablen statt filenames
#Linebreak bei Eingabe führt zur Bestätigung -> ignorieren um mehrzeilige Eingabe zu ermöglichen
#Tags in html link ändern


#load config
path_config="./config/config.conf"
. $path_config

#Initialize Variables
confirm="e"
url=""
entry_text=""
tags=""

#Start input
while [ "$confirm" = "e" ] ; do
  printf "URL: "
  read   url

  printf "Text: "
  read entry_text

  printf "Tags: "
  read tags

  echo "----------------------------"
  echo "Entry:"
  echo "URL: $url"
  echo "Text: $entry_text"
  echo "Tags: $tags"
  echo "----------------------------"

  #printf "You entered: \n$url\n$entry_text\n$tags\n"


  #Save entry
  echo "Publish = ENTER"
  echo "Edit    = e"
  echo "Cancel  = c"
  read confirm
  if [ "$confirm" = "c" ]; then
    break
  elif [[ "$confirm" = "e" ]]; then
    echo "next try"
  else
    #Create entry html
    . $install_path/beitraggenerieren.sh

    #Generate new index.html:
    . $path_scripts/generate_index.sh


    echo "Entry published!"
    break
  fi

done
#Eintragen ENDE
