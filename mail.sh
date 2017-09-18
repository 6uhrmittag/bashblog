#!\bin\bash
#TODO: tags



feed=$(curl --silent "https://zapier.com/engine/rss/2528358/blogeintrag/")
echo $feed > mail.xml

phasedfeed=$(xml_grep "/*" mail.xml)
zahl=1
beitagscounter=0
#echo $phasedfeed

#Einträge zählen 
#beitragscounter=$(xml_grep --count "rss//item/title" mail.xml | head -n 1 | cut -d: -f2 | tr -d '[:space:]')
#echo "Beiträge gefunden: $beitragscounter"
beitragscounter=$(xmlstarlet sel -t -v "count(/rss//item/title)" mail.xml)
beitrag=1

#Schleife für jeden Eintrag
while [ $beitrag -le $beitragscounter ];do

eintragstext=$(xmlstarlet sel -t -m "/rss//item[$beitrag]/title" -v . -n mail.xml)
url=$(xmlstarlet sel -t -m "/rss//item[$beitrag]/link" -v . -n mail.xml)
#echo $(xmlstarlet sel -t -m "/rss//item[1]/description" -v . -n mail.xml | cut -d\; -f1)
#echo $(xmlstarlet sel -t -m "/rss//item[1]/description" -v . -n mail.xml | cut -d' ' -f2)
#echo $(xmlstarlet sel -t -m "/rss//item[1]/description" -v . -n mail.xml | cut -d' ' -f3)
#echo $(xmlstarlet sel -t -m "/rss//item[1]/description" -v . -n mail.xml | cut -d' ' -f4)
#echo $(xmlstarlet sel -t -m "/rss//item[$beitrag]/guid" -v . -n mail.xml)

. ./beitraggenerieren.sh

#echo $(xmlstarlet sel -t -m "/rss//item[$beitrag]/title" -v . -n mail.xml)
#echo $(xml_grep --cond "/rss//item[$beitrag]/title" mail.xml)

beitrag=$(($beitrag+1))
done


