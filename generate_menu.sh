#!/bin/bash
#
#This Script generates a menu out of all existing pates and link files in /config/menu/links
#This Script is run by "bloggenerieren" and doesn't need to run manually
#to add a new link:
#1. add one file per url to /config/menu/links
#2. name the file like the link title
#3. insert the url into the file

#loadad config
path_config="./config/config.conf"
. $path_config

#relativ path to pages viewd from index.html
path_relativ_pages="./html/pages/"


#Generate FILE
touch $path_temp/menu.html
echo "" > $path_temp/menu.html

##Insert basic html structure to the beginning
echo '<nav>' >> $path_temp/menu.html
echo '' >> $path_temp/menu.html
echo '<div id="menu">' >> $path_temp/menu.html
echo '<ul id=menu_liste>' >> $path_temp/menu.html
echo '' >> $path_temp/menu.html


#Generate menu
#Generate sub-menu:pages
echo "<li>seiten</lis>" >> "$path_temp/menu.html"
echo "    <ul>" >> "$path_temp/menu.html"

for FILE in $(ls $path_pages); do
  url_text=$(echo $FILE | cut -d. -f1)
  url="$path_relativ_pages$FILE"
echo '        <li class="sub"><a href="'$url'" target="_self">'$url_text'</a></li>' >> $path_temp/menu.html
done
echo "    </ul>" >> "$path_temp/menu.html"
echo "pages links added"

#Generate sub-menu:links
echo "<li>links</lis>" >> "$path_temp/menu.html"
echo "    <ul>" >> "$path_temp/menu.html"

for FILE in $(ls $path_menu_links); do
  url_text=$(echo $FILE)
 url=$(cat "$path_menu_links/$FILE" )
echo '        <li class="sub"><a href="'$url'" target="_self">'$url_text'</a></li>' >> $path_temp/menu.html
done
echo "    </ul>" >> "$path_temp/menu.html"
echo "social links added"

##Insert basic html structure to the end
echo '' >> $path_temp/menu.html
echo '' >> $path_temp/menu.html
echo '</ul>' >> $path_temp/menu.html
echo '</div>' >> $path_temp/menu.html
echo '</nav>' >> $path_temp/menu.html
