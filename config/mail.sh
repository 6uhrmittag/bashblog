#!\bin\bash

# funktioneiert schonmal, liefert alle items hintereinander:
# xml_grep --text_only "item/*"  mail.xml




feed=$(curl --silent "https://zapier.com/engine/rss/2528358/blogeintrag/")
echo $feed > mail.xml

phasedfeed=$(xml_grep "/*" mail.xml)
zahl=1
beitagscounter=0
#echo $phasedfeed

#Einträge zählen 
beitragscounter=$(xml_grep --count "rss//item/title" mail.xml | head -n 1 | cut -d: -f2 | tr -d '[:space:]')
echo "Beiträge gefunden: $beitragscounter"

beitrag=1
#Schleife für jeden Eintrag
while [ $beitrag -le $beitragscounter ];do
echo $beitrag


echo $(xml_grep --cond "/rss//item[$beitrag]/title" mail.xml)

beitrag=$(($beitrag+1))
done


#for item in {$phasedfeed}; do
#	if [ "$item" = '<item>' ];then
#	beitragsentry=1
#	eintrag=true
#	fi
#
#	while [ eintrag ]; do
#	beitrag["betragscounter]
#
#	fi
	

	
	
#echo "loop anfang"
#	beitrag[$zahl]=$item
#	echo "echo item:"
#	echo $item
#
#	echo "beitrag array:"
#	echo ${beitrag[$zahl]}
#	zahl=$(($zahl+1))
#	echo "loop ende"
#done



#echo "$beitrag[1]"
#echo "$beitrag[2]"
