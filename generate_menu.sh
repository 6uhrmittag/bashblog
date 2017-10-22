#!/bin/bash
#

#loadad config
path_config="./config/config.conf"
. $path_config

#relativ path to pages viewd from index.html
path_relativ_pages="./html/pages/"



#Generate menu
#Generate sub-menu:pages
touch $path_temp/menu_pages.html
echo "" > $path_temp/menu_pages.html

echo "<li>seiten</lis>" >> "$path_temp/menu_pages.html"
echo "    <ul>" >> "$path_temp/menu_pages.html"

for FILE in $(ls $path_pages); do
  url_text=$(echo $FILE | cut -d. -f1)
  url="$path_relativ_pages$FILE"

echo '        <li class="sub"><a href="'$url'" target="_blank">'$url_text'</a></li>' >> $path_temp/menu_pages.html
done
echo "    </ul>" >> "$path_temp/menu_pages.html"
echo "New links generated"
#rm $path_temp/menu_pages.html




#Generate sub-menu:links
touch $path_temp/menu_links.html
echo "" > $path_temp/menu_links.html

echo "<li>links</lis>" >> "$path_temp/menu_links.html"
echo "    <ul>" >> "$path_temp/menu_links.html"

for FILE in $(ls $path_menu_links); do
  url_text=$(echo $FILE)
 url=$(cat "$path_menu_links/$FILE" )
echo '        <li class="sub"><a href="'$url'" target="_blank">'$url_text'</a></li>' >> $path_temp/menu_links.html
done
echo "    </ul>" >> "$path_temp/menu_links.html"
echo "New links generated"
#rm $path_temp/menu_links.html
