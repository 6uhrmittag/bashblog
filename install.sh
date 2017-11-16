#!/bin/bash
#set -o errexit

#Check for Config-File
if [ ! -f ./config/config.conf ]; then
   printf 'Config File not found!\nPlease copy './config/config_template.conf' to './config/config.conf' and fill in the 2 first paths.'
   exit
fi

#Create File-Structure
source ./config/config.conf

folder=("$html_path/html/" "$html_path/html/entries" "$html_path/html/tags" "$html_path/html/pages" "$install_path/temp" "$html_path/config/" "$html_path/config/menu" "$html_path/config/menu/links")
for DIRECTORY in "${folder[@]}"; do
  mkdir $DIRECTORY
done


