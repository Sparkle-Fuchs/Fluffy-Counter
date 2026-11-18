#!/bin/bash

if [[ -z "$1" ]]; then
	echo "Error: Es muss mindestens ein Parameter angegeben werden! \nFür Hilfe --help"
	exit 1
fi

if test $1 == "--help"; then
	echo -e "Hilfe aufgerufen\n\n"
	echo -e "Folgende Parameter können angegeben werden:\n"
	echo -e "1. Convetion\t\t Hiermit wird die Convention ausgewählt, diese kann wie folgt angegeben werden: \"--zodiacon\""
	echo -e "2. Position\t\t Hiermit kann der Test in alle Richtungen verschoben werden- erster Wert Horizontal, zweiter Wert Vertikal. Beispiel \"+20+0\""
	echo -e "3. Text Color\t\t Hiermit kann die Farbe des Textes gewählt werden. Hierfür entweder Wörter oder den HEX-Code der Farbe verwenden z.B. \"black\" oder \"\#FF2500\"."
	echo -e "4. Outline\t\t Hiermit kann die Stärke der Outline definiert werden. Hierfür einfach einen Ganzzahl angeben. z.B 1."
	echo -e "5. Outline Color\t Hiermit kann die Farbe der Outline definiert werden. Hierfür entweder Wörter oder den HEX-Code der Farbe verwenden z.B. \"black\" oder \"\#FF2500\"."
	echo -e "6. Schriftart\t\t Hiermit kann die Schriftart definiert werden. Name der Schriftart angeben: z.B. \"DejaVu-Sans-Bold\"."
	echo -e "7. Schriftgröße\t\t Hiermit kann die Schriftgröße definiert werden. Hierfür einfach einen Ganzzahl angeben. z.B 96."
	echo -e "8. Anker\t\t Hiermit kann der Bezugspunkt ausgewählt werden. Verfügbar: center, east, south, west, north.\n"	
	echo -e "Beispiel: Fluffy-Counter.sh --zodiacon \"+7+50\" \"#a8a7a7\" 5 \"black\" \"DejaVu-Sans-Bold\" 96 \"east\"\n\n"
	exit 0
fi

if [[ -z "$2" ]]; then
	echo "Warning: Es wurde kein Versatz definiert, daher wird der Standardwert +0+0 verwendet."
	padding='+0+0'
else
	padding=$2
fi

if [[ -z "$3" ]]; then
	echo "Warning: Es wurde keine Farbe, daher wird der Standardwert Weiß verwendet."
	selected_color='#000000'
else
	selected_color=$3
fi

if [[ -z "$4" ]]; then
	echo "Warning: Es wurde keine Outlinestärte gewählt, dáher wird der Standardwert 1 verwendet."
	outline_strong='1'
else
	outline_strong=$4
fi

if [[ -z "$5" ]]; then
	echo "Warning: Es wurde keine Farbe für die Outline definiert, daher wird der Standardwert Schwarz verwendet."
	outline_color='black'
else
	outline_color=$5
fi

if [[ -z "$6" ]]; then
	echo "Warning: Es wurde keine Schriftart definiert, daher wird der Standardwert verwendet."
	font_type='DejaVu-Sans-Bold'
else
	font_type=$6
fi

if [[ -z "$7" ]]; then
	echo "Warning: Es wurde keine Schriftgröße definiert, daher wird der Standardwert 96 point verwendet."
	font_size='96'
else
	font_size=$7
fi

if [[ -z "$8" ]]; then
	echo "Warning: Es wurde kein Textanker definiert, daher wird der Standardwert east verwendet."
	center_poin='east'
else
	center_point=$8
fi

if test $1 == "--zodiacon"; then
	touch ./zodiacon_date
	target_date=$(cat ./zodiacon_date)
	days=$(( ($(date -d $target_date +%s) - $(date +%s)) / 86400 )); magick ./Desktop/ZodiaCon2022.jpg -gravity east -font $font_type -pointsize $font_size -fill "$selected_color" -stroke "$outline_color" -strokewidth "$outline_strong" -annotate "$padding" "$days days left" ./Desktop/zodiacon2.png
	
	if [ $? -eq 0 ]; then
		echo -e "\nBild generiert!\n"
	else
		echo echo -e "\nProzess fehlgeschlagen!\n"
	fi
fi
