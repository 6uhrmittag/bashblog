#!/bin/bash
#load config
path_config="./config/config.conf"
. $path_config

source ./modules/translator_youtube.sh


if [[ $(echo $url | grep youtube.com) != "" ]]; then
  echo "youtube link found"
translator_youtube $url
entry_html=$entry_after_translation
else
echo "no Youtube link found"


  #Convert special characters.
  temp_entry_text=${entry_text//</&lt;}
  entry_text=$temp_entry_text
  temp_entry_text=${entry_text//>/&gt;}
  entry_text=$temp_entry_text
  temp_entry_text=${entry_text//&/&amp;}
  entry_text=$temp_entry_text


  #Convert to HTML
  #Converts entry to HTML and stores it in "entry_html"
  #https://stackoverflow.com/questions/23929235/multi-line-string-with-extra-space-preserved-indentation
  entry_html=$(cat<<EndOfMessage

  <!-- Entry Start -->
  <div class="eintrag">
        <div class="url">
              <a href="$url" target="_blank">$entry_text</a>
        </div>

        <div class="tags">
              $tags
        </div>
        <br />
  </div>
  <!-- Entry End -->
EndOfMessage
  )
  #Convert to HTML end


fi


  #Current date
  DATE=`date +%d_%m_%Y`

  #Generate html file for the day
  touch "$path_entries/tag_$DATE.html"

  #Save generated entry to html file of the day. Append to beginning.
  echo "$entry_html" | cat - "$path_entries/tag_$DATE.html" > $path_temp/temp && mv $path_temp/temp "$path_entries/tag_$DATE.html"
