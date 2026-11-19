#!/bin/bash


if test $1 == "--info"; then
  echo -e "Version: 0.2\t\tAuthor: Sparkle"
fi

if test $1 == "--help"; then
  # soon
fi


### Festlegen der Umgebung ###
if test $1 == "--zodiacon"; then

config_path="./zodiacon.conf"
image_path="./Desktop/ZodiaCon2022.jpg"
output_path="./Desktop/zodiacon_today.png"
convention=$( echo $1 | cut -d '-' -f3 )

fi

if test $1 == "--awoostria"; then

config_path="./awoostria.conf"
image_path="./Desktop/awoostria_clear.jpg"
output_path="./Desktop/awoostria_today.png"
convention=$( echo $1 | cut -d '-' -f3 )

fi

if [[ -z "$4" ]]; then
	echo -e "You Choose the custom mode."

  convention=$( echo $1 | cut -d '-' -f3 )
	config_path=$2
  image_path=$3
  output_path=$4

else
	outline_strong_t1=$4
fi



### Prüfen ob Config vorhanden ist
if [ -f "$config_path" ]; then

    echo echo -e "\nKonfiguration für $convention gefunden!\n"
	
else

    echo echo -e "\nKonfiguration für $convention fehlt!\n"
	exit 1
	
fi



### Auslesen der Variabeln ###
target_date=$( cat $config_path | grep value | cut -d ';' -f2 )
# Erster Text
position_t1=$( cat $config_path | grep value | cut -d ';' -f3 )
color_t1=$( cat $config_path | grep value | cut -d ';' -f4 )
outline_strong_t1=$( cat $config_path | grep value | cut -d ';' -f5 )
outline_color_t1=$( cat $config_path | grep value | cut -d ';' -f6 )
font_type_t1=$( cat $config_path | grep value | cut -d ';' -f7 )
font_size_t1a=$( cat $config_path | grep value | cut -d ';' -f8 )
font_size_t1b=$( cat $config_path | grep value | cut -d ';' -f9 )
center_point_t1=$( cat $config_path | grep value | cut -d ';' -f10 )

# Zweiter Text
content_t2=$( cat $config_path | grep value | cut -d ';' -f12 )
position_t2=$( cat $config_path | grep value | cut -d ';' -f13 )
color_t2=$( cat $config_path | grep value | cut -d ';' -f14 )
outline_strong_t2=$( cat $config_path | grep value | cut -d ';' -f15 )
outline_color_t2=$( cat $config_path | grep value | cut -d ';' -f16 )
font_type_t2=$( cat $config_path | grep value | cut -d ';' -f17 )
font_size_t2=$( cat $config_path | grep value | cut -d ';' -f18 )
center_point_t2=$( cat $config_path | grep value | cut -d ';' -f19 )

duration=$( echo -5 )



### Bildgenerierung ###
if [ -f "$image_path" ]; then

    echo "Ursprung existiert"
	days=$(( ($(date -d $target_date +%s) - $(date +%s)) / 86400 ))
	
	echo $days
	echo $duration
	
	
	if [ $days -gt 0 ]; then
	
		magick $image_path -gravity $center_point_t1 -font $font_type_t1 -pointsize $font_size_t1a -fill "$color_t1" -stroke "$outline_color_t1" -strokewidth "$outline_strong_t1" -annotate "$position_t1" "$days days left" $output_path
	
	fi
	
	if [ $days -lt 1 ] && [ $days -gt $duration ]; then
	
		magick $image_path -gravity $center_point_t1 -font $font_type_t1 -pointsize $font_size_t1b -fill "$color_t1" -stroke "$outline_color_t1" -strokewidth "$outline_strong_t1" -annotate "$position_t1" "Zodiaco is now running" $output_path
	
	fi
	
	if [ $days -lt $duration ]; then
	
		magick $image_path -gravity $center_point_t1 -font $font_type_t1 -pointsize $font_size_t1b -fill "$color_t1" -stroke "$outline_color_t1" -strokewidth "$outline_strong_t1" -annotate "$position_t1" "Zodiacon is now over" $output_path
	
	fi
	
	# Fußzeile generieren
	magick $output_path -gravity $center_point_t2 -font $font_type_t2 -pointsize $font_size_t2 -fill "$color_t2" -stroke "$outline_color_t2" -strokewidth "$outline_strong_t2" -annotate "$position_t2" "$content_t2" $output_path
	
else

    echo "Es existiert keine Ursprungsdatei unter dem angegebenen Pfad. Prozess daher nicht möglich"
	exit 2

fi



### Prüfen ob die letzte änderung der Datei jünger als 30 Sekunden ist ###
if [ $(( $(date +%s) - $(stat -c %Y "$output_path") )) -le 30 ]; then
    echo "Datei wurde erfolgreich geschrieben!"
else
    echo "Datei konnte nicht geschrieben werden!"
	exit 42
fi
