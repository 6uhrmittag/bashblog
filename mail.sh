#!/bin/bash
#TODO: tags

#Debugmessage
debug_time=$(date +"%T")
debug_date="$(date +'%d/%m/%Y')"
echo "$debug_date - $debug_time - Start Email import"

#load config
path_config="./config/config.conf"
. $path_config
file_mailxml="$path_temp/mail.xml"
file_ids="$path_ids/ids.txt"
touch $file_ids

#Initialize Variables
counter_entries_imported=0
counter_entry=1

#Download RSS feed
feed=$(curl --silent "https://zapier.com/engine/rss/2528358/blogeintrag/")
feed=$(echo $feed | sed 's/%0D%0A%0D%0A//g' | sed 's/%0D%0A//g')
echo $feed > $file_mailxml

#Count entries in RSS
counter_entries_in_rss=$(xmlstarlet sel -t -v "count(/rss//item/title)" $file_mailxml)

#Import entries
while [ $counter_entry -le $counter_entries_in_rss ];do
  #Extract ID
  id=$(xmlstarlet sel -t -m "/rss//item[$counter_entry]/guid" -v . -n $file_mailxml)
  #Check if ID already imported. Import only new entries
  if [ "$(grep "$id" $file_ids)" = "" ]; then
    #echo "New entry found!"

    #Titel
    entry_text=$(xmlstarlet sel -t -m "/rss//item[$counter_entry]/title" -v . -n $file_mailxml)

    #URL
    url=$(xmlstarlet sel -t -m "/rss//item[$counter_entry]/link" -v . -n $file_mailxml)

    #Store ID
    echo $id >> $file_ids


    #Create entry html
    . $install_path/beitraggenerieren.sh


    counter_entries_imported=$(($counter_entries_imported+1))
  fi

  counter_entry=$(($counter_entry+1))
done

#Delete mail.xml
rm $file_mailxml

if [ $counter_entries_imported -ne 0 ]; then
  #create new index.html
  . $install_path/generate_index.sh
fi


echo "Imported entries: $counter_entries_imported"
echo "Email import done."

echo "---------------------------------------------------"
