#!/bin/bash
#TODO: tags

#loadad config
path_config="./config/config.conf"
. $path_config
file_mailxml="$path_temp/mail.xml"
file_ids="$path_ids/ids.txt"
touch $file_ids

feed=$(curl --silent "https://zapier.com/engine/rss/2528358/blogeintrag/")
feed=$(echo $feed | sed 's/%0D%0A%0D%0A//g' | sed 's/%0D%0A//g')
echo $feed > $file_mailxml

phasedfeed=$(xml_grep "/*" $file_mailxml)
zahl=1
beitagscounter=0
#echo $phasedfeed

#Einträge zählen 
#beitragscounter=$(xml_grep --count "rss//item/title" mail.xml | head -n 1 | cut -d: -f2 | tr -d '[:space:]')
#echo "Beiträge gefunden: $beitragscounter"
beitragscounter=$(xmlstarlet sel -t -v "count(/rss//item/title)" $file_mailxml)
beitrag=1

#Schleife für jeden Eintrag
while [ $beitrag -le $beitragscounter ];do
#Extract ID
id=$(xmlstarlet sel -t -m "/rss//item[$beitrag]/guid" -v . -n $file_mailxml)
#Check if ID already imported. Import only new entries
if [ "$(grep "$id" $file_ids)" = "" ]
then
#echo "New entry found!"

#Titel
eintragstext=$(xmlstarlet sel -t -m "/rss//item[$beitrag]/title" -v . -n $file_mailxml)
#echo "Entry imported: $eintragstext"

#URL
url=$(xmlstarlet sel -t -m "/rss//item[$beitrag]/link" -v . -n $file_mailxml)
#echo "URL: $url"
#echo $(xmlstarlet sel -t -m "/rss//item[1]/description" -v . -n mail.xml | cut -d\; -f1)
#echo $(xmlstarlet sel -t -m "/rss//item[1]/description" -v . -n mail.xml | cut -d' ' -f2)
#echo $(xmlstarlet sel -t -m "/rss//item[1]/description" -v . -n mail.xml | cut -d' ' -f3)
#echo $(xmlstarlet sel -t -m "/rss//item[1]/description" -v . -n mail.xml | cut -d' ' -f4)


#echo $(xmlstarlet sel -t -m "/rss//item[$beitrag]/title" -v . -n mail.xml)
#echo $(xml_grep --cond "/rss//item[$beitrag]/title" mail.xml)
#echo "beitrag generiert"

#Store ID
echo $id >> $file_ids


#Create entry html
. $install_path/beitraggenerieren.sh
#else
#	echo "Entry already imported!"
fi


beitrag=$(($beitrag+1))
done

#Delete mail.xml
rm $file_mailxml



#create new index.html
. $install_path/bloggenerieren.sh
echo "Email/RSS import done!"

