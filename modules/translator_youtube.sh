#!/bin/bash
#This translator changes simple youtube URLs to youtube embedded html code
#It receives a url via function $url, generates an html entry code for the YT link and returns stores it in the variable $entry_after_translation"

#ToDo: It only works well with direct video links. lists or other links doesn't work proberly and produce a broken entry.
#variable "eintragstext" is still german because its used by "blogeintrag.sh" it's the entry text/title
#Usage:
#'source "thisfile"'
#'translator_youtube $url'
#'$entry=$entry_after_translation'
translator_youtube(){
local entry_before_translation="$1"


#if entry is an youtube url -> translate entry
#if entry is not an youtube url -> return unchanged entry
if [[ $(echo $entry_before_translation | grep youtube.com) != "" ]]; then
#echo "Youtube link found"

#extract youtube ID
#See: https://ubuntuforums.org/showthread.php?t=1966977
#echo "${entry_before_translation#*v=}"
youtube_id=$(echo $entry_before_translation  | sed -r 's/^.*[&?]v=(.{11})([&#].*)?$/\1/' )


#Generate html for entry
#For CSS see: https://css-tricks.com/NetMag/FluidWidthVideo/Article-FluidWidthVideo.php
entry_after_translation=$(cat<<EndOfMessage
<!-- EINTRAG ANFANG -->
<div class="eintrag">
      <div class="videotitle">
                  <span>$eintragstext</span>
      </div>

      <div class="YoutubeVideoWrapper">
        <iframe width="720" height="405" src="https://www.youtube.com/embed/$youtube_id"></iframe>
      </div>

      <div class="tags">
            $tags
      </div>
  <br />
</div>
<!-- EINTRAG ENDE -->
EndOfMessage
)

  else
  #If no youtube link, return unchanged input
  #echo "no youtube link found"
  entry_after_translation="$entry_before_translation"
fi

  echo $entry_after_translation
  return 0
}
